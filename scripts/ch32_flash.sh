#!/bin/bash

ELF=$1

openocd \
-f interface/wch-link.cfg \
-f target/ch32v.cfg \
-c "program $ELF verify reset exit"