#!/bin/bash

REPO='https://github.com/xataz/dockerfiles'
BRANCH='master'
USER='xataz'
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


# NETWORK=nt_$(date +%Y%m%d)

# docker rm -f nginx_test reverse_test
# docker network rm ${NETWORK}

# f_log INF "Create network ..."
# docker network create ${NETWORK}
# if [ $? -eq 0 ]; then
#   f_log SUC "Create network successful"
# else
#   f_log ERR "Create network failed"
#   exit 1
# fi

# f_log INF "Run nginx ..."
# docker run -d --label reverse.backend.port=8080 --label reverse.frontend.domain=docker.local --network test --name nginx_test xataz/nginx
# if [ $? -eq 0 ]; then
#   f_log SUC "Run nginx successful"
# else
#   f_log ERR "Run nginx failed"
#   exit 1
# fi

# f_log INF "Run reverse-nginx ..."
# docker run -d --name reverse_test --network test xataz/reverse-nginx
# if [ $? -eq 0 ]; then
#   f_log SUC "Run reverse-nginx successful"
# else
#   f_log ERR "Run reverse-nginx failed"
#   exit 1
# fi

# sleep 30
# f_log INF "Try curl on reverse-nginx ..."
# curl $(docker inspect --format='{{.NetworkSettings.IPAddress}}' reverse_test):8080
# if [ $? -eq 0 ]; then
#   f_log SUC "Try curl on reverse-nginx successful"
# else
#   f_log ERR "Try curl on reverse-nginx failed"
#   exit 1
# fi

# f_log INF "Delete nginx && reverse-nginx ..."
# docker rm -f nginx_test reverse_test >
# if [ $? -eq 0 ]; then
#   f_log SUC "Delete container successful"
# else
#   f_log ERR "Delete container failed"
#   exit 1
# fi

# f_log INF "Delete network ..."
# docker network rm ${NETWORK} > /dev/null 2>&1
# if [ $? -eq 0 ]; then
#   f_log SUC "Delete network successful"
# else
#   f_log ERR "Delete network failed"
#   exit 1
# fi
