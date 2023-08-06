#!/usr/bin/env bash

set -e

if [[ ! -v __INCLUDE_BASH_HELPERS_SH__ ]]; then 
  __INCLUDE_BASH_HELPERS_SH__=true

  declare dir="$(dirname $BASH_SOURCE[0])"

  source "${dir}/Color.sh"
  source "${dir}/Docker.sh"
  source "${dir}/Echo.sh"
  source "${dir}/Strings.sh"
  source "${dir}/Utils.sh"

  trap 'Utils::trap' ERR

fi