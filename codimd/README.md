# Nginx Nextcloud FPM Image & Stack

This image uses the node:lst-alpine base image and the CodiMD [repository](https://github.com/hackmdio/codimd). The Dockerfile follows the official documentation at https://hackmd.io/c/codimd-documentation/%2Fs%2Fcodimd-documentation.

## Environment

- DBMS - Database dialect. *postgres* or *myslq*
- DB_HOST - Database host
- DB_USER - Database user
- DB_PASSWORD - Database password
- DB_NAME - Database name
- DB_PORT - Database port

For a full list of CodiMD-related environment variables visit https://hackmd.io/c/codimd-documentation/%2Fs%2Fcodimd-configuration

Also check out the image repositories for more options.

## Stack Deployment

```sh
docker-compose up -d --build
```

### Features/Images

- PostgreSQL database
- [CodiMD](https://github.com/V1ncNet/docker/tree/master/codimd)

## Contribute

The source is available on [GitHub](https://github.com/V1ncNet/docker). Please [report any issues](https://github.com/V1ncNet/docker/issues).

To build the image from the Dockerfile run:

```sh
docker build -t vinado/codimd:latest .
```
