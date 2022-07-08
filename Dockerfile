FROM --platform=amd64 casjaysdev/rockylinux:latest as build

RUN set -xe \
  dnf install -y yum-utils && \
  yum-config-manager --add-repo https://couchdb.apache.org/repo/couchdb.repo && \
  dnf install -y couchdb jq

COPY ./bin/. /usr/local/bin/
COPY ./config/. /config/
COPY ./data/. /data/

FROM scratch

ARG BUILD_DATE="$(date +'%Y-%m-%d %H:%M')"

LABEL org.label-schema.name="couchdb" \
  org.label-schema.description="containerized version of couchdb" \
  org.label-schema.url="https://github.com/dockerize-it/couchdb" \
  org.label-schema.vcs-url="https://github.com/dockerize-it/couchdb" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.version=$BUILD_DATE \
  org.label-schema.vcs-ref=$BUILD_DATE \
  org.label-schema.license="MIT" \
  org.label-schema.vcs-type="Git" \
  org.label-schema.schema-version="latest" \
  org.label-schema.vendor="CasjaysDev" \
  maintainer="CasjaysDev <docker-admin@casjaysdev.com>"

ENV SHELL="/bin/bash" \
  TERM="xterm-256color" \
  HOSTNAME="casjaysdev-couchdb" \
  TZ="${TZ:-America/New_York}"

WORKDIR /root
VOLUME ["/root","/config"]

EXPOSE 5984
EXPOSE 8091

COPY --from=build /. /

HEALTHCHECK CMD [ "/usr/local/bin/entrypoint-couchdb.sh", "healthcheck" ]
ENTRYPOINT [ "/usr/local/bin/entrypoint-couchdb.sh" ]
CMD [ "/usr/bin/bash", "-l" ]
