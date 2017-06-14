FROM xataz/alpine:edge


LABEL description="handbrake based on alpine" \
      tags="latest" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017061301"

ENV UID=991 \
    GID=991

RUN apk add --no-cache handbrake \
                        su-exec \
                        tini

COPY startup /usr/local/bin/startup
RUN chmod +x /usr/local/bin/startup

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["--version"]