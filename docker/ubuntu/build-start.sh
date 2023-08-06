#!/usr/bin/env bash

set -e

cd "$(dirname "$0")" > /dev/null || exit 1

source ../../bash-helpers/helpers.sh

# Test if docker present
Utils::testType "docker"

docker stop ansible-ubuntu && docker rm ansible-ubuntu
docker build --tag ansible-ubuntu .
docker run -p 23:22 --name ansible-ubuntu --privileged -it -d ansible-ubuntu
