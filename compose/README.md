![docker-compose](https://raw.githubusercontent.com/docker/compose/master/logo.png)

> This image is build and push with [drone.io](https://github.com/drone/drone), a circle-ci like self-hosted.
> If you don't trust, you can build yourself.

## Tag available
* latest, 1.12.0, 1.12, 1 [(Dockerfile)](https://github.com/xataz/dockerfiles/blob/master/compose/Dockerfile)

## Description
What is [docker-compose](https://github.com/docker/compose) ?

Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a Compose file to configure your application's services. Then, using a single command, you create and start all the services from your configuration.

**This image not contains root process**

## Build Image

```shell
docker build -t xataz/compose github.com/xataz/dockerfiles.git#master:compose
```
### Build other version
```shell
docker build -t xataz/compose --build-arg COMPOSE_VER=1.6.2 github.com/xataz/dockerfiles.git#master:compose
```

## Configuration
### Environments
* UID : Choose uid for launch compose (default : 991)
* GID : Choose gid for launch compose (default : 991) (use docker group gid)

## Usage
### Build your project
```shell
docker run -it --rm \
    -v $(pwd):$(pwd) \
    -w $(pwd) \
    -e UID=$(id -u) \
    -e GID=$(id -g) \
    xataz/compose:1.8.0 up -d
```

### Alias for .(shell)rc
```shell
alias compose='docker run -it --rm \
        -v $(pwd):/usr/app \
        -w /usr/app \
        -e UID=$(id -u) \
        -e GID=$(id -g) \
        xataz/compose:1.8.0'
```

## Contributing
Any contributions, are very welcome !