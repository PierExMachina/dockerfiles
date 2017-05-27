FROM alpine:3.6

LABEL Description="sonerezh based on alpine" \
      tags="latest 1.1.1 1.1 1" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017032801"

ARG SONEREZH_VER=1.1.1

ENV UID=1000 \
    GID=1000
    

RUN BUILD_DEPS="git \
                ca-certificates" \
    && apk add -U ${BUILD_DEPS} \
                nginx \
                php5-fpm \
                php5-gd \
                php5-exif \
                php5-openssl \
                php5-pdo_sqlite \
                php5-pdo_mysql \
                php5-pdo_pgsql \
                libressl \
                ffmpeg \
                su-exec \
                s6 \
    && git clone -b ${SONEREZH_VER} https://github.com/Sonerezh/sonerezh.git /var/www/html/sonerezh \
    && ln -sf /var/www/html/sonerezh/app/webroot/img/thumbnails /thumbnails \
    && apk del ${BUILD_DEPS} \
    && rm -rf /tmp/* /var/cache/apk/* /var/www/html/sonerezh/.git

VOLUME /musics /thumbmails /data

COPY rootfs /
RUN chmod u+x /usr/local/bin/startup

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["/bin/s6-svscan","/etc/s6.d"]
