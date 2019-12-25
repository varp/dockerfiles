#!/bin/bash

set -e

## .env must containt 
# DOCKER_REGISTRY=docker.pkg.github.com
# DOCKER_REPOSITORY=varp/dockerfiles
# DOCKER_USERNAME=varp
# DOCKER_PASSWORD=GITHUB_TOKEN

[ ! -f .env ] && {
  echo "- .env was not found. aborting"
  exit 1
}

source .env

SKIP_BUILD="$1"
DEFAULT_REGISTRY="vardan"

# ubuntu:base ubuntu:basecli ubuntu:php ubuntu:php-7.2 ubuntu:php-7.3 ubuntu:php-7.4
IMAGES=( centos:base centos:basecli ubuntu:base ubuntu:basecli ubuntu:php ubuntu:php-7.2 ubuntu:php-7.3 ubuntu:php-7.4 )

echo "+ log in to ${DOCKER_REGISTRY}" 
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $DOCKER_REGISTRY

[ -z "$SKIP_BUILD" ] && { 
  echo "+ building images"

  docker-compose build
}

NEW_TAGS=( )

echo "+ assigning tags"
for image in "${IMAGES[@]}"; do
  
  NEW_TAG="${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${image/:/_/}"

  docker tag "${DEFAULT_REGISTRY}/$image" "$NEW_TAG"

  NEW_TAGS+=( "$NEW_TAG" )

done

echo "+ pushing images"
for tag in "${NEW_TAGS[@]}"; do
  
  docker push "$tag"

done


echo "+ reseting tags to default regitsty"
for tag in "${IMAGES[@]}"; do
  
  set -x
  docker tag "$DOCKER_REGISTRY/$DOCKER_REPOSITORY/$tag" "$DEFAULT_REGISTRY/$tag"
  set +x

done