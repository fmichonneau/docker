# Nextcloud FPM Docker Compose Stack

This Docker stack provides an example for Nextcloud FPM and nginx. Yet this stack should not perform in a production environment without some kind of encryption.

**NOTE:** I was not able to deploy the stack without trouble. Auto-configuration with Nextcloud and PostgreSQL does not work seamlessly as promised. I had to create the stack without the actual Nextcloud application, create database and database user manually and add the app section afterwards.

## Features/Images

- PostgreSQL database
- Nextcloud FPM
- Redis in-memory cache
- [Nginx](https://github.com/V1ncNet/docker/tree/master/nextcloud-nginx/nginx)
- [Backup service](https://github.com/V1ncNet/docker/tree/master/backup-nextcloud)

## Environment

- CRON_PERIOD - Cron timer settings
- POSTGRES_HOST - PostgreSQL database container hostname
- POSTGRES_DB - Database name
- POSTGRES_USER - Database user
- POSTGRES_PASSWORD - Database password
- REDIS_HOST - Redis container hostname
- NEXTCLOUD_HOST - Nextcloud container hostname
- NEXTCLOUD_VOLUME - Nextcloud files directory

Also check out the image repositories for more options.

## How to Deploy the Stack

```sh
docker-compose up -d
```
