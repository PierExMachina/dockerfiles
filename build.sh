#!/bin/bash
####
####

## Variables

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

f_usage() {
    echo "usage : ./build.sh [IMAGE_FOLDER] [IMAGE_NAME]"
}

if [ $# -ne 2 ]; then
    f_log ERR "Usage error"
    f_usage
    exit 1
else
    IMAGE=$1
    IMAGE_NAME=$2
fi

if [ -d ${IMAGE} ]; then
    if [ -e ${IMAGE}/build.sh ]; then
        chmod +x ${IMAGE}/build.sh
        f_log INF "Build ${IMAGE} with ${IMAGE}/build.sh ..."
        ./${IMAGE}/build.sh ${IMAGE_NAME}
        if [ $? -ne 0 ]; then
            f_log ERR "Build ${IMAGE} failed"
            exit 1
        fi
    else
        for dockerfile in $(find ${IMAGE} -name Dockerfile); do
            FOLDER=$(dirname $dockerfile)
            f_log INF "Build ${IMAGE} with context $FOLDER on tmp-build-${IMAGE} ..."
            docker build -f ${dockerfile} -t tmp-build-${IMAGE} ${FOLDER}
            if [ $? != 0 ]; then
                f_log ERR "Build $dockerfile with context $FOLDER on tmp-build-${IMAGE} failed"
                exit 1
            else
                f_log SUC "Build $dockerfile with context $FOLDER on tmp-build-${IMAGE} successful"
                for tag in $(grep "tags=" $dockerfile | cut -d'"' -f2); do
                    f_log INF "Tags tmp-build-${IMAGE} to ${IMAGE_NAME}:${tag} ..."
                    docker tag tmp-build-${IMAGE} ${IMAGE_NAME}:${tag}
                    if [ $? != 0 ]; then
                        f_log ERR "Tags tmp-build-${IMAGE} to ${IMAGE_NAME}:${tag} failed"
                        exit 1
                    else
                        f_log SUC "Tags tmp-build-${IMAGE} to ${IMAGE_NAME}:${tag} successful"
                    fi
                done
            fi
        done
    fi

    docker images | grep tmp-build-${IMAGE} > /dev/null 2>&1
    if [ $? -eq 0 ]; then docker rmi tmp-build-${IMAGE}; fi
else
    f_log ERR "${IMAGE} not found"
    exit 1
fi