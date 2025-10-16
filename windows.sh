#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [vm_name]"
    exit
fi

VM_NAME="$1"

VIRTIO_WIN="$(ls isos/virtio-win*.iso)"
WINDOWS="isos/Win11_24H2_English_x64.iso"

if [ ! -f $VIRTIO_WIN ]; then
  pushd isos
  aria2c https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso
  popd
fi

sudo virt-install --import \
  --os-variant win11 \
  --name $VM_NAME \
  --ram 32768 \
  --cpu host-passthrough,cache.mode=passthrough \
  --vcpus 12,sockets=1,cores=6,threads=2 \
  --cdrom $WINDOWS \
  --disk path=$VIRTIO_WIN,device=cdrom \
  --disk path=imgs/$VM_NAME.img,format=raw,bus=virtio,size="256" \
  --video virtio \
  --graphics spice \
  --noautoconsole \
  --noreboot \
  --shmem name="looking-glass",model.type="ivshmem-plain",size=32,size.unit="M"
