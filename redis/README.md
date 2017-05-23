![](https://upload.wikimedia.org/wikipedia/en/thumb/6/6b/Redis_Logo.svg/467px-Redis_Logo.svg.png)

> This image is build and push with [drone.io](https://github.com/drone/drone), a circle-ci like self-hosted.
> If you don't trust, you can build yourself.

## Tag available
* latest, stable, 3.2.9, 3.2, 3 [(Dockerfile)](https://github.com/xataz/dockerfiles/blob/master/redis/stable/Dockerfile)
* latest-cli stable-cli 3.2.9-cli 3.2-cli 3-cli [(Dockerfile)](https://github.com/xataz/dockerfiles/blob/master/redis/stable-cli/Dockerfile)
* unstable [(Dockerfile)](https://github.com/xataz/dockerfiles/blob/master/redis/unstable/Dockerfile)
* unstable-cli [(Dockerfile)](https://github.com/xataz/dockerfiles/blob/master/redis/unstable-cli/Dockerfile)

## Description
What is [Redis](http://redis.io/)?

edis is an open source (BSD licensed), in-memory data structure store, used as database, cache and message broker. It supports data structures such as strings, hashes, lists, sets, sorted sets with range queries, bitmaps, hyperloglogs and geospatial indexes with radius queries. Redis has built-in replication, Lua scripting, LRU eviction, transactions and different levels of on-disk persistence, and provides high availability via Redis Sentinel and automatic partitioning with Redis Cluster.

**This image not contains root process**

## Build Image

```shell
docker build -t xataz/redis github.com/xataz/dockerfiles.git#master:redis/stable
```

### Build other version
```shell
docker build -t xataz/redis --build-arg REDIS_VER=3.0.5 github.com/xataz/dockerfiles.git#master:redis/stable
```

## Configuration
### Environments
* UID : Choose uid for launch redis (default : 991)
* GID : Choose gid for launch redis (default : 991)

### Volumes
* /var/lib/redis : Home for redis

### Ports
* 6379 

## Usage
### Server launch
```shell
docker run -d \
    --name redis \
	-p 6379:6379 \
	-v /docker/config/redis:/var/lib/redis \
	xataz/redis:3
```

### Cli usage
```shell
docker run -ti --rm \
        --link redis:redis \
	xataz/redis-cli:3 -h redis ping
```

## Contributing
Any contributions, are very welcome !
