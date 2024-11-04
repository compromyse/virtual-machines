#!/usr/bin/env bash

set -xe

export DEBIAN_FRONTEND=noninteractive

apt-get install -y git curl xz-utils sudo ssh
useradd compromyse -G sudo -p changeme -s /bin/bash
mkdir /home/compromyse
cp -rT /etc/skel /home/compromyse
chown -R compromyse:compromyse /home/compromyse
echo "compromyse	ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

unset DEBIAN_FRONTEND
