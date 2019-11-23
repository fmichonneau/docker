FROM alpine

LABEL maintainer="me@vinado.de"

RUN apk add --no-cache postgresql-client rsync

COPY backup               /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/

RUN mkdir /backups
VOLUME    /backups

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["cron"]
