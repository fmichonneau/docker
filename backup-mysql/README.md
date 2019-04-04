# MySQL Backup Service

This Docker image provides a backup service to backup a MySQL database. The service can be added into a docker stack with a MySQL instance to backup the database periodically.

## Features

- Backup MySQL database
- Cron Job

## Environment

- CRON_PERIOD - Cron timer settings
- MYSQL_HOST - MySQL database server
- MYSQL_DATABASE - Database name
- MYSQL_USER - Database user
- MYSQL_PASSWORD - Database password
- BACKUP_ROTATIONS - Number of backups to be kept locally (default 5)

All backups are located in `/backups`. Each backup has a date prefix `2019-03-31.dump.tag.gz`.

### Scripts

All scripts are located in `/usr/local/bin` and can be called manually. E.g.

```sh
docker exec -it application_backup docker-entrypoint.sh backup
```

## How to Deploy the Service

The service is supposed to be part of a Docker service stack.

```yaml
version: '3.3'

services:
  app:
    [...]

  backup:
    image: vinado/backup-mysql:latest
    depends_on:
      - app
    volumes:
      - backups:/backups
    environment:
      CRON_PERIOD: "0 0 * * 1"
      MYSQL_HOST: "database"
      MYSQL_DATABASE: "<db_name>"
      MYSQL_USER: "<db_user>"
      MYSQL_PASSWORD: "<db_password>"
      BACKUP_ROTATIONS: "30"

volumes:
  backups:
```

## Contribute

The source is available on [GitHub](https://github.com/V1ncNet/docker). Please [report any issues](https://github.com/V1ncNet/docker/issues).

To build the image from the Dockerfile run:

```sh
docker build -t vinado/backup-mysql:latest .
```