FROM node:lts-alpine
LABEL maintainer="Vincent Nadoll <me@vinado.de>"

ARG CODIMD_BRANCH=develop

RUN apk --no-cache add \
    git \
    yarn \
    bash \
    make \
    gcc \
    g++ \
    python \
    openssl-dev

WORKDIR /codimd
RUN git clone https://github.com/hackmdio/codimd.git . \
 && git checkout ${CODIMD_BRANCH} \
 && ./bin/setup \
 && npm run build \
 && npm cache clean --force \
 && yarn cache clean

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 3000
VOLUME ["/codimd/public/docs", "/codimd/public/views", "/codimd/public/uploads"]

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["node", "app.js"]
