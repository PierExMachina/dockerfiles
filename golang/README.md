![Golang](https://blog.golang.org/gopher/gopher.png)

> This image is build and push with [drone.io](https://github.com/drone/drone), a circle-ci like self-hosted.
> If you don't trust, you can build yourself.

## Tag available
* latest, 1.8.3, 1.8, 1 [(Dockerfile)](https://github.com/xataz/dockerfiles/blob/master/golang/Dockerfile)

## Description
What is [Golang](https://golang.org/) ?

Go is an open source programming language that makes it easy to build simple, reliable, and efficient software. 

**This image not contains root process**

## Build Image
### Build arguments
* GO_VER : Golang version (default : 1.8.3)
* GLIBC_VER : GLIBC version (default : 2.25-r0)
* GO_URL : URL of golang (default : https://storage.googleapis.com/golang/go${GO_VER}.linux-amd64.tar.gz)
* GLIBC_URL : URL of glibc for alpine (default : https://github.com/andyshinn/alpine-pkg-glibc/releases/download/unreleased)

### Simply build
```shell
docker build -t xataz/golang:1.7 github.com/xataz/dockerfiles.git#master:golang
```

### Build other version
```shell
docker build -t xataz/golang:1.5.4 --build-arg GO_VER=1.5.4 github.com/xataz/dockerfiles.git#master:golang
```

## Configuration
### Environments
* UID : Choose uid for launch go (default : 991)
* GID : Choose gid for launch go (default : 991)

## Usage
### Build your project
```shell
docker run -it --rm \
    -v $(pwd):/usr/app/src \
    -w /usr/app/src \
    -e UID=$(id -u) \
    -e GID=$(id -g) \
    xataz/golang:1 build
```

### Create alias
```shell
alias go1.6='docker run -ti --rm \
            -v $(pwd):/usr/app/src \
            -w /usr/app/src \
            -e UID=$(id -u) \
            -e GID=$(id -g) \
            xataz/golang:1.6'
```

## Contributing
Any contributions, are very welcome !