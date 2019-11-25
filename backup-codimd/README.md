# CodiMD Backup Service

This Docker image provides a backup service to backup CodiMD Uploads data and PostgreSQL database. The service can be added into a Docker stack with a PostgreSQL instance to backup the database periodically.

When a new backup is made, files from the older backups are hard-linked. This keeps the increments small because they only contain the delta from the previous backup.

## Features

- PostgreSQL database dumps using `pg_dump`
- Incremental CodiMD uploads backup using `rsync`
- Configurable Cronjob
- Configurable rotations

This service doesn't provide any restore function yet.

## Environment

- CRON_EXPRESSION - Cron expression
- POSTGRES_HOST - PostgreSQL database server
- POSTGRES_DB - Database name
- POSTGRES_USER - Database user
- POSTGRES_PASSWORD - Database password
- CODIMD_UPLOADS - CodiMD files directory (usually `/var/www/html`)
- BACKUP_ROTATIONS - Number of backups to be kept locally (default 7)

All backups are located in `/backups/uploads`. Dumps are saved under `/backup/dumps`. They are excluded from the rotation.

### Scripts

All scripts are located in `/usr/local/bin` and can be called manually. E.g.

```sh
docker exec -it codimd_backup docker-entrypoint.sh backup
```

## Deployment

The service is supposed to be part of a Docker service stack.

```yaml
version: '2'

services:
  database:
    image: postgres
    [...]

  codimd:
    image: quay.io/codimd/server
    depends_on:
      - database
    volumes:
      - uploads:/codimd/public/uploads
    environment:
      CMD_IMAGE_UPLOAD_TYPE: filesystem
      HMD_DB_URL: postgres://<db_user>:<db_password>@database:5432/<db_name>
    [...]

  backup:
    image: vinado/backup-codimd:latest
    depends_on:
      - codimd
    volumes:
      - uploads:/codimd/public/uploads
      - backups:/backups
    environment:
      CRON_EXPRESSION: "0 0 * * 1"
      CODIMD_UPLOADS: "/codimd/public/uploads"
      POSTGRES_HOST: "database"
      POSTGRES_DB: "<db_name>"
      POSTGRES_USER: "<db_user>"
      POSTGRES_PASSWORD: "<db_password>"

volumes:
  uploads:
    driver: local
  backups:
    driver: local
```

**NOTE:** The service should also work for the `nabo.codimd.dev/hackmdio/hackmd` image. Just make sure you use the right upload location: `/home/hackmd/app/public/uploads`.

## Contribute

The source is available on [GitHub](https://github.com/V1ncNet/docker). Please [report any issues](https://github.com/V1ncNet/docker/issues).

To build the image from the Dockerfile run:

```sh
docker build -t vinado/backup-codimd:latest .
```
