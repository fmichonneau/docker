# Nextcloud Backup Service

This Docker image provides a backup service to backup Nextcloud data and PostgreSQL database. The service can be added into a docker stack with a PostgreSQL instance to backup the database periodically.

## Features

- Backup PostgreSQL database
- Backup Nexcloud files
- Cron Job

## Environment

- CRON_PERIOD - Cron timer settings
- POSTGRES_HOST - PostgreSQL database server
- POSTGRES_DB - Database name
- POSTGRES_USER - Database user
- POSTGRES_PASSWORD - Database password
- NEXTCLOUD_VOLUME - Nextcloud files directory
- BACKUP_ROTATIONS - Number of backups to be kept locally (default 5)

All backups are located in `/backups`. Each backup has a date prefix `2019-03-31.nextcloud.tag.gz`.

### Scripts

All scripts are located in `/usr/local/bin` and can be called manually. E.g.

```sh
docker exec -it nextcloud_backup docker-entrypoint.sh backup
```

## How to Deploy the Service

The service is supposed to be part of a Docker service stack.

```yaml
version: '3.3'

services:
  database:
    image: postgres
    [...]

  nextcloud:
    image: nextcloud
    depends_on:
      - database
    volumes:
      - nextcloud:/var/www/html
    [...]

  backup:
    image: vinado/backup-nextcloud:latest
    depends_on:
      - nextcloud
    volumes:
      - nextcloud:/var/www/html
      - backups:/backups
    environment:
      CRON_PERIOD: "0 0 * * 1"
      NEXTCLOUD_VOLUME: "/var/www/html"
      POSTGRES_HOST: "database"
      POSTGRES_DB: "<db_name>"
      POSTGRES_USER: "<db_user>"
      POSTGRES_PASSWORD: "<db_password>"

volumes:
  nextcloud:
  backups:
```

## Contribute

The source is available on [GitHub](https://github.com/V1ncNet/docker). Please [report any issues](https://github.com/V1ncNet/docker/issues).

To build the image from the Dockerfile run:

```sh
docker build -t vinado/backup-nextcloud:latest .
```