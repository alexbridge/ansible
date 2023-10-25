#!/bin/sh

set -e

nginx -t -q && nginx -s reload