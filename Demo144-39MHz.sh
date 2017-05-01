#!/bin/bash
# This script is a demo of rpitx on the PiFly

#
# Written: 4/23/2017
#    Rev.: 1.00
#      By: Robert S. Rau
#
# Updated: 4/30/2017
#    Rev.: 1.01
#      By: Robert S. Rau
#
#
#
#  Check that we are running with root permissions
if [[ $EUID > 0 ]]; then
	echo "Please run using: sudo ./Demo144-39MHz.sh"
	exit
fi
echo "n 8 i y d in ypsilanti"
# The sample rate must be 4800 for the .ft file format, text2wave will only make a short wave file at this sample rate, so we do 12000sps and them use sox to resample to 48000.
echo "n 8 i y d in ypsilanti" | text2wave -o t.wav -F 12000
sox t.wav -b 16 u.wav rate -v -s 48000
# We must empty the .ft file since pifm just overwrites the length of the .wav file and may leave the rest of the file untouched
> fm.ft
# Use pifm to convert from .wav to .ft required by rpitx
./pifm u.wav fm.ft
#
# RF carrier multiplexer on PiFly
gpio -g mode 27 out
gpio -g write 27 1
#
# RF amplifier power on PiFly
gpio -g mode 6 out
gpio -g write 6 1
# Transmit
./rpitx -m RF -i fm.ft -f 144390 -c 1
# Turn off RF amplifier on PiFly
gpio -g write 6 0
