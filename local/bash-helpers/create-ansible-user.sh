#!/usr/bin/env bash

set -e

cd "$(dirname "$0")" > /dev/null || exit 1

source ../bash-helpers/helpers.sh

# Test if ansible present or exit
Utils::testType "ansible"

sudo userdel ansible || true
sudo rm -fr /home/ansible

# su - ansible
sudo id -u ansible > $DEV_NULL || sudo useradd --create-home --shell /bin/bash ansible
sudo usermod --append --groups sudo ansible
sudo usermod --append --groups docker ansible
sudo usermod --append --groups projects ansible

# Check if pwd exists or create
sudo passwd ansible

# Check if key exist, or create
sudo [ -f "/home/ansible/.ssh/id_rsa" ] || {
    sudo -H -u ansible bash -c "ssh-keygen"
}

project_dir=$(cd ..; pwd)

# Switch to ansible user
Echo::info "Login as $(Echo::green ansible), go to $(Echo::yellow $project_dir) and run $(Echo::green make)"
su - ansible