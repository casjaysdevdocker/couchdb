FROM casjaysdev/alpine:latest as build

RUN apk -U upgrade && \
  apk --no-cache --update add couchdb

COPY ./bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

FROM build
ARG BUILD_DATE="$(date +'%Y-%m-%d %H:%M')" 

LABEL \
  org.label-schema.name="couchdb" \
  org.label-schema.description="couchdb" \
  org.label-schema.url="https://github.com/casjaysdev/couchdb" \
  org.label-schema.vcs-url="https://github.com/casjaysdev/couchdb" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.version=$BUILD_DATE \
  org.label-schema.vcs-ref=$BUILD_DATE \
  org.label-schema.license="MIT" \
  org.label-schema.vcs-type="Git" \
  org.label-schema.schema-version="1.0" \
  org.label-schema.vendor="CasjaysDev" \
  maintainer="CasjaysDev <docker-admin@casjaysdev.com>" 

VOLUME [ "/data", "/config" ]

HEALTHCHECK CMD ["/usr/local/bin/docker-entrypoint.sh", "healthcheck"]

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
