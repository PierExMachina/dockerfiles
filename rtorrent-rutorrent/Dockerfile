FROM xataz/alpine:3.5

ARG BUILD_CORES
ARG MEDIAINFO_VER=0.7.92.1
ARG RTORRENT_VER=0.9.6
ARG LIBTORRENT_VER=0.13.6

ENV UID=991 \
    GID=991 \
    WEBROOT=/ \
    PORT_RTORRENT=45000 \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

LABEL Description="rutorrent based on alpine" \
      tags="latest" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017051103"

RUN export BUILD_DEPS="build-base \
                        git \
                        libtool \
                        automake \
                        autoconf \
                        wget \
                        subversion \
                        cppunit-dev \
                        libressl-dev \
                        ncurses-dev \
                        curl-dev" \
    && apk add -U ${BUILD_DEPS} \
                ffmpeg \
                ca-certificates \
                gzip \
                zip \
                unrar \
                curl \
                c-ares \
                s6 \
                geoip \
                su-exec \
                nginx \
                php7 \
                php7-fpm \
                php7-json \
                php7-opcache \
                php7-apcu \
                libressl \
                file \
                findutils \
                tar \
                xz \
                screen \
    && cd /tmp \
    && git clone https://github.com/esmil/mktorrent \
    && svn checkout http://svn.code.sf.net/p/xmlrpc-c/code/stable xmlrpc-c \
    && git clone -b ${LIBTORRENT_VER} https://github.com/rakshasa/libtorrent.git \
    && git clone -b ${RTORRENT_VER} https://github.com/rakshasa/rtorrent.git \
    && wget http://mediaarea.net/download/binary/mediainfo/${MEDIAINFO_VER}/MediaInfo_CLI_${MEDIAINFO_VER}_GNU_FromSource.tar.gz \
    && wget http://mediaarea.net/download/binary/libmediainfo0/${MEDIAINFO_VER}/MediaInfo_DLL_${MEDIAINFO_VER}_GNU_FromSource.tar.gz \
    && tar xzf MediaInfo_DLL_${MEDIAINFO_VER}_GNU_FromSource.tar.gz \
    && tar xzf MediaInfo_CLI_${MEDIAINFO_VER}_GNU_FromSource.tar.gz \
    && cd /tmp/mktorrent \
    && make -j ${BUILD_CORES-$(grep -c "processor" /proc/cpuinfo)} \
    && make install \
    && cd  /tmp/MediaInfo_DLL_GNU_FromSource \
    && ./SO_Compile.sh \
    && cd /tmp/MediaInfo_DLL_GNU_FromSource/ZenLib/Project/GNU/Library \
    && make install \
    && cd /tmp/MediaInfo_DLL_GNU_FromSource/MediaInfoLib/Project/GNU/Library \
    && make install \
    && cd /tmp/MediaInfo_CLI_GNU_FromSource \
    && ./CLI_Compile.sh \
    && cd /tmp/MediaInfo_CLI_GNU_FromSource/MediaInfo/Project/GNU/CLI \
    && make install \
    && cd /tmp/xmlrpc-c \
    && ./configure \
    && make -j ${NB_CORES} \
    && make install \
    && cd /tmp/libtorrent \
    && ./autogen.sh \
    && ./configure \
    && make -j ${BUILD_CORES-$(grep -c "processor" /proc/cpuinfo)} \
    && make install \
    && cd /tmp/rtorrent \
    && ./autogen.sh \
    && ./configure --with-xmlrpc-c \
    && make -j ${BUILD_CORES-$(grep -c "processor" /proc/cpuinfo)} \
    && make install \
    && mkdir -p /var/www \
    && git clone https://github.com/Novik/ruTorrent.git /var/www/html/rutorrent \
    && git clone https://github.com/xombiemp/rutorrentMobile.git /var/www/html/rutorrent/plugins/mobile \
    && git clone https://github.com/Phlooo/ruTorrent-MaterialDesign.git /var/www/html/rutorrent/plugins/theme/themes/materialdesign \
    && mv /var/www/html/rutorrent /var/www/html/torrent \
    && apk del ${BUILD_DEPS} \
    && rm -rf /var/cache/apk/* /tmp/* \
    && deluser svn \
    && delgroup svnusers \
    && ln -s /usr/bin/php7 /usr/bin/php

COPY rootfs /
ARG WITH_FILEBOT=NO
ARG FILEBOT_VER=4.7.7

RUN if [ "${WITH_FILEBOT}" == "YES" ]; then \
        apk add -X http://dl-cdn.alpinelinux.org/alpine/v3.4/community -U openjdk8-jre==8.111.14-r0 openjdk8-jre-base==8.111.14-r0 openjdk8-jre-lib==8.111.14-r0 \
        && mkdir /filebot \
        && cd /filebot \
        && wget http://downloads.sourceforge.net/project/filebot/filebot/FileBot_${FILEBOT_VER}/FileBot_${FILEBOT_VER}-portable.tar.xz -O /filebot/filebot.tar.xz \
        && tar xJf filebot.tar.xz \
        && echo 'system.method.set_key=event.download.finished,filebot,"execute={/usr/local/bin/postdl,$d.get_base_path=,$d.get_name=,$d.get_custom1=}"' >> /home/torrent/.rtorrent.rc \
        && echo 'system.method.set_key=event.download.erased,filebot_cleaner,"execute=/usr/local/bin/postrm"' >> /home/torrent/.rtorrent.rc \
        && rm -rf /var/cache/apk/* /tmp/* /filebot/FileBot_${FILEBOT_VER}-portable.tar.xz \
        && chmod +x /usr/local/bin/post* \
    ;fi

VOLUME /data /config
EXPOSE 8080
RUN chmod +x /usr/local/bin/startup /etc/s6.d/*/*

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["/bin/s6-svscan", "/etc/s6.d"]
