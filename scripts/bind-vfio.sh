#!/usr/bin/env bash
sudo modprobe -r nvidia_drm nvidia_modeset nvidia_uvm i2c_nvidia_gpu nvidia

sudo modprobe vfio
sudo modprobe vfio_iommu_type1
sudo modprobe vfio_pci

systemctl --user -M compromyse@ stop pipewire.service pipewire.socket

sudo virsh nodedev-detach pci_0000_01_00_0
sudo virsh nodedev-detach pci_0000_01_00_1

systemctl --user -M compromyse@ restart pipewire.service pipewire.socket
