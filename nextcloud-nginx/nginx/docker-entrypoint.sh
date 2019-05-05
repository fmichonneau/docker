#!/bin/sh

export DOLLAR='$'
envsubst < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

exec "${@}"