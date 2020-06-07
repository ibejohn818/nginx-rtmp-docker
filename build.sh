#!/usr/bin/env bash

STAGING_DIR=".staging"
NGINX_REPO="https://github.com/nginx/nginx.git"
RTMP_REPO="https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git"

# make staging dir for repos
PPWD=$(pwd)
rm -rf ${STAGING_DIR} || true

mkdir ${STAGING_DIR}

cd ${STAGING_DIR}

git clone --single-branch --branch dev --depth=1 ${RTMP_REPO}
git clone --single-branch --branch master --depth=1 ${NGINX_REPO}
