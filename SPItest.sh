#!/bin/bash
# This script plays with SPI signals

#
# Written: 5/10/2017
#    Rev.: 1.00
#      By: Robert S. Rau
#
# Updated: 5/10/2017
#    Rev.: 1.01
#      By: Robert S. Rau
# Changes: removed sudo requirement, added channels, fixed missing $
#
#
#
#
# GPIO assignments
#
SPICLK=11
SPIMOSI=10
SPIMISO=9
SPIMMA6555=7
SPIADS7957=8
#
#
# Setup SPI bus
#
gpio -g mode $SPIADS7957 out
gpio -g write $SPIADS7957 1
gpio -g mode $SPIMMA6555 out
gpio -g write $SPIMMA6555 1
gpio -g mode $SPICLK out
gpio -g write $SPICLK 0
gpio -g mode $SPIMOSI out
gpio -g write $SPIMOSI 0
gpio -g mode $SPIMISO in
#
#
#
# assert CS    channel 0  (J7 pin 3), read out junk
gpio -g write $SPIADS7957 0
#
#
# Mode control register settings
ADRWORD="0"      #A/D Read WORD
CGRWORD="0"      #Channel or Gpio Read WORD
# SPI loop
#for (( bitCount = 1; bitCount <= 16; bitCount++ ))
#do
gpio -g write $SPIMOSI 0   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1   # enable prog bits 6-0
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0    # channel 0000
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0    # channel 0000
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0    # channel 0000
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0    # channel 0000
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1     # 5v ref
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   # no power down
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   # 4 MSBs are channel addr
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
#done
gpio -g write $SPIADS7957 1
echo $CGRWORD "  " $ADRWORD
#
#
#
#
#
#
# assert CS     mode: channel 6, temperature    read out channel 0
gpio -g write $SPIADS7957 0
#
#
# Mode control register settings
ADRWORD="0"      #A/D Read WORD
CGRWORD="0"      #Channel or Gpio Read WORD
# SPI loop
#for (( bitCount = 1; bitCount <= 16; bitCount++ ))
#do
gpio -g write $SPIMOSI 0   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1   # enable prog bits 6-0
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0    # channel 0110
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1    # channel 0110
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1    # channel 0110
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0    # channel 0110
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1     # 5v ref
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   # no power down
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   # 4 MSBs are channel addr
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
#done
gpio -g write $SPIADS7957 1
echo $CGRWORD "  " $ADRWORD
#
#
#
#
#
#
#
#
#
#
# assert CS     mode: channel 7, keypad    read out channel 6
gpio -g write $SPIADS7957 0
#
#
# Mode control register settings
ADRWORD="0"      #A/D Read WORD
CGRWORD="0"      #Channel or Gpio Read WORD
# SPI loop
#for (( bitCount = 1; bitCount <= 16; bitCount++ ))
#do
gpio -g write $SPIMOSI 0   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1   # enable prog bits 6-0
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0    # channel 0111
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1    # channel 0111
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1    # channel 0111
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1    # channel 0111
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1     # 5v ref
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   # no power down
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   # 4 MSBs are channel addr
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
#done
gpio -g write $SPIADS7957 1
echo $CGRWORD "  " $ADRWORD
#
#
#
#
#
# assert CS     mode: channel 15, fire A output voltage    read out channel 7
gpio -g write $SPIADS7957 0
#
#
# Mode control register settings
ADRWORD="0"      #A/D Read WORD
CGRWORD="0"      #Channel or Gpio Read WORD
# SPI loop
#for (( bitCount = 1; bitCount <= 16; bitCount++ ))
#do
gpio -g write $SPIMOSI 0   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1   # enable prog bits 6-0
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1    # channel 1111
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1    # channel 1111
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1    # channel 1111
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1    # channel 1111
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1     # 5v ref
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   # no power down
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   # 4 MSBs are channel addr
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
#done
gpio -g write $SPIADS7957 1
echo $CGRWORD "  " $ADRWORD
#
#
#
#
#
# assert CS     mode: channel 0    read out channel 15
gpio -g write $SPIADS7957 0
#
#
# Mode control register settings
ADRWORD="0"      #A/D Read WORD
CGRWORD="0"      #Channel or Gpio Read WORD
# SPI loop
#for (( bitCount = 1; bitCount <= 16; bitCount++ ))
#do
gpio -g write $SPIMOSI 0   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1   #Manual mode
gpio -g write $SPICLK 1
CGRWORD=$(($CGRWORD+$CGRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
CGRWORD=$(($CGRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1   # enable prog bits 6-0
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0    # channel 0000
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0    # channel 0000
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0    # channel 0000
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0    # channel 0000
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1     # 5v ref
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   # no power down
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 0   # 4 MSBs are channel addr
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
gpio -g write $SPIMOSI 1
gpio -g write $SPICLK 1
ADRWORD=$(($ADRWORD+$ADRWORD))
ADBIT="$(gpio -g read $SPIMISO)"
ADRWORD=$(($ADRWORD+$ADBIT))
gpio -g write $SPICLK 0
#
#done
gpio -g write $SPIADS7957 1
echo $CGRWORD "  " $ADRWORD
#