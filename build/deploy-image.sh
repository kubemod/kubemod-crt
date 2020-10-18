#!/bin/bash

# Get the version of the image - default to the latest tag.
KUBEMOD_CRT_IMAGE_VERSION=${KUBEMOD_CRT_IMAGE_VERSION:-$(git describe --tags)}

if [[ $KUBEMOD_CRT_IMAGE_VERSION == v* ]]; then
    KUBEMOD_CRT_IMAGE_VERSION=$(echo ${KUBEMOD_CRT_IMAGE_VERSION} | grep -Po "(v[\d\.]+)")
fi

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker build -t kubemod/kubemod-crt:$KUBEMOD_CRT_IMAGE_VERSION .
docker push kubemod/kubemod-crt:$KUBEMOD_CRT_IMAGE_VERSION .
