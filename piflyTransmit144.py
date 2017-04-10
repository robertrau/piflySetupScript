#!/usr/python
# This script sets a PiFly up for transmitting
#
#Written: 4/8/2017
#  Rev.: 1.00
#   By: Robert S. Rau & Rob F. Rau II
#
try:
    import RPi.GPIO as GPIO
except RuntimeError:
    print("Error importing RPi.GPIO!This is probably because you need superuser privileges.  You can achieve this by using 'sudo' to run your script")
from time import sleep
try:
    GPIO.setmode(GPIO.BOARD)
except RuntimeError:
    print("Error setmode")
print("Direction Out")
try:
    GPIO.setup(31, GPIO.OUT)
except RuntimeError:
    print("Error setup")
GPIO.setup(13, GPIO.OUT)
sleep(5)
print("Setting High")
GPIO.output(31, GPIO.HIGH)   # tx enable
GPIO.output(13, GPIO.HIGH)   # mux
