#!/bin/bash
# This script takes a fresh Raspberry Pi Zero Bullseye install with desktop and recommended software (No other installations!)
#  and sets up the PiFly development/operational environment
# See www.rau-deaver.org/Project_PiFly.html
#
# Written: 3/26/2017
#    Rev.: 1.00
#      By: Robert S. Rau & Rob F. Rau II
#
# Updated: 3/26/2017
#    Rev.: 1.01
#      By: Robert S. Rau & Rob F. Rau II
# Changes: fixed matplotlib, creating pifly/log, pkt2wave
#
# Updated: 3/26/2017
#    Rev.: 1.02
#      By: Robert S. Rau & Rob F. Rau II
# Changes: added links for GPIO support, audio output, shutdown support, I2C, SPI. setup. Updated gcc command line for nbfm. cd to working directory in #1 (pifly)
#
# Updated: 4/2/2017
#    Rev.: 1.03
#      By: Robert S. Rau & Rob F. Rau II
# Changes: added sudo check, added cmdline.txt, added apt-get update
#
# Updated: 4/2/2017
#    Rev.: 1.04
#      By: Robert S. Rau & Rob F. Rau II
# Changes: added logging
#
# Updated: 4/4/2017
#    Rev.: 1.05
#      By: Robert S. Rau & Rob F. Rau II
# Changes: fixed file append for log file, added linux version, Pi version, and date/time to log, comments about time setup, changed log file name to all lower case, Adafruit_GPIO_Hale
#
# Updated: 4/5/2017
#    Rev.: 1.06
#      By: Robert S. Rau & Rob F. Rau II
# Changes: fixed file append for log file after scrot and matplorlib
#
# Updated: 4/8/2017
#    Rev.: 1.07
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Set local directory before many installs, started the shutdown monitor
#
# Updated: 4/8/2017
#    Rev.: 1.08
#      By: Robert S. Rau & Rob F. Rau II
# Changes: added pifm, copy cmdline to log, 
#
# Updated: 4/8/2017
#    Rev.: 1.09
#      By: Robert S. Rau & Rob F. Rau II
# Changes: changed $HOME to /home/pi/ because while in sudo, $HOME is /root
#
# Updated: 4/9/2017
#    Rev.: 1.10
#      By: Robert S. Rau & Rob F. Rau II
# Changes: added "Things to think about" comments, added usb info to log, added pifm install diagnostic, added USB drive writability (broken), added Remember to set country and time zone at end. added network connection check
#
# Updated: 4/14/2017
#    Rev.: 1.11
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Fixed pifm compile, Added gcc & g++ errors to log file
#
# Updated: 4/15/2017
#    Rev.: 1.11
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Fixed pifm compile again. Added to 'things to think about'
#
# Updated: 4/15/2017
#    Rev.: 1.12
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Fixed echo mesage for pifm gcc message. Added comments about setting I2C speed to 400kHz and SPI speed. 
#
# Updated: 4/16/2017
#    Rev.: 1.13
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Added rule for making USB drives writable
#
# Updated: 4/16/2017
#    Rev.: 1.14
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Cleanup to USB rule, added 11-media-by-label-auto-mount.rules to git
#
# Updated: 4/16/2017
#    Rev.: 1.15
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Fixed git clone errors on a second run of this script
#
# Updated: 4/17/2017
#    Rev.: 1.16
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Added I2C-tools install. Added to things to think about
#
# Updated: 4/19/2017
#    Rev.: 1.17
#      By: Robert S. Rau & Rob F. Rau II
# Changes: updated pifm install
#
# Updated: 4/20/2017
#    Rev.: 1.18
#      By: Robert S. Rau & Rob F. Rau II
# Changes: fixed typos and directory check syntax
#
# Updated: 4/20/2017
#    Rev.: 1.19
#      By: Robert S. Rau & Rob F. Rau II
# Changes: fixed pifly dir create (check first), fixed echos
#
# Updated: 4/22/2017
#    Rev.: 1.20
#      By: Robert S. Rau & Rob F. Rau II
# Changes: fixed pifly dir create (added echo to log file to fix syntax error), fixed echos to log (removed reference to mkdir errors), fixed pifm g++, changed nbfm install from wget to git clone
#
# Updated: 4/22/2017
#    Rev.: 1.21
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Fixed chown on NBFM, added chmod for TX-CPUTemp... in NBFM, cleaned up and added to system status log in beginning. Added additional comments for beginners.
#
# Updated: 4/23/2017
#    Rev.: 1.22
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Added to 'Things to think about'. moved rpitx demo script into rpitx directory
#
# Updated: 4/24/2017
#    Rev.: 1.23
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Slowed down speech from test2wave
#
# Updated: 4/25/2017
#    Rev.: 1.24
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Moved Demo144-39MHz.sh into rpitx directory. added pifly setup script version logging. Added user instructions at end of install.
#
# Updated: 4/25/2017
#    Rev.: 1.25
#      By: Robert S. Rau & Rob F. Rau II
# Changes: typos
#
# Updated: 4/30/2017
#    Rev.: 1.26
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Festival fails to operate correctly when installed after rpitx and matplotlib, moved near top, sed substitute syntax fixed, now use double quotes. push button shutdown is now broken :-(, don't know why yet.
#
# Updated: 4/30/2017
#    Rev.: 1.27
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Added SoX to install so text2wave could work with smaller sample rates and then we could resample up to 48000 for pifm to produce a .ft file for rpitx, added gpio_alt and used it to tie PWM1 to GPIO13. some sudos removed
#
# Updated: 5/7/2017
#    Rev.: 1.28
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Clean up log file entries, put festival install back to the audio section, real issue was text2wave sample rate.
#
# Updated: 5/7/2017
#    Rev.: 1.29
#      By: Robert S. Rau & Rob F. Rau II
# Changes: edits to .bashrc to uncomment alias', got rid of extra sudo commands
#
# Updated: 5/9/2017
#    Rev.: 1.30
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Fixed bashrc edit. 
#
# Updated: 5/14/2017
#    Rev.: 1.31
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Re-fixed bashrc edit and added gpio-halt to rc.local
#
# Updated: 5/15/2017
#    Rev.: 1.32
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Post install summary updated.
#
# Updated: 5/29/2017
#    Rev.: 1.33
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Installed gpio man page
#
# Updated: 6/23/2017
#    Rev.: 1.34
#      By: Robert S. Rau & Rob F. Rau II
# Changes: added python dev tools
#
# Updated: 7/1/2017
#    Rev.: 1.35
#      By: Robert S. Rau & Rob F. Rau II
# Changes: sed now generally returns success of replace (added ;q).  gpio-halt will no longer re-append to rc.local. gpio_alt now properly appends to rc.local
#
# Updated: 7/3/2017
#    Rev.: 1.36
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Summary at end now in green text, fixed rc.local edits
#
# Updated: 7/4/2017
#    Rev.: 1.37
#      By: Robert S. Rau & Rob F. Rau II
# Changes: sed with ;q is causing all but the first line of a file to be deleted, removed
#
# Updated: 7/5/2017
#    Rev.: 1.38
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Added GPS reset to rc.local. Added cmake and screen to dev tool installs. Re-orged summary, Change I2C bus speed to 400kHz (cmdline.txt).
#
# Updated: 7/9/2017
#    Rev.: 1.39
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Added more GPIO setup (LEDs and RF). Added LED support to shutdown program.
#
# Updated: 7/9/2017
#    Rev.: 1.40
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Added missing -y options to apt-git is several places, RF demo file names fixed, cmdline now enables i2c and SPI
#
# Updated: 7/9/2017
#    Rev.: 1.41
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Added gpsbabel install.  Interrupt input setup. 
#
# Updated: 7/16/2017
#    Rev.: 1.42
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Added Adafruit Python Servo library. Overlay to disable Bluetooth on RPi3 & RPi Zero W so GPS can have the good serial port, necessary for 50 Hz updates. moved date header to top of log file, added disk space. Report disk space at end.
#
# Updated: 7/16/2017
#    Rev.: 1.43
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Fixed omissions from log file (python stuff, servo lib...). added hexdump install. dtparam=i2c1_baudrate=400000 isn't working, i2c still running at 66,666Hz. Another try to make Pi Zero work with GPS.
#
# Updated: 7/17/2017
#    Rev.: 1.44
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Added setserial to install. Changed edits to cmdline.txt for GPS serial port. Added text to disk free space report at end. Added raspi-gpio get to logfile at end.
#
# Updated: 8/4/2017
#    Rev.: 1.45
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Enable camera and installed python-picamera. Added I2C to /etc/modules. Enable GPIO HALT at end of script.
#
# Updated: 8/6/2017
#    Rev.: 1.46
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Commented out camera stuff, script was hanging. added & updated diagnostic echo stuff.
#
# Updated: 8/6/2017
#    Rev.: 1.47
#      By: Robert S. Rau & Rob F. Rau II
# Changes: I2C speed now at 200000Hz
#
# Updated: 8/22/2017
#    Rev.: 1.48
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Added RTIMULib install. added support for a run log file. Added Organization comments.
#
# Updated: 8/23/2017
#    Rev.: 1.49
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Improved df formating and added pre and post install in log file. Added boot message in run log file. Changed Adafruit-GPIO-Halt to my forked version. Restored UART to working version.
#
# Updated: 8/23/2017
#    Rev.: 1.50
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Also remove console=tty1 from cmdline.txt. Fixed disk usage and time errors to log file. Fixed RTIMULib demo installs. Added piflysetup version to run log.
#
# Updated: 8/23/2017
#    Rev.: 1.51
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Fixed RTIMULib install. Another whack at I2C, added dtparam=i2c_arm=on to cmdline.
#
# Updated: 8/24/2017
#    Rev.: 1.52
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Fixed RTIMULib install, again, and added diagnostics to log file. Added note at beginning to change Scroll-back lines.
#
# Updated: 8/24/2017
#    Rev.: 1.53
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Install cmake before needing it!
#
# Updated: 8/24/2017
#    Rev.: 1.54
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Added GPIO pull ups to interrupt, shutdown, and bus inputs.
#
# Updated: 8/25/2017
#    Rev.: 1.55
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Added RTC support.
#
# Updated: 9/5/2017
#    Rev.: 1.56
#      By: Robert S. Rau & Rob F. Rau II
# Changes: Added pifly version of RTIMULib.ini
#
# Updated: 3/22/2018
#    Rev.: 1.57
#      By: Robert S. Rau
# Changes: Added starting directory and who to log file, moved logfile stuff to after sudo check
#
# Updated: 8/19/2018
#    Rev.: 1.58
#      By: Robert S. Rau
# Changes: Commented out "make USB drives writable" since newer Raspians now do it
#
# Updated: 3/28/2022
#    Rev.: 1.59
#      By: Robert S. Rau
# Changes: Update for Bullseye version of Raspian
#
# Updated: 3/29/2022
#    Rev.: 1.60
#      By: Robert S. Rau
# Changes: removed SOX, python-matplotlib. added install cutecom
#
# Updated: 9/4/2023
#    Rev.: 1.61
#      By: Robert S. Rau
# Changes: Updated gpio shutdown and enabling i2c, i2s, and spi. switched from apt-get to apt.
#
PIFLYSETUPVERSION=1.61
#
# Things to think about
# 1) Should we set up an email account "PiFlyUser" to make it easier for users to share or report problems?
# 2) Should we set up a blog for sharing?
# 3) Should this script ask for a call sign during setup, install differently if none provided?
# 4) Should the shutdown button enable be delayed to the very end of the script? -- last thing enabled, all good now
# 5) Should the end of the script remind the user to set time zone, country, and so on? -- Done
# 6) Cleanup, remove source and unnecessary files? -- No, there is plenty of space.
# 7) Need to abort on failure
# 8) Need to check that there is enough space to do the whole install.
# 9) How to get pifm and nbfm to work on any NOOBS from 1.9.2 on?, They work on NOOBS 1.50, 1.70, 1.80, 1.90. rpitx works on 2.3.0
# 10) text2wave can't make a very long file with -F 48000 (needed for rpitx) for some reason, we now must use -F 6000 and SoX to change
# 11) Need to insert line into gpio-halt code to turn on Shutdown LED D7 on GPIO16 (pin 36) - done
# 12) Need to figure out how to use pi3-disable-bt.dtbo overlay so Pi Zero-W can be used with GPS. See: https://www.raspberrypi.org/documentation/configuration/uart.md
# 13) dtparam=i2c1_baudrate=400000 isn't working, i2c still running at 66,666Hz for i2cdetect and flips from 100kHz to and from 66kHz in Python.
# 14) Found set_config_var command here:http://iot.technoedu.com/forums/topic/raspicam-solved-how-can-i-enable-the-camera-without-using-raspi-config/  How does it work?
# 15) If halt request is low when Linux comes up (like when running from USB +5 on Pi and no battery connected with W5 closed), the shutdown command is never issued or recognized. The GPIO interrupt is edge sensitive, not level sensitive.
# 16) must look at RTC   https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=161133      and     https://www.raspberrypi.org/forums/viewtopic.php?f=37&t=59808
#
#
#
#
# Organization
# 0) Pre run checks. Check that we are running with root permissions, we have a internet connection and log who we are and what is connected.
# 1) Setup directory structure
# 2) Set up Raspberry Pi configuration
# 3) install RF transmitters and modulators
# 4) install audio support
# 5) Graphics for Video downlink support
# 6) High current/GPS/RF/LED output support
# 7) IMU (MPS9250) support
# 8) RTC support
# 9) Developer tools
#
#
#
#
mydirectory=$(pwd)     #  remember what directory I started in
#
########## 0) Pre run checks. Check that we are running with root permissions, we have a internet connection and log who we are and what is connected.
tput setaf 5        # highlight text magenta
echo "Set Terminal Scroll-back lines to 4500 to record whole install. Set terminal window to full width of screen for best readability."
tput setaf 7        # return text to normal
#
if [[ $EUID > 0 ]]; then
	echo "Please run using: sudo ./piflysetup.sh"
    sudo echo "PiFly Setup: Aborted, not in sudo." $(date +"%A,  %B %e, %Y, %X %Z") >> $logFilePath
    exit
fi
logFilePath=/var/log/piflyinstalllog.txt
runlogFilePath=/var/log/piflyrunlog.txt
echo "" >> $logFilePath
echo "Install started " $(date +"%A,  %B %e, %Y, %X %Z") >> $logFilePath
echo "PiFly Setup: Script version" $PIFLYSETUPVERSION >> $logFilePath
echo "PiFly Setup: ran from directory:" $mydirectory >> $logFilePath
whoami >> $logFilePath
ping -c 1 8.8.8.8
if [[ $? > 0 ]]; then
    echo ""
    echo "No Network connection. Have you connected with your WiFi network or plugged in your network cable before running this?"
    echo "PiFly Setup: Aborted, no network connection, ping 8.8.8.8 failed" >> $logFilePath
    exit
fi
echo "PiFly Setup: Have network connection" >> $logFilePath
echo "" >> $logFilePath
echo "PiFly Setup: uname -a:" >> $logFilePath
uname -a >> $logFilePath
echo "" >> $logFilePath
echo "PiFly Setup: cat /proc/cpuinfo:" >> $logFilePath
cat /proc/cpuinfo >> $logFilePath
echo "" >> $logFilePath
echo "PiFly Setup: lsusb -t:" >> $logFilePath
lsusb -t  >> $logFilePath
echo "" >> $logFilePath
echo "PiFly Setup: lsmod:" >> $logFilePath
lsmod >> $logFilePath
#
df -PBMB | grep -E '^/dev/root' | awk '{ print "PiFly Setup: Free SD card space before install " $4 " of " $2 }' >> $logFilePath
#
#
#
#
#
#
#
#
########## 1) Setup directory structure
echo "PiFly setup: Starting directory setup and git update" >> $logFilePath
echo "" >> $logFilePath
echo "PiFly setup: Starting directory setup"
cd /home/pi
if [ -d pifly ]; then
  echo "PiFly Setup: pifly directory already exists: result" $? >> $logFilePath
else
  mkdir pifly
  echo "PiFly Setup: pifly directory created: result" $? >> $logFilePath
fi
chown pi:pi pifly     # because when this script is run with sudo, everything belongs to root
echo "PiFly Setup: mkdir pifly: result" $? >> $logFilePath
# switch to install directory
cd /home/pi/pifly
#
#
#
apt update
echo "PiFly Setup: apt update: result" $? >> $logFilePath
#
#
echo "New install of piflysetup version " $PIFLYSETUPVERSION " on" $(date +'%A,  %B %e, %Y, %X %Z') >> $runlogFilePath
#
#
# Clock summary added 3/28/2022
echo " " >> $logFilePath
echo "Clock summary" >> $logFilePath
cat /sys/kernel/debug/clk/clk_summary >> $logFilePath
echo " " >> $logFilePath
#
########## 2) Set up Raspberry Pi configuration
# see:https://www.raspberrypi.org/forums/viewtopic.php?f=44&t=130619
# for SPI see (see DMA note at bottom):https://www.raspberrypi.org/documentation/hardware/raspberrypi/spi/README.md
echo "PiFly setup: Starting Raspberry Pi configuration"
#
#
#
#######################################
# Shutdown stuff: 2023: all this is now handled by the Linux device tree. See:
#   https://raspberrypi.stackexchange.com/questions/139767/detect-shutdown-via-gpio
#   About half way down the page of: https://www.raspberrypi.com/documentation/computers/configuration.html#part1.1
#   https://raspberrypi.stackexchange.com/questions/137493/raspberry-pi-gpio-shutdown-reboot-options
#   https://forums.raspberrypi.com/viewtopic.php?t=310269
#   https://raspberrypi.stackexchange.com/questions/77905/raspberry-pi-3-model-b-dtoverlay-gpio-shutdown
# HALTGPIOBIT selects the GPIO port (BCM number, not pin number)
HALTGPIOBIT=26
echo "dtoverlay=gpio-shutdown,gpio_pin="$HALTGPIOBIT",active_low=1,gpio_pull=up,debounce=1000"  >> /boot/config.txt
#
#
# Enable I2c, SPI, I2S.
# see  http://raspberrypi.stackexchange.com/questions/14229/how-can-i-enable-the-camera-without-using-raspi-config
echo "PiFly setup: Enabeling i2c, i2s, spi in config.txt" >> $logFilePath
sed -i.bak -e 's/#dtparam=i2c_arm=on/dtparam=i2c_arm=on/' /boot/config.txt  #  enable i2c for several sensors
sed -i.bak -e 's/#dtparam=i2s=on/dtparam=i2s=on/' /boot/config.txt  #  enable i2s for microphone
sed -i.bak -e 's/#dtparam=spi=on/dtparam=spi=on/' /boot/config.txt  #  enable spi
echo "dtparam=i2c1=on"  >> /boot/config.txt
echo "dtparam=i2c1_baudrate=200000"  >> /boot/config.txt
#
#
# Edit cmdline.txt so serial port is available for GPS. This disables bluetooth on Raspberry Pi 3 and Raspberry Pi Zero W boards.
# found https://openenergymonitor.org/forum-archive/node/12311.html
# See https://github.com/raspberrypi/linux/blob/rpi-4.1.y/arch/arm/boot/dts/overlays/pi3-disable-bt-overlay.dts
echo "PiFly setup: Starting Serial setup" >> $logFilePath
echo "PiFly Setup: cmdline.txt was:" >> $logFilePath
cat /boot/cmdline.txt >> $logFilePath
sed -i.bak -e 's/console=ttyAMA0\,115200 //' /boot/cmdline.txt  # remove Linux console access to our GPS serial port
sed -i.bak -e 's/kgdboc=ttyAMA0,115200 //' /boot/cmdline.txt    # remove Linux console access to our GPS serial port
sed -i.bak -e 's/console=serial0,115200 //' /boot/cmdline.txt   # remove Linux console access to our GPS serial port
sed -i.bak -e 's/console=tty1 //' /boot/cmdline.txt             # remove Linux console access to our GPS serial port
echo "PiFly Setup: cmdline.txt update for serial: result" $? >> $logFilePath
#systemctl disable hciuart
#echo "PiFly Setup: systemctl disable hciuart: result" $? >> $logFilePath
echo "PiFly Setup: cmdline.txt after serial updates:" >> $logFilePath
cat /boot/cmdline.txt >> $logFilePath
# also make sure the uart is not disabled in config.txt
#sed -i 's/enable_uart=0/enable_uart=1/' /boot/config.txt      #######   2023: OUT OF DATE  no uart stuff in config.txt  see: https://openenergymonitor.github.io/forum-archive/node/12311.html
#        May be different from Pi Zero to Pi Zero 2 W
#echo "PiFly Setup: sed -i 's/enable_uart=0/enable_uart=1/' /boot/config.txt: result" $? >> $logFilePath
#sed -i 's/#enable_uart=1/enable_uart=1/' /boot/config.txt
#echo "PiFly Setup: sed -i 's/#enable_uart=1/enable_uart=1/' /boot/config.txt: result" $? >> $logFilePath
#
#  disable bluetooth since we took its serial port away.
echo "dtoverlay=disable-bt"  >> /boot/config.txt
#
#
#
# Enable I2C and set I2C speed to 200kHz
#    snatched from raspi-config
echo "PiFly Setup: Starting I2C setup" >> $logFilePath
if ! grep -q "^i2c[-_]dev" /etc/modules; then
    printf "i2c-dev\n" >> /etc/modules
  fi
#
sed -i '/=/ s/$/ dtparam=i2c_arm=on dtparam=i2c1=on dtparam=i2c1_baudrate=200000/' /boot/cmdline.txt
echo "PiFly Setup: cmdline.txt update for i2c: result" $? >> $logFilePath
echo "PiFly Setup: cmdline.txt after i2c updates:" >> $logFilePath
cat /boot/cmdline.txt >> $logFilePath
#
#
#
#
# SPI 
# https://raspberrypi.stackexchange.com/questions/699/what-spi-frequencies-does-raspberry-pi-support
echo "PiFly Setup: Starting SPI setup" >> $logFilePath
sed -i '/=/ s/$/ dtparam=spi=on/' /boot/cmdline.txt
echo "PiFly Setup: cmdline.txt update for SPI: result" $? >> $logFilePath
echo "PiFly Setup: cmdline.txt after SPI updates:" >> $logFilePath
cat /boot/cmdline.txt >> $logFilePath
#
#
#
# Setup i2s for microphone
#  add dtparam=i2s=on to cmdline.txt    gpio alt for i2s input should be i2s-in but i2s output should be normal gpio output for GPS reset
# See: https://learn.adafruit.com/adafruit-i2s-mems-microphone-breakout/raspberry-pi-wiring-and-test
#
# Setup camera
#
#   with help from
#     https://raspberrypi.stackexchange.com/questions/10357/enable-camera-without-raspi-config/14400
#     https://core-electronics.com.au/tutorials/create-an-installer-script-for-raspberry-pi.html
#
#
#
#
#
# update run log on startup
sed -i.bak -e "s/exit 0//" /etc/rc.local
echo 'echo "PiFly booted on " $(date +"%A,  %B %e, %Y, %X %Z") >> /var/log/piflyrunlog.txt' >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
#
#
#
#
########## 3) install RF transmitters and modulators
#
#  nbfm - narrow band FM - 144MHz transmitter, uses GPIO4
echo "PiFly setup: Starting nbfm setup" >> $logFilePath
cd /home/pi/pifly
if [ -d NBFM ]; then
  cd NBFM
  git pull
  echo "PiFly Setup: git pull of nbfm: result" $? >> $logFilePath
else
  git clone https://github.com/fotografAle/NBFM
  echo "PiFly Setup: git clone of nbfm: result" $? >> $logFilePath
  cd ./NBFM
fi
chmod +x TX-CPUTemp.sh
echo "PiFly Setup: chmod +x TX-CPUTemp.sh: result" $? >> $logFilePath
echo "PiFly Setup: Starting gcc -O3 -std=gnu99 -o nbfm nbfm.c -lm &>> $logFilePath " >> $logFilePath
gcc -O3 -std=gnu99 -o nbfm nbfm.c -lm &>> $logFilePath                 # changed from -std=c99 to -std=gnu99, and -o3 to -O3. 3/28/2022 moved -lm to end for Bullseye
echo "PiFly Setup: gcc -O3 -std=gnu99 -o nbfm nbfm.c -lm &>> $logFilePath : result" $? >> $logFilePath
cd /home/pi/pifly
chown -R pi:pi NBFM     # because when this script is run with sudo, everything belongs to root
echo "PiFly Setup: chown -R pi:pi NBFM: result" $? >> $logFilePath
#
#
#  rpitx - able to TX on 440MHz band, uses GPIO18 or GPIO4
echo "PiFly setup: Starting rpitx setup" >> $logFilePath
cd /home/pi/pifly
if [ -d rpitx ]; then
  cd rpitx
  git pull
  echo "PiFly Setup: git pull of rpitx: result" $? >> $logFilePath
else
  git clone https://github.com/F5OEO/rpitx
  echo "PiFly Setup: git clone of rpitx: result" $? >> $logFilePath
  cd ./rpitx
fi
./install.sh
echo "PiFly Setup: rpitx install: result" $? >> $logFilePath
#
# Fetch demo scripts
cp /home/pi/piflySetupScript/text2RFrpitx.sh .
echo "PiFly Setup: cp /home/pi/piflysetupscript/text2RFrpitx.sh .: result" $? >> $logFilePath
mv /home/pi/piflySetupScript/Demo144-39MHz.sh .
echo "PiFly Setup: mv /home/pi/piflysetupscript/Demo144-39MHz.sh .: result" $? >> $logFilePath
cd /home/pi/pifly
chown -R pi:pi rpitx     # because when this script is run with sudo, everything belongs to root
echo "PiFly Setup: chown -R pi:pi rpitx: result" $? >> $logFilePath
#
#
#
#
#  pifm - able to TX on 144MHz band, uses GPIO4
echo "PiFly setup: Starting pifm setup" >> $logFilePath
cd /home/pi/pifly
if [ -d pifm ]; then
  cd pifm
  git pull
  echo "PiFly Setup: git pull of pifm: result" $? >> $logFilePath
else
  git clone https://github.com/rm-hull/pifm
  echo "PiFly Setup: git clone of pifm: result" $? >> $logFilePath
  cd ./pifm
fi
chown pi:pi pifm.cpp     # because when this script is run with sudo, everything belongs to root
echo "PiFly Setup: chown pi:pi pifm.cpp: result" $? >> $logFilePath
g++ -O3 -o pifm pifm.cpp &>> $logFilePath
echo "PiFly Setup: pifm:g++ pifm: result" $? >> $logFilePath
cd /home/pi/pifly
chown -R pi:pi pifm     # because when this script is run with sudo, everything belongs to root
#
#
#  Packet radio modulator. Text to modem .WAV file
cd /home/pi/pifly
wget https://raw.githubusercontent.com/km4efp/pifox/master/pifox/pkt2wave
echo "PiFly Setup: wget pkt2wave: result" $? >> $logFilePath
chmod +x pkt2wave
chown pi:pi pkt2wave     # because when this script is run with sudo, everything belongs to root
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
########## 4) install audio support
#
# Text to speech and text to wave support    see:https://learn.adafruit.com/speech-synthesis-on-the-raspberry-pi/installing-the-festival-speech-package  ***** moved to top  ****
#
#
# set up audio output
#  https://learn.adafruit.com/adding-basic-audio-ouput-to-raspberry-pi-zero/pi-zero-pwm-audio
echo "PiFly setup: Starting raspi-gpio setup" >> $logFilePath
apt install raspi-gpio
echo "PiFly Setup: apt install raspi-gpio: result" $? >> $logFilePath
#
# now get gpio_alt.c
cd /home/pi/pifly
if [ -d LEDMatrix ]; then
  cd LEDMatrix
  git pull
  echo "PiFly Setup: git pull of LEDMatrix: result" $? >> $logFilePath
else
  git clone https://github.com/KawaniwaHikaru/LEDMatrix
  echo "PiFly Setup: git clone of LEDMatrix: result" $? >> $logFilePath
  cd ./LEDMatrix
fi
#
cat /etc/rc.local | grep -q gpio_alt
GPIO_ALT_NOT_FOUND=$?
if [ $GPIO_ALT_NOT_FOUND -eq 1 ]; then
  echo "PiFly Setup: gpio_alt not found in rc.local" >> $logFilePath
  cd src
  gcc -o gpio_alt gpio_alt.c
  echo "PiFly Setup: gcc of gpio_alt.c: result" $? >> $logFilePath
  chown root:root gpio_alt
  chmod u+s gpio_alt
  mv gpio_alt /usr/local/bin/
  echo "PiFly Setup: move of gpio_alt.c to /usr/local/bin/: result" $? >> $logFilePath
  gpio_alt -p 13 -f 0
  echo "PiFly Setup: gpio_alt -p 13 -f 0: result" $? >> $logFilePath
  sed -i.bak -e "/exit 0/i gpio_alt -p 13 -f 0" /etc/rc.local
  echo "PiFly Setup: sed -i.bak -e '/exit 0/i gpio_alt -p 13 -f 0': result" $? >> $logFilePath
else
  echo "PiFly Setup: gpio_alt already in rc.local" >> $logFilePath
fi
#
#
#
#
#
# Text to speech and text to wave support    see:https://learn.adafruit.com/speech-synthesis-on-the-raspberry-pi/installing-the-festival-speech-package
echo "PiFly setup: Startingfestivalsetup"
apt -y install festival
echo "PiFly Setup: apt festival: result" $? >> $logFilePath
#
# Slow down rate of speech a bit
sed -i.bak -e "s/(Parameter.set 'Duration_Stretch 1.1)/(Parameter.set 'Duration_Stretch 1.6)/"  /usr/share/festival/voices/english/kal_diphone/festvox/kal_diphone.scm
echo "PiFly Setup: sed, Slow down of speech: result" $? >> $logFilePath
#
#
#
#
# SoX resample support
#echo "PiFly setup: StartingSoXsetup"
#apt -y install SoX
#echo "PiFly Setup: apt SoX: result" $? >> $logFilePath
#
#
#
#
#
#
#
########## 5) Graphics for Video downlink support
#
# Python matplotlib
#echo "PiFly setup: Starting python-matplotlib setup" >> $logFilePath
#apt -y install python-matplotlib
#
#echo "PiFly Setup: apt python-matplotlib: result" $? >> $logFilePath
#
#
#
#
#
#
#
#
########## 6) High current/GPS/RF/LED output support
#
cat /etc/rc.local | grep -q write
HIGH_CURRENT_OUT_NOT_FOUND=$?
if [ $HIGH_CURRENT_OUT_NOT_FOUND -eq 1 ]; then
  echo "PiFly Setup: High current/GPS support not found in rc.local" >> $logFilePath
  sed -i.bak -e "s/^exit 0//" /etc/rc.local   # remove the exit 0 at end (not the one in the comment)
  echo "gpio -g mode 21 out   # GPS reset to output" >> /etc/rc.local
  echo "gpio -g write 21 0   # assert GPS reset" >> /etc/rc.local
  echo "gpio -g mode 17 out   # Fire A output" >> /etc/rc.local
  echo "gpio -g mode 22 out   # Fire B output" >> /etc/rc.local
  echo "gpio -g mode 23 out   # Fire C output" >> /etc/rc.local
  echo "gpio -g mode 24 out   # Fire D output" >> /etc/rc.local
  echo "gpio -g write 17 0   # Fire A set to zero" >> /etc/rc.local
  echo "gpio -g write 22 0   # Fire B set to zero" >> /etc/rc.local
  echo "gpio -g write 23 0   # Fire C set to zero" >> /etc/rc.local
  echo "gpio -g write 24 0   # Fire D set to zero" >> /etc/rc.local
  echo "gpio -g mode 25 out   # Arm clock set to output" >> /etc/rc.local
  echo "gpio -g write 25 0   # Arm clock set to zero" >> /etc/rc.local
  echo "gpio -g mode 16 out   # LED Shutdown Ack output" >> /etc/rc.local
  echo "gpio -g mode 6 out   # LED & Radio RF amplifier output" >> /etc/rc.local
  echo "gpio -g write 16 0   # LED Shutdown Ack off" >> /etc/rc.local
  echo "gpio -g write 6 0   # LED & Radio RF amplifier off" >> /etc/rc.local
  echo "gpio -g write 21 1   # release GPS reset" >> /etc/rc.local
  echo "gpio -g mode 5 in   # interrupt input" >> /etc/rc.local
  echo "gpio mode 5 up   # interrupt input" >> /etc/rc.local
  echo "gpio -g mode 12 in   # interrupt input" >> /etc/rc.local
  echo "gpio mode 12 up   # interrupt input" >> /etc/rc.local
  echo "gpio mode 2 up   # i2c input/output" >> /etc/rc.local
  echo "gpio mode 3 up   # i2c input/output" >> /etc/rc.local
  echo "gpio mode 9 up   # SPI MISO input" >> /etc/rc.local
  echo "gpio mode 20 up   # I2S input" >> /etc/rc.local
  echo "exit 0" >> /etc/rc.local
  echo "PiFly Setup: High current/GPS/RF/LED setup added to rc.local" >> $logFilePath
fi
#
#
  echo "PiFly Setup: raspi-gpio get:" >> $logFilePath
raspi-gpio get  >> $logFilePath
#
#
#
#
########## 7) IMU (MPS9250) support
#
#
#
#
# First, tools to build all this...
# for libpifly and RTIMULib
apt -y install cmake
echo "PiFly Setup: apt -y install cmake: result" $? >> $logFilePath
#
#
# Second, Qt dependancies for demo programs
#
cd /home/pi/pifly
apt -y install qt4-dev-tools qt4-bin-dbg qt4-qtconfig qt4-default
#
if [ -d RTIMULib2 ]; then
  cd RTIMULib2
  echo "PiFly Setup: RTIMULib2 directory already exists, cd RTIMULib2: result" $? >> $logFilePath
  git pull
else
  git clone http://github.com/RTIMULib/RTIMULib2
  echo "PiFly Setup: git clone http://github.com/RTIMULib/RTIMULib2: result" $? >> $logFilePath
  cd RTIMULib2
fi
#chown -R pi:pi /home/pi/pifly/RTIMULib2     # because when this script is run with sudo, everything belongs to root
#
# build lib
echo "PiFly Setup: Starting RTIMULib library install" >> $logFilePath
cd RTIMULib
mkdir build
#chown -R pi:pi build
cd build
cmake ../ &>> $logFilePath
make &>> $logFilePath
make install &>> $logFilePath
#
# build demos
echo "PiFly Setup: Starting RTIMULib Demos install" >> $logFilePath
cd /home/pi/pifly/RTIMULib2/Linux/
mkdir build
#chown -R pi:pi /home/pi/pifly/RTIMULib2/
cd build
cmake ../ &>> $logFilePath
#chown -R pi:pi /home/pi/pifly/RTIMULib2/
make &>> $logFilePath
#chown -R pi:pi /home/pi/pifly/RTIMULib2/
make install &>> $logFilePath
ldconfig
#
#
#
chown -R pi:pi /home/pi/pifly/RTIMULib2     # because when this script is run with sudo, everything belongs to root
#
#
#
# Now copy the version of RTIMULib.ini for the pifly
cp /home/pi/piflySetupScript/RTIMULib.ini /home/pi/pifly/RTIMULib2/Linux/build/RTIMULibGL/CMakeFiles
#
########## 8) RTC support
#
sed -i '/=/ s/$/ dtoverlay=i2c-rtc,ds3231/' /boot/cmdline.txt
#edit the /lib/udev/hwclock-set file (sudo nano /lib/udev/hwclock-set) and "comment out" the following lines ("comment out" means put a # at the beginning of each of the lines, so they become comments and are ignored by the system)
#
# if [ -e /run/systemd/system ] ; then
# exit 0
# fi
#
#so they become:
#
# #if [ -e /run/systemd/system ] ; then
# # exit 0
# #fi
#
#
#
#
########## 9) Developer tools
#
#
# Python stuff
apt -y install build-essential python-dev python3-dev
echo "PiFly Setup: apt -y install python-smbus python3-smbus build-essential python-dev python3-dev: result" $? >> $logFilePath
#
#
#
# Install I2C tools
echo "PiFly setup: Starting i2c-tools setup" >> $logFilePath
apt -y install i2c-tools
echo "PiFly Setup: apt install i2c-tools: result" $? >> $logFilePath
#
#
# To view serial data for GPS
# to use:
#    screen /dev/ttyAMA0 9600
apt -y install screen
echo "PiFly Setup: apt -y install screen: result" $? >> $logFilePath
#
#
#
#  GPS format conversion tool
apt -y install gpsbabel
echo "PiFly Setup: apt -y install gpsbabel: result" $? >> $logFilePath
#
#
# setserial serial port configuration/reporting utility
apt -y install setserial
echo "PiFly Setup: apt -y install setserial: result" $? >> $logFilePath
#
#
# cutecom terminal emulator
apt -y install cutecom
echo "PiFly Setup: apt -y install cutecom: result" $? >> $logFilePath
#
#
# Adafruit PCA9685 Python library
cd /home/pi/pifly
git clone https://github.com/adafruit/Adafruit_Python_PCA9685.git
cd Adafruit_Python_PCA9685
echo "PiFly Setup: cd Adafruit_Python_PCA9685: result" $? >> $logFilePath
python setup.py install
echo "PiFly Setup: python setup.py install: result" $? >> $logFilePath
# Only servos 8 to 15 are on the PiFly, order is scrambled
cd /home/pi/pifly
chown -R pi:pi Adafruit_Python_PCA9685     # because when this script is run with sudo, everything belongs to root
#
#
# Setup a handy alias
echo "PiFly setup: Starting ~/.bashrc appending for an alias" >> $logFilePath
echo "alias ll='ls -alh'"  >> /home/pi/.bashrc
echo "PiFly Setup: ~/.bashrc appending for an alias: result" $? >> $logFilePath
#
#
# Add the gpio man page
cd /home/pi/pifly
if [ -d wiringPi ]; then
  cd wiringPi
  git pull
  echo "PiFly Setup: git pull of wiringPi: result" $? >> $logFilePath
  cp gpio/gpio.1 /usr/local/man/man1
else
  git clone git://git.drogon.net/wiringPi
  echo "PiFly Setup: git clone of wiringPi: result" $? >> $logFilePath
  cp wiringPi/gpio/gpio.1 /usr/local/man/man1
fi
#
#
#
# Math support
#sudo apt install octave
#
#
#
echo "" >> $logFilePath
echo "" >> $logFilePath
echo ""
echo ""
tput setaf 2      # highlight summary text green to make it more attention getting.
echo "PiFly Setup Script version" $PIFLYSETUPVERSION
echo "Most software is installed under ~/pifly. These files were changed: /boot/cmdline.txt, /etc/rc.local, and /home/pi/.bashrc"
echo "Installed software: pifm, nbfm, rpitx, pkt2wave, gpio-halt, gpio_alt, gpsbabel, screen, cmake, RTIMULib, setserial, cutecom, and festival"
echo "Installed Python libraries: build-essential, python-dev, python3-dev, adafruit-pca9685, and RTIMULib2"
echo "Hardware shutdown can be done by grounding GPIO" $HALTGPIOBIT "using switch SW1"
echo "PWM audio is available on GPIO13 and amplified on connector P4."
echo "GPIOs for high current outputs set to output zero. Added smbus (i2c) support to Python. ll alias setup in .bashrc."
echo " GPS data can be viewed using:  sudo screen /dev/ttyAMA0 9600 if not using libpifly (libpifly does 50 locations/sec in binary)"
df -PBMB | grep -E '^/dev/root' | awk '{ print "Free SD card space " $4 " of " $2 }'
df -PBMB | grep -E '^/dev/root' | awk '{ print "PiFly Setup: Free SD card space after install " $4 " of " $2 }' >> $logFilePath
echo "PiFly Setup: Install complete " $(date +"%A,  %B %e, %Y, %X %Z") >> $logFilePath
echo ""
#
tput setaf 5        # highlight text magenta
echo "You must re-boot for the changes to take effect. Remember to set country & time zone."
tput setaf 7        # back to normal
echo "Install complete " $(date +"%A,  %B %e, %Y, %X %Z") >> $runlogFilePath

# 
