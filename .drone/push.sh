#!/bin/bash

for $image in $(cat .tmp/images.txt); do
    docker push $image
done