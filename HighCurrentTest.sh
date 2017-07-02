#!/bin/bash
# This script tests the high current outputs
# See www.rau-deaver.org/Project_PiFly.html
#
# Written: 6/23/2017
#    Rev.: 1.00
#      By: Robert S. Rau
#
# Written: 6/24/2017
#    Rev.: 1.01
#      By: Robert S. Rau
# Changes: changed sleep values added first sleep. updated last echo. Set all fires low on exit
#
#
# setup outputs
gpio -g mode 17 out   # Fire A output
gpio -g mode 22 out   # Fire B output
gpio -g mode 23 out   # Fire C output
gpio -g mode 24 out   # Fire D output
gpio -g write 17 0   # Fire A set to zero
gpio -g write 22 0   # Fire B set to zero
gpio -g write 23 0   # Fire C set to zero
gpio -g write 24 0   # Fire D set to zero
gpio -g mode 25 out   # Arm clock set to output
gpio -g write 25 0   # Arm clock set to zero
sleep 1
gpio -g write 25 1   # Arm clock set to one, now armed, red LED should be on
echo "Red armed LED should be on"
sleep 1
gpio -g write 17 1   # Fire A set to one
echo "Output A should be at Battery + voltage"
sleep 2
gpio -g write 22 1   # Fire B set to one
echo "Output B should be at Battery + voltage"
sleep 2
gpio -g write 23 1   # Fire C set to one
echo "Output C should be at Battery + voltage"
sleep 2
gpio -g write 24 1   # Fire D set to one
echo "Output D should be at Battery + voltage"
sleep 2
gpio -g write 25 0   # Arm clock set to zero
gpio -g write 25 1   # Arm clock set to one, now armed, red LED should be off
echo "Red armed LED should be off, all outputs should be off"
gpio -g write 17 0   # Fire A set to zero
gpio -g write 22 0   # Fire B set to zero
gpio -g write 23 0   # Fire C set to zero
gpio -g write 24 0   # Fire D set to zero
