#!/bin/bash

MONIT_VER=$(grep "MONIT_VER=" Dockerfile | cut -d"=" -f2)
NEW_MONIT_VER=$(curl https://mmonit.com/monit/#download 2> /dev/null | grep "Downloads</h3>" | sed 's|^.*Monit \(.*\) Downloads.*$|\1|')


f_gen_tag() {
    VERSION=$1

    TAGS="latest stable ${VERSION} $(echo ${VERSION} | cut -d'.' -f '1 2') $(echo ${VERSION} | cut -d'.' -f '1')"
    TAGS_CLI="latest-cli stable-cli ${VERSION}-cli $(echo ${VERSION} | cut -d'.' -f '1 2')-cli $(echo ${VERSION} | cut -d'.' -f '1')-cli"
}

f_maj_dockerfile() {
    BUILD_VER=$(date +%Y%m%d01)

    ## Edit dockerfile
    sed -i 's/MONIT_VER=.*/MONIT_VER='${NEW_MONIT_VER}'/;
        s/tags=".*"/tags="'"${TAGS}"'"/;
        s/build_ver=".*"/build_ver="'${BUILD_VER}'"/' Dockerfile
}

f_maj_readme() {
    VERSION=$1
    TAGS=$(echo $TAGS | sed 's/ /, /g')

    sed -i 's#\* .*Dockerfile)#\* '"${TAGS}"' \[(Dockerfile)\](https://github.com/xataz/dockerfiles/blob/master/monit/Dockerfile)#' README.md
}

if [ "${MONIT_VER}" != "${NEW_MONIT_VER}" ]; then
    echo "Update monit to ${NEW_MONIT_VER}"
    f_gen_tag ${NEW_MONIT_VER}
    f_maj_dockerfile
    f_maj_readme
fi