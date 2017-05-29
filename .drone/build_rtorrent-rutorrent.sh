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


# Build rtorrent-rutorrent
f_log INF "Build ${USER}/rtorrent-rutorrent:latest ..."
docker build -t ${USER}/rtorrent-rutorrent:latest rtorrent-rutorrent > /tmp/build.log 2>&1
if [ $? -eq 0 ]; then
    f_log SUC "Build ${USER}/rtorrent-rutorrent:latest successful"
    echo ${USER}/rtorrent-rutorrent:latest >> .tmp/images.txt
else
    f_log ERR "Build ${USER}/rtorrent-rutorrent:latest failed"
    cat /tmp/build.log
    exit 1
fi

f_log INF "Build ${USER}/rtorrent-rutorrent:filebot ..."
docker build --build-arg WITH_FILEBOT=YES -t ${USER}/rtorrent-rutorrent:filebot rtorrent-rutorrent > /tmp/build.log 2>&1
if [ $? -eq 0 ]; then
    f_log SUC "Build ${USER}/rtorrent-rutorrent:filebot successful"
    docker tag ${USER}/rtorrent-rutorrent:filebot ${USER}/rtorrent-rutorrent:latest-filebot
    echo ${USER}/rtorrent-rutorrent:filebot >> .tmp/images.txt
    echo ${USER}/rtorrent-rutorrent:latest-filebot >> .tmp/images.txt
else
    f_log ERR "Build ${USER}/rtorrent-rutorrent:filebot failed"
    cat /tmp/build.log
    exit 1
fi
