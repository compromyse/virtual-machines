#!/usr/bin/env bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 [vm_name] [ip_addr:192.168.122.x] [size (GB)]"
    exit
fi

VM_NAME="$1"
IP_ADDR="$2"
SIZE="$3"
AMD_GPU_RENDERNODE="/dev/dri/by-path/pci-0000:05:00.0-render"

set -xe

virt-builder debian-13 \
  -o imgs/$VM_NAME.img \
  --size "$SIZE"G \
  --hostname $VM_NAME \
  -m 4096 --smp 4 \
  --run-command "ssh-keygen -A" \
  --append-line "/etc/network/interfaces:allow-hotplug enp1s0" \
  --append-line "/etc/network/interfaces:auto enp1s0" \
  --append-line "/etc/network/interfaces:iface enp1s0 inet static" \
  --append-line "/etc/network/interfaces:  address $IP_ADDR" \
  --append-line "/etc/network/interfaces:  gateway 192.168.122.1" \
  --run-command "apt-get update" \
  --run-command "apt-get install task-mate-desktop spice-vdagent qemu-guest-agent -y" \
  --run scripts/provision-root.sh \
  --ssh-inject compromyse:file:"$HOME/.ssh/id_rsa.pub" \
  --upload "scripts/provision-user.sh:/home/compromyse/install-nix.sh" \
  --write "/etc/resolv.conf:nameserver 8.8.8.8"

sudo virt-install --import \
  --os-variant debian13 \
  --name $VM_NAME \
  --ram 8192 \
  --cpu host-passthrough,cache.mode=passthrough \
  --vcpus 4,sockets=1,cores=2,threads=2 \
  --disk path=imgs/$VM_NAME.img,format=raw,bus=virtio \
  --video virtio,model.acceleration.accel3d=yes \
  --graphics spice,gl.enable=yes,listen=none,gl.rendernode="$AMD_GPU_RENDERNODE" \
  --noautoconsole \
  --noreboot
