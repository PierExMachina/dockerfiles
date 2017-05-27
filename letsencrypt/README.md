# Letsencrypt lite

> This image is build and push with [drone.io](https://github.com/drone/drone), a circle-ci like self-hosted.
> Automated build is disable in this repo.
> If you don't trust, you can build yourself.

## Tag available
* latest, 0.14.2, 0.14 [(Dockerfile)](https://github.com/xataz/dockerfiles/tree/master/letsencrypt/Dockerfile)

## Description
What is [letsencrypt](https://github.com/certbot/certbot) ?

Letsencrypt rename to certbot.

Certbot is part of EFF’s effort to encrypt the entire Internet. Secure communication over the Web relies on HTTPS, which requires the use of a digital certificate that lets browsers verify the identify of web servers (e.g., is that really google.com?). Web servers obtain their certificates from trusted third parties called certificate authorities (CAs). Certbot is an easy-to-use client that fetches a certificate from Let’s Encrypt—an open certificate authority launched by the EFF, Mozilla, and others—and deploys it to a web server.

Anyone who has gone through the trouble of setting up a secure website knows what a hassle getting and maintaining a certificate is. Certbot and Let’s Encrypt can automate away the pain and let you turn on and manage HTTPS with simple commands. Using Certbot and Let's Encrypt is free, so there’s no need to arrange payment.

How you use Certbot depends on the configuration of your web server. The best way to get started is to use our interactive guide. It generates instructions based on your configuration settings. In most cases, you’ll need root or administrator access to your web server to run Certbot.

If you’re using a hosted service and don’t have direct access to your web server, you might not be able to use Certbot. Check with your hosting provider for documentation about uploading certificates or using certificates issues by Let’s Encrypt.

Certbot is a fully-featured, extensible client for the Let's Encrypt CA (or any other CA that speaks the ACME protocol) that can automate the tasks of obtaining certificates and configuring webservers to use them. This client runs on Unix-based operating systems.

Until May 2016, Certbot was named simply letsencrypt or letsencrypt-auto, depending on install method. Instructions on the Internet, and some pieces of the software, may still refer to this older name.

## Build Image
### Build arguments
* CERTBOT_VER : Version of certbot (default : v0.14.2)

### Build
```shell
docker build -t xataz/letsencrypt github.com/xataz/dockerfiles.git#master:letsencrypt
```

### Build other Version
```shell
docker build -t xataz/letsencrypt:0.7.0 --build-arg CERTBOT_VER=v0.7.0 github.com/xataz/dockerfiles.git#master:letsencrypt
```


## Usage
### Create a project folder
```shell
$ mkdir /etc/letsencrypt
```

### Generate a certificate with letsencrypt's webserver
```shell
docker run -it --rm \
	-v /etc/letsencrypt:/etc/letsencrypt \
	-p 80:80 -p 443:443 \
	xataz/letsencrypt \
		certonly --standalone \
		--agree-tos \
		-m me@myorg.org \
		-d www.myorg.org \
		-d blog.myorg.org
```

### Generate a certificate with webroot
```shell
docker run -it --rm \
	-v /etc/letsencrypt:/etc/letsencrypt \
	-v /var/www/:/var/www xataz/letsencrypt \
		certonly --webroot \
		--agree-tos \
		-m me@myorg.org \
		-w /var/www \
		-d www.myorg.org \
		-d blog.myorg.org \
		-w /var/www/webmail \
		-d webmail.myorg.org \
		-d mail.myorg.org
```

## Troubleshooting
If you have an error while the generating certs, please build this image yourself. letsencrypt is frequently updated (several time a day).

## Contributing
Any contributions, are very welcome !
