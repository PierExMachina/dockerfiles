FROM xataz/alpine:3.5

ARG DRONE_VER=master

ENV UID=991 \
    GID=991 \
    DRONE_DATABASE_DRIVER=sqlite3 \
    DRONE_DATABASE_DATASOURCE=/config/drone.db \
    SERVER_OR_AGENT=server \
    GIN_MODE=release

LABEL description="drone based on alpine" \
      tags="0.5.0 0.5 latest" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017032801"

RUN BUILD_DEPS="go \
                git \
                make \
                libc-dev" \
    && apk add -U ${BUILD_DEPS} \
                    ca-certificates \
                    su-exec \
                    tini \
    && export GOPATH=/tmp/go \
    && export GOBIN=/tmp/go/bin \
    && export PATH=$PATH:$GOBIN \
    && git clone -b ${DRONE_VER} https://github.com/drone/drone ${GOPATH}/src/github.com/drone/drone \
    && cd ${GOPATH}/src/github.com/drone/drone \
    && make deps \
    && make gen \
    && make build_static \
    && mv ${GOBIN}/drone /usr/local/bin/drone \
    && cd / \
    && apk del ${BUILD_DEPS} \
    && rm -rf /tmp/* /var/cache/apk/*

COPY startup /usr/local/bin/startup
RUN chmod +x /usr/local/bin/startup

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["/usr/local/bin/drone", "${SERVER_OR_AGENT}"]