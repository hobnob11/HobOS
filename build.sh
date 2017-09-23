#!/bin/bash

FILENAME=hobloader

echo "Compiling new binary"

nasm -f bin -o $FILENAME.bin $FILENAME.asm

if [ ! -f "hobos.flp" ]; then
    echo "Creating blank floppy"
    dd bs=512 count=2880 if=/dev/zero of=./hobos.flp
fi

echo "Writing to floppy."

dd status=noxfer conv=notrunc if=hobloader.bin of=hobos.flp
