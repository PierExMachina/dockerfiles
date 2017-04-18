FROM xataz/alpine:3.5

ARG BUILD_CORES

ARG NGINX_VER=1.11.13
ARG NGINX_GPG="B0F4253373F8F6F510D42178520A9993A1C052F8"
ARG NGINX_CONF="--prefix=/nginx \
                --sbin-path=/usr/local/sbin/nginx \
                --http-log-path=/nginx/logs/nginx_access.log \
                --error-log-path=/nginx/logs/nginx_error.log \
                --pid-path=/nginx/run/nginx.pid \
                --lock-path=/nginx/run/nginx.lock \
                --user=web --group=web \
                --with-http_ssl_module \
                --with-http_realip_module \
                --with-http_addition_module \
                --with-http_sub_module \
                --with-http_dav_module \
                --with-http_flv_module \
                --with-http_mp4_module \
                --with-http_gunzip_module \
                --with-http_gzip_static_module \
                --with-http_random_index_module \
                --with-http_secure_link_module \
                --with-http_stub_status_module \
                --with-threads \
                --with-stream \
                --with-stream_ssl_module \
                --with-http_slice_module \
                --with-mail \
                --with-mail_ssl_module \
                --with-http_v2_module \
                --with-ipv6"

ARG PHP_VER=7.1.4
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

ARG PHP_EXT_LIST="gd \
                mysqli \
                ctype \
                dom \
                iconv \
                json \
                xml \
                mbstring \
                posix \
                xmlwriter \
                zip \
                zlib \
                sqlite3 \
                pdo_sqlite \
                pdo_pgsql \
                pdo_mysql \
                curl \
                fileinfo \
                bz2 \
                intl \
                mcrypt \
                openssl \
                ldap \
                simplexml \
                pgsql \
                ftp \
                exif \
                gmp"
ARG CUSTOM_BUILD_PKGS="freetype-dev \
                        openldap-dev \
                        gmp-dev"
ARG CUSTOM_PKGS="freetype \
                openldap \
                gmp"

ENV UID=991 \
    GID=991

LABEL description="nginx based on alpine" \
      tags="latest" \
      nginx_version="${NGINX_VER}" \
      php_version="${PHP_VER}" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017041801"

COPY rootfs /

RUN export BUILD_DEPS="build-base \
                    pcre-dev \
                    zlib-dev \
                    wget \
                    gnupg \
                    autoconf \
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
    && NB_CORES=${BUILD_CORES-$(grep -c "processor" /proc/cpuinfo)} \
    && apk add -U ${BUILD_DEPS} \
                    curl \
                    libedit \
                    libxml2 \
                    libressl \
                    pcre \
                    zlib \
                    s6 \
                    su-exec \
                    ${CUSTOM_PKGS} \
    && wget http://nginx.org/download/nginx-${NGINX_VER}.tar.gz -O /tmp/nginx-${NGINX_VER}.tar.gz \
    && wget http://nginx.org/download/nginx-${NGINX_VER}.tar.gz.asc -O /tmp/nginx-${NGINX_VER}.tar.gz.asc \
    && wget ${PHP_MIRROR}/get/php-${PHP_VER}.tar.gz/from/this/mirror -O /tmp/php-${PHP_VER}.tar.gz \
    && wget ${PHP_MIRROR}/get/php-${PHP_VER}.tar.gz.asc/from/this/mirror -O /tmp/php-${PHP_VER}.tar.gz.asc \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$NGINX_GPG" \
	&& gpg --batch --verify /tmp/nginx-${NGINX_VER}.tar.gz.asc /tmp/nginx-${NGINX_VER}.tar.gz \
    && gpg --keyserver pgp.mit.edu --recv-keys "$PHP_GPG" \
    && gpg --batch --verify /tmp/php-${PHP_VER}.tar.gz.asc /tmp/php-${PHP_VER}.tar.gz \
    && mkdir -p /php/conf.d \
    && mkdir -p /usr/src \
    && tar xzf /tmp/nginx-${NGINX_VER}.tar.gz -C /usr/src \
    && tar xzvf /tmp/php-${PHP_VER}.tar.gz -C /usr/src \
    && cd /usr/src/nginx-${NGINX_VER} \
    && ./configure ${NGINX_CONF} \            
    && make -j ${NB_CORES} \
    && make install \
    && mv /usr/src/php-${PHP_VER} /usr/src/php \
    && cd /usr/src/php \
    && ./configure ${PHP_CONF} \
    && make -j ${NB_CORES} \
    && make install \
    && { find /usr/local/bin /usr/local/sbin -type f -perm +0111 -exec strip --strip-all '{}' + || true; } \
    && make clean \
    && chmod u+x /usr/local/bin/* /etc/s6.d/*/* \
    && docker-php-ext-install ${PHP_EXT_LIST} \
    && apk del ${BUILD_DEPS} \
    && rm -rf /tmp/* /var/cache/apk/* /usr/src/*

EXPOSE 8080 8443

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["/bin/s6-svscan", "/etc/s6.d"]
