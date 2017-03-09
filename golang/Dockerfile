FROM xataz/alpine:3.5

ARG GO_VER=1.8
ARG GLIBC_VER=2.25-r0
ARG GO_URL=https://storage.googleapis.com/golang/go${GO_VER}.linux-amd64.tar.gz
ARG GLIBC_URL=https://github.com/andyshinn/alpine-pkg-glibc/releases/download/unreleased

ENV UID=991 \
    GID=991    

LABEL description="Golang based on alpine" \
      tags="latest 1.8 1.8 1" \
      glibc_ver="2.25-r0" \
      golang_ver="1.8" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017031001"

RUN BUILD_DEPS="wget \
                tar \
                ca-certificates" \
    && apk add -U ${BUILD_DEPS} \
                    git \
                    su-exec \
                    tini \
    && wget ${GO_URL} -O /tmp/go${GO_VER}.linux-amd64.tar.gz \
    && wget ${GLIBC_URL}/glibc-${GLIBC_VER}.apk -O /tmp/glibc-${GLIBC_VER}.apk \
    && wget ${GLIBC_URL}/glibc-bin-${GLIBC_VER}.apk -O /tmp/glibc-bin-${GLIBC_VER}.apk \
    && apk add --allow-untrusted /tmp/glibc-${GLIBC_VER}.apk /tmp/glibc-bin-${GLIBC_VER}.apk \
    && tar -C /usr/local -xzf /tmp/go${GO_VER}.linux-amd64.tar.gz \
    && apk del ${BUILD_DEPS} \
    && rm -rf /var/cache/apk/* /tmp/*

COPY startup /usr/local/bin/startup
RUN chmod +x /usr/local/bin/startup

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["version"]
