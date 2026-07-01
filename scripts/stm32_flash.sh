#!/bin/bash

ELF=$1

openocd \
-f interface/stlink.cfg \
-f target/stm32f4x.cfg \
-c "program $ELF verify reset exit"