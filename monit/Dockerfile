FROM xataz/alpine:3.5

ARG MONIT_VER=5.21.0
ARG BUILD_CORES

LABEL description="Monit based on alpine" \
      tags="latest stable 5.21.0 5.21 5" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017032801"

ENV USER_MONIT="monit" \
    PASSWORD_MONIT="monit"

RUN export BUILD_DEPS="wget \
                    ca-certificates \
                    build-base \
                    linux-pam-dev \
                    libressl-dev \
                    bash \
                    zlib-dev \
                    libseccomp" \
    && apk add -U ${BUILD_DEPS} \
                    linux-pam \
                    docker \
                    bash \
                    libseccomp \
                    tini \
                    libressl \
                    libcrypto1.0 \
                    libssl1.0 \
                    openssl \
    && NB_CORES=${BUILD_CORES-$(grep -c "processor" /proc/cpuinfo)} \
    && cd /tmp \
    && wget https://mmonit.com/monit/dist/monit-${MONIT_VER}.tar.gz \
    && tar xzf monit-${MONIT_VER}.tar.gz \
    && cd /tmp/monit-${MONIT_VER} \
    && ./configure \
    && make -j ${NB_CORES} \
    && make install \
    && apk del ${BUILD_DEPS} \
    && rm -rf /tmp/* /var/cache/apk/*
    
COPY rootfs /
RUN chmod 700 /etc/monit/monitrc \
    && chmod +x /usr/local/bin/*

CMD ["/usr/local/bin/startup"]
