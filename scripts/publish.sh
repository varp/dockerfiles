#!/bin/bash

set -eo pipefail


SKIP_BUILD="$1"
USE_CUSTOM_REPO="$2"

DEFAULT_REGISTRY="vardan"

IMAGES=( centos:base centos:basecli ubuntu:base ubuntu:basecli ubuntu:php-7.2 ubuntu:php-7.3 ubuntu:php-7.4 )
[ ! -z "$USE_CUSTOM_REPO" ] && {

  [ ! -f .env ] && {
    echo "[-] .env was not found. aborting"
    exit 1
  }

  ## .env must containts
  # DOCKER_REGISTRY=docker.pkg.github.com
  # DOCKER_REPOSITORY=varp/dockerfiles
  # DOCKER_USERNAME=varp
  # DOCKER_PASSWORD=GITHUB_TOKEN
  . .env

  echo "[+] log in to ${DOCKER_REGISTRY}" 
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $DOCKER_REGISTRY
}

[ -z "$SKIP_BUILD" ] && { 
  echo "[+] building images"

  docker-compose build
}

NEW_TAGS=( )
DATE=$(date +"%Y%m%d")


echo "[+] assigning tags"
for image in "${IMAGES[@]}"; do
  
  if [ ! -z "$USE_CUSTOM_REPO" ]; then
    NEW_TAG="${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${image}"
  else
    NEW_TAG="${DEFAULT_REGISTRY}/${image}"
  fi

  docker tag "${DEFAULT_REGISTRY}/${image}" "$NEW_TAG"
  docker tag "${DEFAULT_REGISTRY}/${image}" "$NEW_TAG-$DATE"

  NEW_TAGS+=( "$NEW_TAG" "$NEW_TAG-$DATE" )

done

echo "[+] pushing images"
for tag in "${NEW_TAGS[@]}"; do
  
  docker push "$tag"

done
