#!/bin/bash
# This script shuts down the RF amplifier
# See www.rau-deaver.org/Project_PiFly.html
#
#Written: 4/23/2017
#  Rev.: 1.00
#   By: Robert S. Rau
#
#
# RF amplifier power
gpio -g mode 6 out
gpio -g write 6 0