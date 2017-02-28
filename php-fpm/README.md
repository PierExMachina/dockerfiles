![](http://php.net/manual/fr/images/c0d23d2d6769e53e24a1b3136c064577-php_logo.png)

> This image is build and push with [drone.io](https://github.com/drone/drone), a circle-ci like self-hosted.
> If you don't trust, you can build yourself.

## Tag available
* latest, 7.1.2, 7.1, 7 [(Dockerfile)](https://github.com/xataz/dockerfiles/blob/master/php-fpm/Dockerfile)

## Description
What is [PHP](https://secure.php.net/)?

PHP is a popular general-purpose scripting language that is especially suited to web development.
Fast, flexible and pragmatic, PHP powers everything from your blog to the most popular websites in the world.

**This image not contains root process**

## Build Image
### Build arguments
* PHP_VER : PHP version (default : 7.1.2)
* PHP_MIRROR : PHP mirror (default : http://fr2.php.net)
* PHP_GPG : GPG fingerprint (default : 1A4E8B7277C42E53DBA9C7B9BCAA30EA9C0D5763)
* PHP_CONF : PHP make configure options 
* PHP_EXT_LIST : PHP extensions list, for install there (default : empty)
* CUSTOM_BUILD_PKGS : Necessary packages for build PHP extension, there packages are remove after build (default : empty)
* CUSTOM_PKGS : Necessary package for PHP extension (default : empty)
* CORES_BUILD : Number of core use for make PHP (default : All cores)

### Simple build
```shell
$ docker build -t xataz/php-fpm:7.0.12 github.com/xataz/dockerfiles.git#master:php
```

### Build with arguments
Example : Install gd, mysqli and gmp extensions :
```shell
$ docker build -t xataz/php-fpm:myversion \
    --build-arg PHP_EXT_LIST="gd mysqli gmp" \
    --build-arg CUSTOM_BUILD_PKGS="freetype-dev gmp-dev" \
    --build-arg CUSTOM_PKGS="freetype gmp" \
    --build-arg PHP_VER=7.0.10 github.com/xataz/dockerfiles.git#master:php
```

## Configuration
### Environments
* UID : Choose uid for launch nginx (default : 991)
* GID : Choose gid for launch nginx (default : 991)

### Volumes
* /php/php-fpm.d/ : Custom configuration
* /php/conf.d : Extension ini file

### Ports
* 9000

## Usage
### Advanced launch
```shell
$ docker run -d --name php \
        -e UID=$(id -u) \
        -e GID=$(id -g) \
        -v /docker/php/php-fpm.d/:/php/php-fpm.d \
        -v /docker/nginx/www:/nginx/www \
        xataz/php-fpm:7
```

## Contributing
Any contributions, are very welcome !