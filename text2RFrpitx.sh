#!/bin/bash
# This script Tests the festival and nbfm install
#
# Written: 4/8/2017
#    Rev.: 1.00
#      By: Robert S. Rau & Rob F. Rau II
#
# Updated: 4/23/2017
#    Rev.: 1.01
#      By: Robert S. Rau
# Changes: replaced python control of RF amp with gpio commands
#
#
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
#
# Now convert the WAV file to a frequency-time file
sudo ./pifm t.wav fm.ft
#
# Select GPIO4, pin 7, for the transmitter carrier. Turn the RF amplifier on.
#
# RF carrier multiplexer
gpio -g mode 27 out
gpio -g write 27 1
#
# RF amplifier power
gpio -g mode 6 out
gpio -g write 6 1#
#
#
#
#rpitx [-i File Input][-m ModeInput] [-f frequency output] [-s Samplerate] [-l] [-p ppm] [-h]
#-m            {IQ(FileInput is a Stereo Wav contains I on left Channel, Q on right channel)}
#              {IQFLOAT(FileInput is a Raw float interlaced I,Q)}
#              {RF(FileInput is a (double)Frequency,Time in nanoseconds}
#       	      {RFA(FileInput is a (double)Frequency,(int)Time in nanoseconds,(float)Amplitude}
#	      {VFO (constant frequency)}
#-i            path to File Input
#-f float      frequency to output on GPIO_18 pin 12 in khz : (130 kHz to 750 MHz),
#-l            loop mode for file input
#-p float      frequency correction in parts per million (ppm), positive or negative, for calibration, default 0.
#-d int 	      DMABurstSize (default 1000) but for very short message, could be decrease
#-c 1          Transmit on GPIO 4 (Pin 7) instead of GPIO 18
#-h            help (this help).
# Transmit the WAV file
sudo ./rpitx -m RF -i fm.ft -f 433900 -c 1
