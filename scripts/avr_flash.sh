#!/bin/bash

HEX=$1

avrdude \
-c usbasp \
-p m328p \
-U flash:w:$HEX:i