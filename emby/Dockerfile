FROM xataz/alpine:3.6

ARG MEDIAINFO_VER=0.7.96
ARG EMBY_VER=3.2.19.0

ENV GID=991 \
    UID=991

LABEL description="Emby based on alpine" \
      tags="latest 3.2.19.0 3.2 3" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017060301"

RUN export BUILD_DEPS="build-base \
                        git \
                        unzip \
                        wget \
                        ca-certificates" \
    && apk add -U imagemagick \
	            sqlite \
	            ffmpeg \
	            s6 \
                su-exec \
                $BUILD_DEPS \
    && apk add -U --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ mono python2 \
    && wget http://mediaarea.net/download/binary/mediainfo/${MEDIAINFO_VER}/MediaInfo_CLI_${MEDIAINFO_VER}_GNU_FromSource.tar.gz -O /tmp/MediaInfo_CLI_${MEDIAINFO_VER}_GNU_FromSource.tar.gz \
    && wget http://mediaarea.net/download/binary/libmediainfo0/${MEDIAINFO_VER}/MediaInfo_DLL_${MEDIAINFO_VER}_GNU_FromSource.tar.gz -O /tmp/MediaInfo_DLL_${MEDIAINFO_VER}_GNU_FromSource.tar.gz \
    && tar xzf /tmp/MediaInfo_DLL_${MEDIAINFO_VER}_GNU_FromSource.tar.gz -C /tmp \
    && tar xzf /tmp/MediaInfo_CLI_${MEDIAINFO_VER}_GNU_FromSource.tar.gz -C /tmp \
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
    && mkdir /embyServer /embyData \
    && wget https://github.com/MediaBrowser/Emby/releases/download/${EMBY_VER}/Emby.Mono.zip -O /tmp/Emby.Mono.zip \
    && unzip /tmp/Emby.Mono.zip -d /embyServer \
    && apk del $BUILD_DEPS \
    && rm -rf /var/cache/apk/* /tmp/*

EXPOSE 8096 8920 7359/udp
VOLUME /embyData
ADD rootfs /
RUN chmod +x /usr/local/bin/startup /etc/s6.d/*/*

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["s6-svscan", "/etc/s6.d"]
