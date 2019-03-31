FROM alpine

LABEL maintainer="vincent.nadoll@gmail.com"

RUN apk add --no-cache mysql-client

COPY backup.sh            /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/

RUN mkdir /backups
VOLUME    /backups

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["cron"]
