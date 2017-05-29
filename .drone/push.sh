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

if [ -e .tmp/images.txt ]; then
    for image in $(cat .tmp/images.txt); do
        f_log INF "Push $image ..."
        docker push $image > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            f_log ERR "Push $image failed"
        else
            f_log SUC "Push $image successful"
        fi
    done
else
    f_log INF "No push for ${DOCKERFILE}"
fi