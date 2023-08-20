#!/usr/bin/env bash
set -e
source .env
docker build \
    --build-arg PANET_USERNAME=$PA_USERNAME \
    --build-arg PANET_PASSWORD=$PA_PASSWORD \
    -t pat https://github.com/FragSoc/planetary-annihilation-docker.git
