FROM xataz/alpine:3.5

ARG RUNDECK_VER=2.7.1

LABEL description="rundeck based on alpine" \
      tags="latest" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017032801"

ENV URI_ACCESS="http://localhost:4440" \
    ADMIN_PASSWORD="4dM!n" \
    USER_NAME="user" \
    USER_PASSWORD="U53r"

RUN BUILD_DEPS="wget" \
    && apk add -U openjdk7-jre \
                    openssl \
                    ca-certificates \
                    ${BUILD_DEPS} \
    && mkdir -p /rundeck/bin \
    && wget http://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-${RUNDECK_VER}.jar -O /rundeck/bin/rundeck.jar \
    && apk del ${BUILD_DEPS} \
    && rm -rf /tmp/* /var/cache/apk/*

EXPOSE 4440
ADD rootfs /
RUN chmod +x /usr/local/bin/startup

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["java", "-jar", "/rundeck/bin/rundeck.jar", "-b", "/rundeck/conf"]