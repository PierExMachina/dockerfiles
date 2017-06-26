FROM xataz/node:8

LABEL Description="manage-this-node based on alpine" \
      tags="latest" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017062601"

RUN BUILD_DEPS="git \
                ca-certificates" \
    && apk add -U ${BUILD_DEPS} \
    && git clone https://github.com/onedr0p/manage-this-node \
    && cd /manage-this-node \
    && npm install \
    && apk del ${BUILD_DEPS} \
    && rm -rf /var/cache/apk/*

COPY startup /usr/local/bin/startup
RUN chmod +x /usr/local/bin/startup

EXPOSE 3000

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["npm", "start"]