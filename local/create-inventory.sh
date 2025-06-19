#!/usr/bin/env bash

set -e

cd "$(dirname "$0")" > /dev/null || exit 1

source ./bash-helpers/helpers.sh

# Discover docker containers IP
cat <<EOF > ./../inventory/local/local.ini
[servers1]
server_1 ansible_host=$(Docker::getIP ansible-server-1) ansible_ssh_extra_args='-o StrictHostKeyChecking=no'
server_2 ansible_host=$(Docker::getIP ansible-server-2) ansible_ssh_extra_args='-o StrictHostKeyChecking=no'

[servers2]
server_3 ansible_host=$(Docker::getIP ansible-server-3) ansible_ssh_extra_args='-o StrictHostKeyChecking=no'
server_4 ansible_host=$(Docker::getIP ansible-server-4) ansible_ssh_extra_args='-o StrictHostKeyChecking=no'

[all:vars]
ansible_connection=ssh
ansible_user=ansible
EOF