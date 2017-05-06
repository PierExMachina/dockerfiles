# Drone

> This image is build and push with [drone.io](https://github.com/drone/drone), a circle-ci like self-hosted.
> If you don't trust, you can build yourself.

## Tag available
* 0.5.0, 0.5, latest [(Dockerfile)](https://github.com/xataz/dockerfiles/tree/master/drone/Dockerfile)

## Description
What is [drone](https://github.com/drone/drone) ?

Drone is a Continuous Integration platform built on container technology. Every build is executed inside an ephemeral Docker container, giving developers complete control over their build environment with guaranteed isolation.

Browse the code at https://sourcegraph.com/github.com/drone/drone

**This image not contains root process**

## Build Image

```shell
docker build -t xataz/drone github.com/xataz/dockerfiles.git#master:drone
```

## Configuration
### Environments
* UID : Choose uid for launch transmission (default : 991)
* GID : Choose gid for launch transmission (default : 991)
* DRONE_DATABASE_DRIVER : Database type (default : sqlite3)
* DRONE_DATABASE_DATASOURCE : Database Path (default : /config/drone.db)
* SERVER_OR_AGENT : Run drone as server or agent (default : server)
* GIN_MODE : Debug mode, debug or release (default : release)

Use [environment variable](http://readme.drone.io/admin/installation-reference/) for configure drone.

### Volumes
* /config : database path

### Ports
* 8000

## Usage
### github example
```shell
docker run -d -p 8080:8000 \
	-e UID=1001 \
	-e GID=1001 \
    -e DRONE_GITHUB=true \
    -e DRONE_GITHUB_SECRET=yoursecretkey \
    -e DRONE_GITHUB_CLIENT=yourclientkey \
	-v /docker/config/drone:/config \
	xataz/drone
```
URI access : http://XX.XX.XX.XX:8080

## Contributing
Any contributions, are very welcome !