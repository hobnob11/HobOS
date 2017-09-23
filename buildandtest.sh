#!/bin/bash

./build.sh

start_qemu(){
    echo "Starting QEMU"
    qemu-system-x86_64 -enable-kvm \
    -fda hobos.flp \
    -pidfile pid.txt \
    -monitor vc \
    -qmp unix:./qmp-sock,server,nowait&
}
restart_qemu(){
    echo "Restarting QEMU"
    cat restart.txt | nc -U qmp-sock
}

if [ ! -f "./pid.txt" ]; then
    start_qemu
else
    if kill -0 $(cat pid.txt); then
        restart_qemu
    else
        start_qemu
    fi
fi
