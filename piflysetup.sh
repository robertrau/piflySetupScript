#!/bin/bash
# This script takes a fresh Raspberry Pi Zero NOOBS 2.3.0 install (No other installations!) and sets up the PiFly development environment
#
#Written: 3/26/2017
#  Rev.: 1.00
#   By: Robert S. Rau & Rob F. Rau II
#
#Updated: 3/26/2017
#  Rev.: 1.01
#   By: Robert S. Rau & Rob F. Rau II
# Changes: fixed matplotlib, creating pifly/log, pkt2wave
#
#Updated: 3/26/2017
#  Rev.: 1.02
#   By: Robert S. Rau & Rob F. Rau II
# Changes: added links for GPIO support, audio output, shutdown support, I2C, SPI. setup. Updated gcc command line for nbfm. cd to working directory in #1 (pifly)
#
#Updated: 4/2/2017
#  Rev.: 1.03
#   By: Robert S. Rau & Rob F. Rau II
# Changes: added sudo check, added cmdline.txt, added apt-get update
#
#Updated: 4/2/2017
#  Rev.: 1.04
#   By: Robert S. Rau & Rob F. Rau II
# Changes: added logging
#
#Updated: 4/4/2017
#  Rev.: 1.05
#   By: Robert S. Rau & Rob F. Rau II
# Changes: fixed file append for log file, added linux version, Pi version, and date/time to log, comments about time setup, changed log file name to all lower case, Adafruit_GPIO_Hale
#
#Updated: 4/5/2017
#  Rev.: 1.06
#   By: Robert S. Rau & Rob F. Rau II
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
#
#
# Things to think about
# 1) Should we set up an email account "PiFlyUser" to make it easier for users to share or report problems?
# 2) Should se set up a blog for sharing?
# 3) Should this script ask for a call sign during setup, install differently if none provided?
# 4) Should the shutdown button enable be delayed to the very end of the script?
# 5) Should the end of the script remind the user to set time zone, country, and so on?
#
#
#Time setup
# see http://raspberrypi.stackexchange.com/questions/47542/raspberry-pi-wont-update-time
#sudo date -s "$(wget -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d' ' -f5-8)Z"
#
logFilePath=/var/log/piflyinstalllog.txt
#
# 0) Check that we are running with root permissions
if [[ $EUID > 0 ]]; then
	echo "Please run using sudo"
	exit
fi
echo "" >> $logFilePath
echo "PiFly Setup Script" >> $logFilePath
echo "PiFly Setup:Start Run in sudo" >> $logFilePath
date >> $logFilePath
ping -c 1 8.8.8.8
if [[ $? > 0 ]]; then
    echo "No Network connection"
    echo "PiFly Setup:No network connection" >> $logFilePath
    exit
fi
echo "PiFly Setup:Have network connection" >> $logFilePath
uname -a >> $logFilePath
cat /proc/cpuinfo >> $logFilePath
echo "PiFly Setup:USB info" >> $logFilePath
lsusb -t  >> $logFilePath
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
# 1) Setup directory structure
echo "PiFly setup: Starting directory setup"
cd /home/pi
mkdir pifly
chown pi:pi pifly
echo "PiFly Setup:mkdir pifly:result" $? >> $logFilePath
# switch to install directory
cd /home/pi/pifly
#
#
#
sudo apt-get update
echo "PiFly Setup:mkdir pifly:sudo apt-get update" $? >> $logFilePath
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
# 2) Set up Raspberry Pi configuration
# see:https://www.raspberrypi.org/forums/viewtopic.php?f=44&t=130619
# for SPI see (see DMA note at bottom):https://www.raspberrypi.org/documentation/hardware/raspberrypi/spi/README.md
echo "PiFly setup: StartingRaspberry Pi configuration"
#
sudo apt-get install git
echo "PiFly Setup:apt-get install git" $? >> $logFilePath
#
# Make USB drive writeable
# https://www.raspberrypi.org/forums/viewtopic.php?f=91&t=65769
#echo "/dev/sda1       /meda/pi        vfat        auto,user,rw,uid=pi,gid=pi     0     0" >> /etc/fstab
echo "PiFly Setup:echo to /etc/fstab" $? >> $logFilePath
#
#
# Make TV output secondary to HDMI output (I have read this is the default, but not so in practice)
#I don't know how to do this. I have made one that ONLY uses TV output..useless!
#
#
# shutdown support
# http://www.recantha.co.uk/blog/?p=13999
#
cd /home/pi/pifly
git clone https://github.com/adafruit/Adafruit-GPIO-Halt
echo "PiFly Setup:git clone of Adafruit_GPIO_Halt" $? >> $logFilePath
cd Adafruit-GPIO-Halt
make
echo "PiFly Setup:make of Adafruit_GPIO_Halt" $? >> $logFilePath
sudo make install
echo "PiFly Setup:make install of Adafruit_GPIO_Halt" $? >> $logFilePath
sudo /usr/local/bin/gpio-halt 26 &
echo "PiFly Setup:gpio-halt 26 &" $? >> $logFilePath
cd /home/pi/pifly
chown -R pi:pi Adafruit-GPIO-Halt
#
#
# Enable SPI, I2c, I2S.
# see  http://raspberrypi.stackexchange.com/questions/14229/how-can-i-enable-the-camera-without-using-raspi-config
#
#
# Edit cmdline.txt st serial port is available for GPS
sudo sed -i.bak -e 's/console=ttyAMA0\,115200 //' -e 's/kgdboc=ttyAMA0,115200 //' -e 's/console=serial0,115200 //' /boot/cmdline.txt
echo "PiFly Setup:cmdline.txt update" $? >> $logFilePath
echo "PiFly Setup:cmdline.txt is now:" >> $logFilePath
cat /boot/cmdline.txt >> $logFilePath
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
#
# 3) install RF transmitters and modulators
#
#  nbfm - narrow band FM - 144MHz transmitter, uses GPIO4
cd /home/pi/pifly
wget https://raw.githubusercontent.com/fotografAle/NBFM/master/nbfm.c
echo "PiFly Setup:nbfm:wget" $? >> $logFilePath
chown pi:pi nbfm.c
echo "PiFly Setup:Starting gcc -o3 -lm -std=gnu99 -o nbfm nbfm.c &> $logFilePath" $? >> $logFilePath
gcc -o3 -lm -std=gnu99 -o nbfm nbfm.c &>> $logFilePath                 # changed from -std=c99 to -std=gnu99
echo "PiFly Setup:nbfm:gcc nbfm" $? >> $logFilePath
chown pi:pi nbfm
#
#
#  rpitx - able to TX on 440MHz band, uses GPIO18
echo "PiFly setup: Startingrpitx setup"
cd /home/pi/pifly
git clone https://github.com/F5OEO/rpitx
echo "PiFly Setup:git clone of rpitx result" $? >> $logFilePath
cd ./rpitx
sudo ./install.sh
echo "PiFly Setup:rpitx install result" $? >> $logFilePath
cd /home/pi/pifly
chown -R pi:pi rpitx
#
#
#  pifm - able to TX on 144MHz band, uses GPIO4
# It's all Pythony, I don't know how to do this
echo "PiFly setup: Starting pifm setup"
cd /home/pi/pifly
#wget https://raw.githubusercontent.com/rm-hull/pifm/master/pifm.c
wget www.icrobotics.co.uk/wiki/images/c/c3/Pifm.tar.gz
tar -xvf Pifm.tar.gz
echo "PiFly Setup:wget pifm" $? >> $logFilePath
chown pi:pi pifm.c
echo "PiFly Setup:Starting g++ -O3 -o pifm pifm.c &> $logFilePath" $? >> $logFilePath
g++ -O3 -o pifm pifm.c &>> $logFilePath
echo "PiFly Setup:pifm:g++ pifm" $? >> $logFilePath
chown pi:pi pifm
#
#
#  Packet radio modulator. Text to .WAV file
cd /home/pi/pifly
wget https://raw.githubusercontent.com/km4efp/pifox/master/pifox/pkt2wave
echo "PiFly Setup:wget pkt2wave result" $? >> $logFilePath
chmod +x pkt2wave
chown pi:pi pkt2wave
#
#
#
#  slow scan TV
# will add later
#https://www.element14.com/community/community/raspberry-pi/raspberrypi_projects/blog/2014/01/27/pi-noir-and-catch-santa-challenge--the-dutch-way
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
# 4) install audio support
#
# Text to speech    see:https://learn.adafruit.com/speech-synthesis-on-the-raspberry-pi/installing-the-festival-speech-package
echo "PiFly setup: Startingfestivalsetup"
sudo apt-get -y install festival
echo "PiFly Setup:apt-get festival result" $? >> $logFilePath
#
#
# set up audio output
#  https://learn.adafruit.com/adding-basic-audio-ouput-to-raspberry-pi-zero/pi-zero-pwm-audio
#
#
#
#
#
#
#
#
# 5) Video download link support
#
# Python matplotlib
sudo apt-get -y install python-matplotlib
#
echo "PiFly Setup:apt-getpython-matplotlibresult" $? >> $logFilePath
#
#
#
#
#
#
#
#
# 6) High current output support
#
# see  http://abyz.co.uk/rpi/pigpio/index.html
#
#
#
#
#
#
#
#
#
# 7) Developer tools
#
# Screen capture tool
sudo apt-get -y install scrot
echo "PiFly Setup:mkdir pifly:apt-getapt-get scrotresult" $? >> $logFilePath
#
#
echo ""
echo "Remember to set country and time zone"
# Should load some libpifly examples
