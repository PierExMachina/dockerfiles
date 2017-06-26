FROM xataz/mono:5

ARG JACKETT_VER=0.7.1499

ENV UID=991 \
    GID=991

LABEL description="Jackett based on alpine" \
      tags="latest 0.7.1499 0.7 0" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017062601"

RUN apk add --no-cache wget \
            libcurl \
            ca-certificates \
            s6 \
            su-exec \
    && wget https://github.com/Jackett/Jackett/releases/download/v${JACKETT_VER}/Jackett.Binaries.Mono.tar.gz -O /tmp/Jackett.Binaries.Mono.tar.gz \
    && tar xzf /tmp/Jackett.Binaries.Mono.tar.gz -C /usr \
    && apk del wget \
    && rm -rf /tmp/*

EXPOSE 9117

COPY rootfs /
RUN chmod +x /usr/local/bin/startup

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["s6-svscan", "/etc/s6.d"]
