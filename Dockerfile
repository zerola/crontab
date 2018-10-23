FROM mcuadros/ofelia:latest as ofelia

FROM alpine:latest

RUN apk --no-cache update && \
    apk --no-cache add --update \
      curl \
      bash \
      ca-certificates && \
    rm -rf /var/cache/apk/*

COPY --from=ofelia /usr/bin/ofelia /usr/bin/ofelia

VOLUME /etc/ofelia/
ENTRYPOINT ["/usr/bin/ofelia"]

CMD ["daemon", "--config", "/etc/ofelia/config.ini"]
