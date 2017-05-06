![](http://readme.drone.io/logos/downstream.svg)

> This image is build and push with [drone.io](https://github.com/drone/drone), a circle-ci like self-hosted.
> If you don't trust, you can build yourself.

## Tag available
* latest, 1.13.1, 1.13 [(Dockerfile)](https://github.com/xataz/dockerfiles/tree/master/drone-docker/Dockerfile)

## Description
What is [docker-client](https://github.com/xataz/dockerfiles/tree/master/docker-client/)

docker-client is a docker image, based on alpine 3.5 with all tools for build your image.

## Build Image
```shell
docker build -t xataz/drone-docker github.com/xataz/dockerfiles.git#master:drone-docker
```

## Configuration
### Build arguments
* DOCKER_VER : Docker version (default : 1.13.1)


## Usage
[Drone.io](https://github.com/drone/drone) use a git repository for works, please refer to [Setup guide](http://readme.drone.io/setup/overview/).

Add `.drone.yml` and `build.sh` on your repository.

In `.drone.yml`, add volumes and commands to execute.
In `build.sh`, add a script for build your docker's images.
### build.sh examples :
```shell
#!/bin/bash

REPO='https://gogs.boxobox.xyz/xataz/dockerfiles.git'
BRANCH='master'
USER='xataz'
DOCKER_PUSH=$1

CSI="\033["
CEND="${CSI}0m"
CRED="${CSI}1;31m"
CGREEN="${CSI}1;32m"
CYELLOW="${CSI}1;33m"
CBLUE="${CSI}1;34m"

git fetch -q "$REPO" "refs/heads/$BRANCH"

for f in $(git diff HEAD~ --diff-filter=ACMRTUX --name-only | cut -d"/" -f1 | uniq); do
    if [ -d $f ]; then
        if [ -e $f/build.sh ]; then
            chmod +x $f/build.sh
            echo 
            ./$f/build.sh $DOCKER_PUSH
        else
            for dockerfile in $(find $f -name Dockerfile); do
                FOLDER=$(dirname $dockerfile)
                LOG_FILE="/tmp/${f}_$(date +%Y%m%d).log"
                echo -e "Build $dockerfile with context $FOLDER on tmp-build [${CYELLOW}..${CEND}]"
                docker build -f $dockerfile -t tmp-build $FOLDER > $LOG_FILE 2>&1
                if [ $? != 0 ]; then
                    echo -e "Build $dockerfile with context $FOLDER on tmp-build [${CRED}KO${CEND}]"
                    cat $LOG_FILE
                else
                    echo -e "Build $dockerfile with context $FOLDER on tmp-build [${CGREEN}OK${CEND}]"
                    for tag in $(grep "tags=" $dockerfile | cut -d'"' -f2); do
                        echo -e "Tags tmp-build to ${USER}/${f}:${tag} [${CYELLOW}..${CEND}]"
                        docker tag tmp-build ${USER}/${f}:${tag}
                        if [ $? != 0 ]; then
                            echo -e "Tags tmp-build to ${USER}/${f}:${tag} [${CRED}KO${CEND}]"
                        else
                            echo -e "Tags tmp-build to ${USER}/${f}:${tag} [${CGREEN}OK${CEND}]"
                            if [ "$DOCKER_PUSH" == "push" ]; then
                                echo -e "Push ${USER}/${f}:${tag} [${CYELLOW}..${CEND}]"
                                docker push ${USER}/${f}:${tag} > $LOG_FILE 2>&1
                                if [ $? != 0 ]; then
                                    echo -e "Push ${USER}/${f}:${tag} [${CRED}KO${CEND}]"
                                    cat $LOG_FILE
                                else
                                    echo -e "Push ${USER}/${f}:${tag} [${CGREEN}OK${CEND}]"
                                fi
                            fi
                        fi
                    done
                fi
            done
            docker images | grep tmp-build > /dev/null 2>&1
            if [ $? -eq 0 ]; then docker rmi tmp-build; fi
        fi
        
    fi
done

```

### .drone.yml examples
```yaml
build:
  image: xataz/drone-docker:1.9.1
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock
    - /home/$USER/.docker/config.json:/root/.docker/config.json
  commands:
    - chmod +x build.sh
    - ./build.sh push
```

## Contributing
Any contributions, are very welcome !