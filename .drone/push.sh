#!/bin/bash

if ( -e .tmp/image.txt); then
    for $image in $(cat .tmp/images.txt); do
        docker push $image
    done
fi