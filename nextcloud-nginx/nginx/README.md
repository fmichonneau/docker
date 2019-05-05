## Nginx Netcloud FPM Image

This image builds upon the nginx:alpine image and adds and an `nginx.conf.template` replacement. Dockerfile and nginx can be found in the official [nextcloud/docker](https://github.com/nextcloud/docker/tree/master/.examples) examples section.

## Environment

I added the *NEXTCLOUD_HOST* environment variable to `nginx.conf.template`.

## Contribute

The source is available on [GitHub](https://github.com/V1ncNet/docker). Please [report any issues](https://github.com/V1ncNet/docker/issues).

To build the image from the Dockerfile run:

```sh
docker build -t vinado/nextcloud-nginx:latest .
```