# Cardigann

> This image is build and push with [drone.io](https://github.com/drone/drone), a circle-ci like self-hosted.
> Automated build is disable in this repo.
> If you don't trust, you can build yourself.

## Tag available
* latest [(Dockerfile)](https://github.com/xataz/dockerfiles/tree/master/cardigann/Dockerfile)

## Description
What is [Cardigann](https://github.com/cardigann/cardigann) ?

A server for adding extra indexers to Sonarr, SickRage and CouchPotato via Torznab and TorrentPotato proxies. Behind the scenes Cardigann logs in and runs searches and then transforms the results into a compatible format.

Cardigann is implemented in golang, which means it's simply a single binary to execute/install, no runtime. Windows, Linux and OSX will be supported, although it should run on any platform that golang supports.

## Build Image

```shell
docker build -t xataz/cardigann github.com/xataz/dockerfiles.git#master:cardigann
```

## Configuration
### Environments
* UID : Choose uid for launch cardigannn (default : 991)
* GID : Choose gid for launch cardigannn (default : 991)

### Volumes
* /home/cardigann/.config/cardigann/ : Path where is configuration files 

### Ports
* 5060

## Usage
### Speed launch
```shell
docker run -d -p 5060:5060 xataz/cardigann
```
URI access : http://XX.XX.XX.XX:5060

### Advanced launch
```shell
docker run -d -p 8080:5060 \
	-e WEBROOT=/tbt \
	-e UID=1001 \
	-e GID=1001 \
	-v /docker/config/cardigann:/home/cardigann/.config/cardigann/ \
	xataz/cardigannn
```
URI access : http://XX.XX.XX.XX:8080

## Contributing
Any contributions, are very welcome !