#!/bin/bash

## Variables

CSI="\033["
CEND="${CSI}0m"
CRED="${CSI}1;31m"
CGREEN="${CSI}1;32m"
CYELLOW="${CSI}1;33m"
CBLUE="${CSI}1;34m"
FOLDER=$(dirname $0)


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

f_usage() {
    echo "usage : ./build.sh [IMAGE_NAME]"
}

if [ $# -ne 1 ]; then
    f_log ERR "Usage error"
    f_usage
    exit 1
else
    IMAGE_NAME=$1
fi

# Build transmission
f_log INF "Build ${IMAGE_NAME}:latest ..."
docker build -t ${IMAGE_NAME}:latest $FOLDER
if [ $? -eq 0 ]; then
    f_log SUC "Build ${IMAGE_NAME}:latest successful"
else
    f_log ERR "Build ${IMAGE_NAME}:latest failed"
    exit 1
fi

f_log INF "Build ${IMAGE_NAME}:filebot ..."
docker build --build-arg WITH_FILEBOT=YES -t ${IMAGE_NAME}:filebot ${FOLDER}
if [ $? -eq 0 ]; then
    f_log SUC "Build ${IMAGE_NAME}:filebot successful"
    docker tag ${IMAGE_NAME}:filebot ${IMAGE_NAME}:latest-filebot
else
    f_log ERR "Build ${IMAGE_NAME}:filebot failed"
    exit 1
fi
