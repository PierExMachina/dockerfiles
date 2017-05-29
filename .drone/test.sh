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
        if [ -e .drone/test_${DOCKERFILE}.sh ]; then
            chmod +x .drone/test_${DOCKERFILE}.sh
            .drone/test_${DOCKERFILE}.sh
        else
            f_log INF "Run container of ${image}"
            docker run -d -P --name test-container ${image}
            sleep 30
            f_log INF "Test if container is running"
            docker ps | grep test-container > /dev/null 2>&1
            if [ $? -ne 0 ]; then
                docker rm -f test-container > /dev/null 2>&1
                f_log ERR "The container is not running"
                exit 1
            else
                f_log SUC "The container is running"
                for port in $(docker inspect --format='{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}' test-container | awk '{print $3}'); do
                    f_log INF "Test if port $port is exposed"
                    curl $(docker inspect --format='{{.NetworkSettings.IPAddress}}' test-container):$port > /dev/null 2>&1
                    if [ $? -ne 0 ]; then
                        docker rm -f test-container > /dev/null 2>&1
                        f_log ERR "The port $port is not exposed"
                        exit 1
                    else
                        f_log SUC "The port $port is exposed"
                    fi
                done
            fi

            docker rm -f test-container > /dev/null 2>&1
            f_log SUC "successful"
        fi
    done
else
    f_log INF "No test for ${DOCKERFILE}"
fi