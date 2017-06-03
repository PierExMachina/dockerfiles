FROM xataz/alpine:3.6

ARG JACKETT_VER=0.7.1437

ENV UID=991 \
    GID=991

LABEL description="Jackett based on alpine" \
      tags="latest 0.7.1437 0.7 0" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017060301"

RUN apk add -U wget \
            libcurl \
            ca-certificates \
            s6 \
            su-exec \
    && apk add -U --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ mono python2 \
    && wget https://github.com/Jackett/Jackett/releases/download/v${JACKETT_VER}/Jackett.Binaries.Mono.tar.gz -O /tmp/Jackett.Binaries.Mono.tar.gz \
    && tar xzf /tmp/Jackett.Binaries.Mono.tar.gz -C /usr \
    && apk del wget \
    && rm -rf /tmp/* /var/cache/apk/*

EXPOSE 9117

COPY rootfs /
RUN chmod +x /usr/local/bin/startup /etc/s6.d/*/*

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["s6-svscan", "/etc/s6.d"]
