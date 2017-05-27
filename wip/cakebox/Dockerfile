FROM xataz/alpine:3.6

ENV UID=991 \
    GID=991 \
    WEBROOT=/ \
    URI=http://www.domaine.com \
    USERNAME=user

LABEL Description="cakebox based on alpine" \
      tags="latest" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017032801"

RUN export BUILD_DEPS="git \
                        make \
                        gcc \
                        g++ \
                        python \
                        linux-headers \
                        wget \
                        curl \
                        ca-certificates \
                        nodejs" \
    && apk add -U ${BUILD_DEPS} \
                gzip \
                zip \
                unrar \
                su-exec \
                nginx \
                php7 \
                php7-fpm \
                php7-json \
                php7-opcache \
                php7-apcu \
                php7-phar \
                php7-mbstring \
                php7-iconv \
                php7-openssl \
                php7-zlib \
                tar \
                xz \
                s6 \
    && ln -s /usr/bin/php7 /usr/bin/php \
    && npm install -g bower \
    && git clone -b v1.8.6 https://github.com/Cakebox/Cakebox-light.git /var/www/html/cakebox \
    && cd /tmp \
    && curl -s http://getcomposer.org/installer | php7 \
    && mv /tmp/composer.phar /usr/bin/composer \
    && chmod +x /usr/bin/composer \
    && cd /var/www/html/cakebox \
    && composer install \
    && bower install --allow-root \
    && npm remove -g bower \
    && npm cache clean \
    && apk del ${BUILD_DEPS} \
    && rm -rf /var/cache/apk/* /tmp/*
    

COPY rootfs /
VOLUME /data
EXPOSE 8080
RUN chmod +x /usr/local/bin/startup /etc/s6.d/*/*

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["/bin/s6-svscan", "/etc/s6.d"]
