#!/bin/bash

FILENAME=hobloader

echo "Compiling new binary"

nasm -f bin -o $FILENAME.bin $FILENAME.asm

echo "Writing to floppy."

dd status=noxfer conv=notrunc if=hobloader.bin of=hobos.flp
