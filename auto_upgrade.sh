#!/bin/bash

dockerfiles_folder=$(pwd)
BUILD_VER=$(date +%Y%m%d01)


for image in $(ls -d */| grep -v unmaintained | grep -v wip); do
    if [ -e ${image}/auto_upgrade.sh ]; then
        cd ${dockerfiles_folder}/${image}
        ./auto_upgrade.sh
        cd ${dockerfiles_folder}  
    fi
done


find . -type f -name Dockerfile -not -path "./wip/*" -not -path "./unmaintained/*" -exec sed -i 's/build_ver=".*"/build_ver="'${BUILD_VER}'"/' {} \;