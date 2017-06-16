FROM xataz/alpine:3.6

LABEL description="docker-compose based on alpine" \
      tags="latest 2.4.3 2.4 2" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017061602"

ARG SHINKEN_VER=2.4.3
ARG SHINKEN_CUSTOM_MODULES=""

ENV UID=1000 \
    GID=1000

RUN BUILD_DEPS="build-base \
                python2-dev \
                linux-headers \
                py2-pip \
                curl-dev \
                libressl-dev \
                libffi-dev" \
    && SHINKEN_MODULES="webui2 \
                        linux-ssh \
                        linux-snmp \
                        auth-htpasswd \
                        pickle-retention-file-scheduler \
                        sqlitedb \
                        booster-nrpe \
                        auth-cfg-password" \
    && apk add --no-cache ${BUILD_DEPS} \
                            python2 \
                            su-exec \
                            s6 \
                            curl \
                            libressl \
                            ca-certificates \
                            nagios-plugins-all \
                            nrpe \
                            bash \
                            shadow \
                            openssh \
    && adduser -h /shinken -u 1000 -g 1000 -D shinken \
    && pip install pycurl \
                    shinken==${SHINKEN_VER} \
                    pymongo \
                    requests \
                    arrow \
                    bottle \
                    passlib \
                    alignak_backend_client \
                    paramiko \
    && su - shinken -c 'shinken --init' \
    && for module in ${SHINKEN_MODULES}; do su - shinken -c "shinken install ${module}"; done \
    && apk del ${BUILD_DEPS}

COPY rootfs /
RUN chmod u+x /usr/local/bin/startup

EXPOSE 7767

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["s6-svscan","/etc/s6.d"]