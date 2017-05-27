FROM xataz/alpine:3.6

LABEL description="cardigann based on alpine" \
      tags="1.9.10 1.9 1 latest" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017041801"

ARG CARDIGANN_VER=1.9.10

ENV UID=991 \
    GID=991
    
RUN BUILD_DEPS="go \
                wget \
                git \
                libc-dev" \
    && apk add -U ca-certificates \
                tini \
                su-exec \
                ${BUILD_DEPS} \
    && mkdir -p /cardigann/bin /tmp/go \
    && export GOPATH=/tmp/go \
    && export GOBIN=$GOPATH/bin \
    && go get github.com/cardigann/cardigann \
    && cp /tmp/go/bin/cardigann /cardigann/bin/ \
    && cp -R /tmp/go/src/github.com/cardigann/cardigann/definitions /cardigann/ \
    && apk del ${BUILD_DEPS} \
    && rm -rf /var/cache/apk/* /tmp/*

ADD startup /usr/local/bin/startup
RUN chmod +x /usr/local/bin/startup

EXPOSE 5060

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["/cardigann/bin/cardigann", "server"]