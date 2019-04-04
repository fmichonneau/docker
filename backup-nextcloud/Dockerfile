FROM alpine

LABEL maintainer="vincent.nadoll@gmail.com"

RUN apk add --no-cache postgresql-client

COPY backup            /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/

RUN mkdir /backups
VOLUME    /backups

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["cron"]
