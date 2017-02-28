FROM xataz/alpine:3.5

ARG CERTBOT_VER=v0.11.1

LABEL description="Letsencrypt based on alpine" \
      tags="latest 0.11.1 0.1" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017022801"

RUN BUILD_DEPS="py2-pip \
            gcc \
            musl-dev \
            python2-dev \
            libffi-dev \
            openssl-dev" \
    && apk add -U ${BUILD_DEPS} \
        tini \
        dialog \
        python \
        libssl1.0 \
    && pip install --no-cache virtualenv \
    && virtualenv --no-site-packages -p python2 /usr/certbot/venv \
    && /usr/certbot/venv/bin/pip install --no-cache-dir certbot==${CERTBOT_VER} \
    && pip uninstall --no-cache-dir -y virtualenv \
    && apk del ${BUILD_DEPS} \
    && rm -rf /var/cache/apk/* /root/.cache/pip

EXPOSE 80 443
VOLUME /etc/letsencrypt/

ENTRYPOINT ["/sbin/tini","--","/usr/certbot/venv/bin/certbot"]
CMD ["--help"]
