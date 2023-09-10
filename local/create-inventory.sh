#!/usr/bin/env bash

set -e

cd "$(dirname "$0")" > /dev/null || exit 1

source ./bash-helpers/helpers.sh

# Discover docker container IP
docker_ip=$(Docker::getIP ansible-ubuntu)
cat <<EOF > ./inventory.ini
[servers]
server1 ansible_host=${docker_ip} ansible_ssh_extra_args='-o StrictHostKeyChecking=no'

[all:vars]
ansible_connection=ssh
ansible_ssh_user=root
ansible_ssh_pass=root
ansible_ssh_private_key_file = local/.ssh/ansible-ubuntu
EOF