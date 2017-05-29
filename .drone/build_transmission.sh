#!/bin/bash

## Variables
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


# Build transmission
f_log INF "Build ${USER}/transmission:latest ..."
docker build -t ${USER}/transmission:latest transmission > /tmp/build.log 2>&1
if [ $? -eq 0 ]; then
    f_log SUC "Build ${USER}/transmission:latest successful"
    echo ${USER}/transmission:latest >> .tmp/images.txt
else
    f_log ERR "Build ${USER}/transmission:latest failed"
    cat /tmp/build.log
    exit 1
fi

f_log INF "Build ${USER}/transmission:filebot ..."
docker build --build-arg WITH_FILEBOT=YES -t ${USER}/transmission:filebot transmission > /tmp/build.log 2>&1
if [ $? -eq 0 ]; then
    f_log SUC "Build ${USER}/transmission:filebot successful"
    docker tag ${USER}/transmission:filebot ${USER}/transmission:latest-filebot
    echo ${USER}/transmission:filebot >> .tmp/images.txt
    echo ${USER}/transmission:latest-filebot >> .tmp/images.txt
else
    f_log ERR "Build ${USER}/transmission:filebot failed"
    cat /tmp/build.log
    exit 1
fi
