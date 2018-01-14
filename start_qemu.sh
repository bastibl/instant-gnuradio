#!/bin/bash

qemu-system-x86_64 -m 2048 -drive format=raw,file=image-qemu/packer-ubuntu-17.04-amd64 -vga virtio -smp 2 -accel kvm
