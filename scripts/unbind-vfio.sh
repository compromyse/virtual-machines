#!/usr/bin/env bash
systemctl --user -M compromyse@ stop pipewire.service pipewire.socket

sudo virsh nodedev-reattach pci_0000_01_00_0
sudo virsh nodedev-reattach pci_0000_01_00_1

systemctl --user -M compromyse@ restart pipewire.service pipewire.socket

sudo modprobe -r vfio_pci
sudo modprobe -r vfio_iommu_type1
sudo modprobe -r vfio

sudo modprobe nvidia_drm nvidia_modeset nvidia_uvm i2c_nvidia_gpu nvidia
