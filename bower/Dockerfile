FROM xataz/node:8

ENV UID=991 \
    GID=991

LABEL description="bower based on alpine" \
      tags="latest" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017062601"

COPY startup /usr/local/bin/startup

RUN apk add -U git \
        make \
        gcc \
        g++ \
        python \
        linux-headers \
        su-exec \
        tini \
    && npm install -g bower \
    && rm -rf /var/cache/apk/* \
    && chmod +x /usr/local/bin/startup

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["-v"]
