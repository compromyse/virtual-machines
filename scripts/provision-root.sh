#!/usr/bin/env bash

set -xe

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get upgrade -y

apt-get install -y git curl xz-utils sudo ssh

unset DEBIAN_FRONTEND
