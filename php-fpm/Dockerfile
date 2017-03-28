FROM xataz/alpine:3.5

ARG PHP_VER=7.1.3
ARG PHP_MIRROR=http://fr2.php.net
ARG PHP_GPG="A917B1ECDA84AEC2B568FED6F50ABC807BD5DCD0 \
            528995BFEDFBA7191D46839EF9BA0ADA31CBD89E \
            1A4E8B7277C42E53DBA9C7B9BCAA30EA9C0D5763 \
            6E4F6AB321FDC07F2C332E3AC2BF0BC433CFC8B3 \
            0BD78B5F97500D450838F95DFE857D9A90D90EC1 \
            0B96609E270F565C13292B24C13C70B87267B52D"
ARG PHP_CONF="--enable-fpm \
                --with-fpm-user=web \
                --with-fpm-group=web \
                --with-config-file-path="/php" \
                --with-config-file-scan-dir="/php/conf.d" \
                --disable-cgi \
                --enable-mysqlnd \
                --enable-mbstring \
                --with-curl \
                --with-libedit \
                --with-openssl \
                --with-zlib"
ARG PHP_EXT_LIST
ARG CUSTOM_BUILD_PKGS
ARG CUSTOM_PKGS
ARG CORES_BUILD

ENV UID=991 \
    GID=991

LABEL description="php based on alpine" \
      tags="7.1.3 7.1 7 stable latest" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017032801"

COPY docker-php-ext-* /usr/local/bin/

RUN export BUILD_DEPS="autoconf \
                build-base \
                g++ \
                gcc \
                libc-dev \
                make \
                pkgconf \
                curl-dev \
                libedit-dev \
                libxml2-dev \
                libressl-dev \
                sqlite-dev \
                wget \
                ca-certificates \
                ${CUSTOM_BUILD_PKGS}" \
    && apk add -U ${BUILD_DEPS} \
                    curl \
                    libedit \
                    libxml2 \
                    ${CUSTOM_PKGS} \
    && wget ${PHP_MIRROR}/get/php-${PHP_VER}.tar.gz/from/this/mirror -O /tmp/php-${PHP_VER}.tar.gz \
    && mkdir -p /php/php-fpm.d /php/conf.d/ \
    && mkdir -p /usr/src \
    && tar xzvf /tmp/php-${PHP_VER}.tar.gz -C /usr/src \
    && mv /usr/src/php-${PHP_VER} /usr/src/php \
    && NB_CORES=${CORES_BUILD-$(grep -c "processor" /proc/cpuinfo)} \
    && cd /usr/src/php \
    && ./configure ${PHP_CONF} \
    && make -j ${NB_CORES} \
    && make install \
    && { find /usr/local/bin /usr/local/sbin -type f -perm +0111 -exec strip --strip-all '{}' + || true; } \
    && chmod +x /usr/local/bin/docker-php-ext-* \
    && make clean \
    && if [ "${PHP_EXT_LIST}" != "" ]; then docker-php-ext-install ${PHP_EXT_LIST}; fi \
    && apk del ${BUILD_DEPS} ${CUSTOM_BUILD_PKGS} \
    && rm -rf /tmp/* /var/cache/apk/* /usr/src

COPY startup /usr/local/bin/startup
COPY php-fpm.conf /usr/local/etc/php-fpm.conf
RUN chmod +x /usr/local/bin/startup /usr/local/bin/docker*

WORKDIR /var/www/html

EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/startup"]
