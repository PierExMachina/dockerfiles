#!/bin/bash

REPO='https://github.com/xataz/dockerfiles'
BRANCH='master'
USER='xataz'
DOCKERFILE=$1
ERROR=0

CSI="\033["
CEND="${CSI}0m"
CRED="${CSI}1;31m"
CGREEN="${CSI}1;32m"
CYELLOW="${CSI}1;33m"
CBLUE="${CSI}1;34m"


## Functions
f_log() {
    TYPE=$1
    MSG=$2

    if [ "${TYPE}" == "ERR" ]; then
        COLOR=${CRED}
    elif [ "${TYPE}" == "INF" ]; then
        COLOR=${CBLUE}
    elif [ "${TYPE}" == "WRN" ]; then
        COLOR=${CYELLOW}
    elif [ "${TYPE}" == "SUC" ]; then
        COLOR=${CGREEN}
    else
        COLOR=${CEND}
    fi

    echo -e "${COLOR}=${TYPE}= $TIMENOW : ${MSG}${CEND}"
}

docker pull xataz/alpine:3.6
docker pull xataz/node:7

git fetch -q "$REPO" "refs/heads/$BRANCH"

mkdir .tmp

for f in $(git diff HEAD~ --diff-filter=ACMRTUX --name-only | cut -d"/" -f1 | grep -v wip | grep -v unmaintained | grep -v .drone | uniq); do
    if [ $f == ${DOCKERFILE} ]; then
        if [ -e .drone/build_${DOCKERFILE}.sh ]; then
            chmod +x .drone/build_${DOCKERFILE}.sh
            .drone/build_${DOCKERFILE}.sh
        else
            for dockerfile in $(find $f -name Dockerfile); do
                FOLDER=$(dirname $dockerfile)
                LOG_FILE="/tmp/${f}_$(date +%Y%m%d).log"
                f_log INF "Build $dockerfile with context $FOLDER on tmp-build-$f ..."
                docker build -f $dockerfile -t tmp-build-$f $FOLDER > $LOG_FILE 2>&1
                if [ $? != 0 ]; then
                    f_log ERR "Build $dockerfile with context $FOLDER on tmp-build-$f failed"
                    ERROR=1
                    cat $LOG_FILE
                else
                    f_log SUC "Build $dockerfile with context $FOLDER on tmp-build-$f successful"
                    for tag in $(grep "tags=" $dockerfile | cut -d'"' -f2); do
                        f_log INF "Tags tmp-build-$f to ${USER}/${f}:${tag} ..."
                        docker tag tmp-build-$f ${USER}/${f}:${tag} > $LOG_FILE 2>&1
                        if [ $? != 0 ]; then
                            f_log ERR "Tags tmp-build-$f to ${USER}/${f}:${tag} failed"
                            ERROR=1
                        else
                            f_log SUC "Tags tmp-build-$f to ${USER}/${f}:${tag} successful"
                            echo ${USER}/${f}:${tag} >> .tmp/images.txt
                        fi
                    done
                fi
            done
            docker images | grep tmp-build-$f > /dev/null 2>&1
            if [ $? -eq 0 ]; then docker rmi tmp-build-$f; fi
        fi  
    else
        f_log INF "No build for ${DOCKERFILE}"
    fi
done

if [ ${ERROR} -gt 0 ]; then
    exit 1
fi
