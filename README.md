# dockerfiles

## What ?
In this repository, you will find lots of dockerfiles, with a philosophy of being as light as possible, easy to use, and secure (minimal root process).

Most dockerfiles, are based on [alpine Linux](http://alpinelinux.org/), which is a very light GNU/Linux distribution.

## Build
Now, all my images is build and push with [drone.io](https://github.com/drone/drone), a circle-ci like self-hosted.
If you don't trust, you can build yourself images. Instructions are on README.

## Contributing
Any contributions, are very welcome !

### How to
* Fork this project
* Create a branch for your feature
* Edit .drone.yml, and edit _matrix_ value with list of modify images (for drone's build)
* Create Pull Request
