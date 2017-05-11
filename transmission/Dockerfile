FROM xataz/alpine:3.5

LABEL description="transmission based on alpine" \
      tags="latest" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017051101"

ENV UID=991 \
    GID=991 \
    WEBROOT=""

RUN BUILD_DEPS="git" \
    && apk add -U transmission-daemon \
                su-exec \
                tini \
                ca-certificates \
                libressl \
                ${BUILD_DEPS} \
    && apk del ${BUILD_DEPS} \
    && rm -rf /var/cache/apk/* /tmp/*

VOLUME ["/data","/home/transmission/.config/transmission-daemon/"]
COPY rootfs /
RUN chmod +x /usr/local/bin/startup

ARG WITH_FILEBOT=NO
ARG FILEBOT_VER=4.7.7

RUN if [ "${WITH_FILEBOT}" == "YES" ]; then \
        apk add -X http://dl-cdn.alpinelinux.org/alpine/v3.4/community -U openjdk8-jre==8.111.14-r0 openjdk8-jre-base==8.111.14-r0 openjdk8-jre-lib==8.111.14-r0 \
        && mkdir /filebot \
        && cd /filebot \
        && wget http://downloads.sourceforge.net/project/filebot/filebot/FileBot_${FILEBOT_VER}/FileBot_${FILEBOT_VER}-portable.tar.xz -O /filebot/filebot.tar.xz \
        && tar xJf filebot.tar.xz \
        && sed -i -e 's|"script-torrent-done-enabled": false,|"script-torrent-done-enabled": true,|' \
                -e 's|"script-torrent-done-filename": "",|"script-torrent-done-filename": "",|' /tmp/settings.json \
        && apk del ca-certificates libressl \
        && rm -rf /var/cache/apk/* /filebot/FileBot_${FILEBOT_VER}-portable.tar.xz \
        && chmod +x /usr/local/bin/post* \
    ;fi

EXPOSE 9091

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["transmission-daemon", "--foreground"]
