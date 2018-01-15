#!/bin/bash

qemu-system-x86_64 -m 2048 -drive format=raw,file=vm-qemu/gnuradio -vga virtio -smp 2 -accel kvm -netdev user,id=mynet0,net=192.168.76.0/24,dhcpstart=192.168.76.9,hostfwd=tcp::2222-:22 -device e1000,netdev=mynet0
