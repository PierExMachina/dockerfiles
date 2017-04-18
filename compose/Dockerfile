FROM xataz/alpine:3.5

ARG COMPOSE_VER=1.12.0

ENV UID=991 \
    GID=991

LABEL description="docker-compose based on alpine" \
      tags="latest 1.12.0 1.12 1" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017041801"

COPY startup /usr/local/bin/startup

RUN apk add -U python \
            py-setuptools \
            py2-pip \
            su-exec \
            tini \
    && pip install --no-cache-dir docker-compose==${COMPOSE_VER} \
    && apk del py2-pip \
    && rm -rf /var/cache/apk/* \
    && chmod +x /usr/local/bin/startup

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["version"]
