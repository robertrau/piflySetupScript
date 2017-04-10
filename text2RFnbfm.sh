#!/bin/bash
# This script Tests the festival and nbfm install
#
#Written: 4/8/2017
#  Rev.: 1.00
#   By: Robert S. Rau & Rob F. Rau II
#
#text2wave [options] textfile
#  Convert a textfile to a waveform
#  Options
#  -mode <string>  Explicit tts mode.
# -o ofile        File to save waveform (default is stdout).
#  -otype <string> Output waveform type: alaw, ulaw, snd, aiff, riff, nist etc.
#                  (default is riff)
#  -F <int>        Output frequency.
#  -scale <float>  Volume factor
#  -eval <string>  File or lisp s-expression to be evaluated before
#                  synthesis.
# Convert text to WAV file
echo "this is a test of this thing" | text2wave -o t.wav -F 11025
# Select GPIO4, pin 7, for the transmitter carrier. Turn the RF amplifier on.
sudo python piflyTransmit144.py
# Transmit the WAV file
sudo ./nbfm t.wav 144.39 11025
