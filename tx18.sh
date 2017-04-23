#!/bin/bash
# This script selects GPIO18 as the RF carrier and turns on the RF amplifier
# See www.rau-deaver.org/Project_PiFly.html
#
#Written: 4/23/2017
#  Rev.: 1.00
#   By: Robert S. Rau
#
#
# RF carrier multiplexer
gpio -g mode 27 out
gpio -g write 27 0
#
# RF amplifier power
gpio -g mode 6 out
gpio -g write 6 1