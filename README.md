# piflySetupScript
Bash script for Raspberry Pi Zero HAT-ish board **PiFly**. Loads relevant software, sets permissions, and configures Linux startup.


All trademarks are copyright of their respective owners. 
Overview
The PiFly board is designed for drones, high power rocketry, and RC airplanes. The board will also suit many other applications. Primarily designed for the Raspberry Pi Zero, it will work on any Raspberry Pi with a 40 pin connector or compatible. The physical form factor doesn’t conform to the Raspberry Pi HAT size, hence the HAT-ish reference.



**Usage**

```
cd ~
git clone https://github.com/robertrau/piflySetupScript
cd piflysetupscript
sudo ./piflysetup.sh
```
This install will use about 1GB and take over 45 minutes with a Raspberry Pi Zero.


**To check install log file**

```
cat /var/log/piflyinstalllog.txt
```

**Installed Software**

    Inserted USB FLASH Drives are now writable
    Pushbutton Shutdown on GPIO26 (pin 37) for push button SW1 on the PiFly board
    Release of serial ports for SSH and Bluetooth, high speed serial needed for 50Hz update GPS
    gpsbabel
    nbfm - Narrow Band FM Transmitter, doesn't work on NOOBS 1.92 and later
    rpitx - Multimode FM Transmitter
    Demo144-39MHz.sh - 144.39MHz transmit demo for rpitx
    pifm - FM Transmitter, doesn't work on NOOBS 1.92 and later
    pkt2wave - Converts text packet radio messages to .WAV files
    Sets up audio output on GPIO13 (pin 33)
    i2ctools
    Screen
    cmake
    RTIMULib with Qt tools
    scrot
    setserial
    festival - text to speech package
    SoX - Audio Resample
    Installed Python libraries: matplotlib, python-smbus, python3-smbus, build-essential, python-dev, python3-dev, adafruit-pca9685, and RTIMULib2
    man page for wiringPi gpio command
      
**File Description**

    piflysetup.sh				The bash setup script
    Demo144-39MHz.sh			This script takes a text message and converts it to a RF .ft speech file, turns on the RF amplifier and transmits the speech file, then turns off the RF amplifier.
    TachTestAll.sh				Test the ADT7470 tachometer.
    txoff.sh				Turns off the RF amplifier.
    tx18.sh					Selects GPIO18 as the RF carrier and turns on the RF amplifier.
    tx4.sh					Selects GPIO4 as the RF carrier and turns on the RF amplifier.
    HighCurrentTest.sh			Turns on each high current output.
    SPItest.sh				Reads A/D channels 6 (temperature), 7 (keypad), and 15 (high current output voltage).
    ServoTest				Exercises the 8 servo outputs.
    11-media-by-label-auto-mount.rules	Rules for USB FLASH drive to be writable.
    
**Installed Demos & Software to demonstrate hardware functionallity**

    screen /dev/ttyAMA0 9600		View GPS output.
    RTIMULibDemoGL				Graphic Accelerometer/Gyro demo.
    /home/pi/pifly/rpitx/Demo144-39MHz.sh	Edit CALL SIGN text first. Sends text to speech message on 144.390MHz
    TachTestAll.sh				Tests the four tachometer inputs.
    SPItest.sh				Reads A/D channels 6 (temperature), 7 (keypad), and 15 (high current output voltage).
    HighCurrentTest.sh			Turns on each or the four high current output.
    ServoTest				Exercises the 8 servo outputs.

    
    



## Acknowledgments
The PiFly hardware and software would not have been possible without the kind efforts of the following.

    • My family for putting up with me spending a pile of money on the PiFly hardware and tons of time over the last 16 months making it real.
    • My oldest son, without his efforts and patients I would still be writing the worst code ever and for his work on the PiFly library.
    • The Raspberry Pi organization for taking on a huge effort and providing the world with a succesful learning vehicle.
    • Imperial College Robotics Society for their vision to turn a digital computer into an analog RF modulator.
    • fotografAle for converting pifm into a modulator sutable for amateur radio use.
    • Lady Ada, Phil Burgess, and the Adafruit team for the software to do pushbutton shutdown and the Audio PWM tutorial.
    • www.axllent.org for showing me how to make any USB FLASH drive auto mount writable.
    • KM4EFP for pkt2wave to support packet radio
    • Brian Ho for gpio_alt
    • The University of Edinburgh, Centre for Speech Technology Research, for festival speech software
    • The gpsbabel team
    • The SoX team
    • The matplotlib team
    • The scrot team
    • The i2c-tools team
    • The whole open source hardware and software community.
God bless them all.



## PiFly Hardware Features
**• Power:** Designed to run on 3.2 to 12 volts, it is intended to run on one to three LiPo cells, but any power supply will do. A single power supply powers the Raspberry Pi, the HAT board, and its USB device from a 5 volt 2 amp buck-boost switching power supply. (The four high current outputs require at least 4.5 volts; i.e. two or three LiPo cells)

**• Raspberry Pi compatible:** The PiFly is intended to connect to the Raspberry Pi Zero so that components of each board face away from the middle. A 40 pin socket could be soldered to the top of the board for use on the Raspberry Pi 3, or any 40 pin Raspberry Pi.

**• RF Transmitter Amplifier and Filter:** The board has a dual RF filter and 200mW amplifier. It supports an RF carrier from either GPIO14 or GPIO18. One filter is for the 144MHz HAM band and the other filter is for the 440MHz HAM band. 144MHz transmission can be supported by pifm, nbfm, and rpitx. 440MHz transmission is supported by rpitx.

**• Servos:** Can control up to eight servos. (Standard 6 volt servos will require 2 LiPo cells, higher voltage tolerant servos can use 2 or 3 LiPo cells)

**• High Current Outputs:** Intended for Rocket upper stage igniters and parachutes, these high current, high side drivers have borh voltage and current diagnostics. There is a redundant enable system to prevent false assertions. Connections use press-to-release terminal blocks so there is no possibility of forgetting to tighten a screw terminal.

**• Support for headless operation:**  There is a shutdown button and a shutdown acknowledgment LED for safe headless shutdown. There is also a low battery comparator that can assert the shutdown request.

**• Small size:** The PiFly has the same width as Raspberry Pi Zero, but it is longer. Dimensions: 29.25mm by 150mm. It is intended to fit a high power rocket 38mm tube coupler, strap on the belly of a quad-copter, or in an RC airplane. Also small enough to be a smart handi-talkie with the addition of a USB software defined receiver.

**• USB redirected:** Cannot use the USB port in the 32mm width. The USB test points on a Raspberry Pi Zero can be soldered to test points on the HAT board for the USB type A connector and still fit in a 38mm tube coupler.

**• GPS:** The board uses the Skytrac Venus838 module. In binary mode this device can make 50 location updates per second. It has an SMA connector for an external antenna. This is required for the use of a helical, omni directional antenna. GPS data can be backed up with a super capacitor that has a connector for an external rechargeable coin cell. There is existing support for ASCII NMEA-0183 compatible output at 10 location updates per second. The libpifly library has support for binary mode at 50 locations per second. There is also a four pin connector for an external GPS if the PiFly board is built without the onboard GPS.

**• I/Os:** Most have ESD protection.

**• A/D support:** Supports either 8, 10, or 12 bit A/D converters. The default build uses the 10 bit TI ADS7957SDBTR A/D converter with 16 channels; some for internal measurement and diagnostics and some external channels. The external A/D connector is a 0.050” pitch connector. Two external channels can be set up for thermistors. Uses SPI interface.

**• Keypad support:** A connector for either a standard six-key keypad or a standard 12-key keypad connected through a resistor array to a A/D input. With an external resistor array 26 keys are possible. See http://rau-deaver.org/1-wire_keyboard.html

**• High G linear accelerometer:** Uses NXP (Qualcom) MMA6555KW as on Altus Metrum’s TeleMega. Uses SPI interface.

**• Barometric pressure sensor:** Uses a Measurement Specialties (TE Connectivity) MS560702BA03-00 as on Altus Metrum’s TeleMega. Uses SPI interface.

**• 9 axis inertial and magnetic platform:** Uses an Invensense (TDK) MPS-9250 for 3-axis acceleration, 3-axis gyro, and 3-axis magnetometer. Mounted on board centerline. Uses I2C bus.

**• Humidity sensor:** Uses ST’s HTS221TR sensor. Uses I2C bus.

**• Differential Pressure sensor:** Can be used for drone/aircraft Pitot tube for airspeed. Measurement Specialties (TE Connectivity) 4525DO-DS5AI030DP on I2C bus.

**• Audio Output:** GPIO13 has PWM audio filter, amplifier, and connector.

**• Microphone:** Knowles SPH0645LM4H-B on the I2S bus left channel (word select=0).

**• Time of Day Clock:** Maxim DS3231S using the GPS Super Cap/Battery Backup.

**• Maxim 1-Wire bus controller.** Full support for 5 volt higher current devices.

**• Quad tachometer Input:** compatible with Spektrum SPM1452 sensors. Uses an Analog Devices ADT7470.



#### Power
The PiFly board runs from a 4.5 volt to 12.0 volt maximum input on connector P1. The breakdown voltage of the input protection TVS is 12.2 volts and this voltage should never be exceeded. The input is protected from ESD to 15kV. If the high side drivers on J6 are not used, the input voltage can go as low as 3.2 volts. The power input connector is a Deans Ultra Plug; a small, lightweight, high current connector that is widely available. There is no battery charger on the PiFly.

The input power is converted to 5.1 volts through a buck-boost DC-DC converter. It is then further regulated to 3.3 volts with a linear regulator. The 5.1 volts powers the A/D converter analog portion, the Raspberry Pi, and optionally 5 volt I2C devices. The 3.3 volt powers most of the sensors.

The high side drivers on J6 are powered directly from the power input on P1. This is required since the high side driver can source as much as 42 amps. Care must be taken for high current applications if you use a LiPo battery. LiPo batteries have a built-in over-current protection. If your application exceeds this value, your battery will automatically disconnect and the PiFly and Raspberry Pi computer will lose power.

The servos that can connect to P2 and P3 can run directly off the power input or can run two diode drops below the power input. This is selected by W4. For all but the smallest servos, it is recommended that W4 be a soldered wire short, not a removable jumper due to current requirements. LiPo battery voltages and servo voltage options are listed below:

    LiPo cell count		W4 position		Servo voltage
    1 (3.0V - 3.7V)		1-2			1.8V – 2.7V
    1 (3.0V - 3.7V)		2-3			3.0V - 3.7V
    2 (6.0V – 7.4V)		1-2			4.8V – 6.4V
    2 (6.0V – 7.4V)		2-3			6.0V – 7.4V
    3 (9.0V – 11.1V)	1-2			7.8V – 10.1V
    3 (9.0V – 11.1V)	2-3			9.0V – 11.1V

Servos could be powered independently by wiring an external power source to pin 2 on W4.


#### Compatibility
The PiFly is designed to be mated to a Raspberry Pi Zero, but is compatible with many Raspberry Pi 40-pin compatible computers. The intended connection to a Raspberry Pi Zero is soldering a dual row 40 pin header from the bottom side of the Raspberry Pi Zero to the ‘solder’ side of the PiFly at J1. This allows the boards to be 1.6mm apart for the tightest form factor. The I2C_0 bus has an EEPROM for storing a device tree, but there currently isn’t a device tree definition for the EEPROM. Below is a list of compatible boards.

	https://www.raspberrypi.org/products/pi-zero/
	https://www.raspberrypi.org/products/raspberry-pi-3-model-b/
	https://www.pine64.org/?product=pine-a64-board-2gb
	http://www.orangepi.org/orangepiplus2e/
	http://www.opossom.com/english/products-development_boards-opos6ul_dev.html
	https://shop.technexion.com/pico-pi-imx7.html

All the connections to the host computer through the 40 pin connector have a small capacitor to prevent any RF ingress to the Host since the PiFly has a RF transmitter.

J8 is a reset pin that lines up with the reset pin on a Raspberry Pi Zero. This allows the reset to be kept low until adequate power is available to run. This can be useful for solar applications. This is not directly compatible with other boards but may be connected with hookup wire.





#### RF Transmitter Amplifier & Filter
The PiFly board has two RF outputs. Each one has its own filter for a specific RF band. The default build is for the 144MHz HAM band and the 434MHz HAM band. 144MHz transmission can be supported by pifm, nbfm, and rpitx. 440MHz transmission may someday be supported by rpitx on the Raspberry Pi Zero, but currently does not work. Rpitx works well on the Raspberry Pi 3. There has been no testing on other ‘compatible’ computers. Supports RF carrier from either GPIO4 or GPIO18 (also the I2S clock) selected with GPIO27. The on-board microphone can not be used with GPIO18 selected as the RF output. Below is a table for the multiplexor and the band.

		GPIO27			Selected Timer Output		Supporting Software
		Low			GPIO18 (shared with I2S)	rpitx
		High			GPIO4				pifm, nbfm, rpitx


		Band			TX Output Connector		Supporting Software
		144			J3				pifm, nbfm
		433			J2				rpitx






#### Servo Outputs
The PiFly has eight servo outputs on P2 and P3. Please read the above Power section to properly match your board power to your servo voltage requirements. The servo PWM pulses are generated by a Qualcomm (NXP) PCA9685PW. Only eight of the sixteen outputs are used, and the outputs are not in order with respect to the data sheet ordering. It is intended that a software driver should handle the assignments. There is no software overhead to keep a servo in a given position, as the PCA9685PW will continue generating the same pulse width until commanded to a new pulse width. If U11 is installed, the pulse width can be clocked with an external 12.000MHz oscillator for consistent, temperature stable operation. This also allows for consistant behavior with different boards. It is recommended that the programmed ON time of each PWM is distributed evenly across the 4096 clock period to reduce large current spikes. Below is the setup requirements and servo PWM performance information.

	Prescaler=49
		Update rate= 12000000/4096/49=59.79Hz
		Minimum adjustment=1/(12000000/49)=4.0833µs
		Full servo throw=1ms (+/- 0.5ms)
	% adjustment=4.08333µs/1ms=0.4083%

	Pulse width	Off time – On time
	0.4ms		98
	0.5ms		122
	1.0ms		245
	1.5ms		367
	1.6ms		392

The servo PWM pins have ESD protection.




#### High Current Outputs
The PiFly board has four 42 amp outputs. It is important to understand that these are not continuous 42 amp drivers. Any load over five amps must be momentary as there is not enough heat sinking on the high side driver. The load current of each output is monitored by the A/D converter allowing the software to protect against overloads. Each output is designed to drive a high current igniter like what is used for igniting an upper stage rocket motor or deploying a parachute. The output are also suitable for running a DC fan, lights, or any DC load that won’t over heat or exceed the inductive kick back capability of the VNQ5027AKTR-E.

At power up the high current outputs are not enabled. There is a flip-flop that is set to disable the outputs at power up. The only way to enable the outputs is to set all four of the Fire outputs to zero (inactive) and then make a low to high transition on the FireEnableEdge (GPIO25) output. This circuit prevents any single random write to the fire control lines from turning on an output. This protection circuit is designed for applications where only one set of outputs are active at a time, and then turned off, like rocket igniter applications. To keep this protection active between ignition events the turn-on, turn-off sequence must be:

		Turn on:		1) All Fire outputs (Fire A to Fire D) must be low
					2) Make a low to high transition on FireEnableEdge
					3) Set required Fire output high to provide output power to required outputs

		Turn off:		1) Set the FireEnableEdge low
					2) Make a low to high transition on FireEnableEdge, this will shut off the driver
					3) Set all Fire A to Fire D outputs low.
					4) This leaves the fire control immune to any single errant write of the GPIOs.

If protection is not required for your application, after enabling with FireEnableEdge, the individual Fire outputs may be activated or negated at will.

For A/D measurements of output current or voltage, see the A/D section.





#### Headless Operation
The PiFly board has support for headless operation.  There is a momentary push button on GPIO26 to request an orderly shutdown of the Raspberry Pi. There is also a LED that can be used to indicate that the software has received the request and is working on the shutdown. Here is a link to a tutorial on the Adafruit software for an external shutdown request. The software needs to be altered for using GPIO26 for the request and GPIO16 for the LED. In addition to the push button requesting a shutdown, there is a battery voltage comparator that can also request a shutdown if the input voltage gets too low. This is useful for remote applications such as solar powered installations or solar power recharged battery applications. If W5 is shorted, the comparator can request a shutdown when the input voltage falls below 3 volts.

#### USB Connector
The PiFly board doesn’t have any USB electronics but it does allow the Raspberry Pi Zero’s USB port to be ‘re-directed’ to a type A connector that is mounted at the end of the PiFly board. This allows using a USB device in a narrow tube like a rocket body tube. Using this connector requires soldering three small wires from three test points on the Raspberry Pi Zero to three pads on the PiFly. This connection is not compatible with any other computer than the Raspberry Pi Zero.
The USB connector has ESD protection.

 
#### GPS
The PiFly board has a GPS receiver and SMA connector for an external antenna. Antenna preamp power is provided (3.3V) so either an active or passive antenna may be used. The RF input has a bandpass filter to prevent de-sense to the RF front end from the local transmitter. Below is a list of omnidirectional helical antennas, The Richardson RF antenna was used for design.

##### Active:
	http://www.stepglobal.com/maxtena-m1227hct-a-l1-l2-gps-glonass-compact-active-helix-antenna
	https://www.radiall.com/antennas/standard-short-gps-l-1-active-25db.html

##### Passive:
	http://www.richardsonrfpd.com/Pages/Product-Details.aspx?productId=1142163
	http://www.stepglobal.com/maxtena-m1516hct-p-sma-l1-gps-glonass-compact-passive-helical-antenna

The GPS receiver powers up in standard NMEA-0183 format supporting GGA, GLL, GSA, GSV, RMC, VTG, ZDA sentences. The baud rate may be increased to 115200 and the protocol changed to SkyTraq Binary, and the update rate may be set as high as 50 locations per second.

There are three options for back-up power for the almanac and ephemeris, a small SMT super capacitor (C2), a larger through-hole super capacitor (C58), or a external connection for a battery (P7). The Skytraq Venus638 may also used in this footprint by changing R74 & R108.

The board may be assembled without the SkyTraq GPS and have the serial port available for another purpose, or an external GPS by using connector P6.




#### Analog to Digital Converter
The PiFly has a 16 channel A/D converter. The design is compatible with 8, 10, and 12 bit versions of the A/D converter. The default build is with the 10 bit version. In the table below, \<A/D> is always this fraction from 0.0000 to 1.0000.

	Channel		Measurement			Conversion to Engineering Units
	0		AnalogCH1, J7 pin 3		Application dependent
	1		AnalogCH2, J7 pin 3		Application dependent
	2		AnalogCH3, J7 pin 3		Application dependent
	3		AnalogCH4, J7 pin 3		Application dependent
	4		AnalogCH5, J7 pin 3		Application dependent
	5		AnalogCH6, J7 pin 3		Application dependent
	6		PiFly temperature
	7		Keypad				See Keypad section below
	8		Fire A current			<A/D> * 54.217 amps  (using 5V reference)
	9		Fire B current			<A/D> * 54.217 amps  (using 5V reference)
	10		Fire C current			<A/D> * 54.217 amps  (using 5V reference)
	11		Fire D current			<A/D> * 54.217 amps  (using 5V reference)
	12		Fire D output voltage		<A/D> * 30 volts (using 2.5 volt reference)
	13		Fire C output voltage		<A/D> * 30 volts (using 2.5 volt reference)
	14		Fire B output voltage		<A/D> * 30 volts (using 2.5 volt reference)
	15		Fire A output voltage		<A/D> * 30 volts (using 2.5 volt reference)

This device is on the higher speed SPI bus so rapidly changing data can be captured accurately. The SPI address is SPI_ADDR1..0=0x2.



#### Keypad Support
The PiFly board has a dedicated keypad connector. This connector supports a analog 1-wire keypad. There is a 7-resistor voltage divider that different keys short different combinations of resistors, to provide a unique voltage for each key. This connector has a resistor array that can be built two ways, first for a 6 key keypad with a single common, and second for a 3 x 4 matrix. For larger keypad requirements you will need to use an external resistor divider. Using 1% resistors keypads as large as 26 keys can be realized. Software to generate the keypad decode software can be found at:

		http://rau-deaver.org/1-wire_keyboard.html 



#### High G linear accelerometer
The PiFly board has an accelerometer for high acceleration application like rocketry. This is the same sensor used by Altus Metrum in their TeleMega board, the MMA6555. See:
http://altusmetrum.org/TeleMega/
The device is mounted so –X acceleration is in the direction of the USB connector end of the board. This device is on the higher speed SPI bus so rapidly changing data can be captured accurately. The SPI address is SPI_ADDR1..0=0x1. Version two of this board will use a ST H3LIS331DLTR because the NXP part is going end of life.



#### Barometric Pressure Sensor
The PiFly board has a pressure sensor for the measurement of atmospheric pressure.  This is the same sensor used by Altus Metrum in their TeleMega board, the MS560702BA03-00. See:
http://altusmetrum.org/TeleMega/
This device is on the higher speed SPI bus so rapidly changing data can be captured accurately. The SPI address is SPI_ADDR1..0=0x0.


#### 9 Axis Inertial and Magnetic Platform
The PiFly board uses an Invensense (TDK) MPS-9250 for 3-axis acceleration, 3-axis gyro, and 3-axis magnetometer. Mounted on board centerline making it easier for the sensor to be on the centerline or your center of mass of your rocket/drone so you don’t have to mathematically back out roll accelerations. Mounted on board so +X acceleration is towards the GPS Antenna end of the board and +Y is towards the 40 pin Raspberry Pi connector. The magnetic coordinates are different from the acceleration reference frame. Uses I2C bus at address 0b1101001.




#### Humidity sensor 
Uses ST’s HTS221TR sensor as on Raspberry Pi’s Sensor HAT board. Uses I2C bus at address 0b1011111.

#### Differential Pressure Sensor
For use with drone/aircraft Pitot tubes for airspeed. Measurement Specialties (TE Connectivity) 4525DO-DS5AI030DP. This is a through hole device that mounts over some SMT components. Uses I2C bus at address 0b0101000.


#### Audio Output
There is a two-pin connector for headphone level audio output.

#### Microphone
Knowles SPH0645LM4H-B on the I2S bus. The select pin is grounded so the microphone shows up on the Left channel.

#### Time of Day Clock
To provide time for PiFlys built without a GPS, the Maxim DS3231S is an optional device. Battery Backup is provided by the same source as the GPS battery backup. Uses I2C bus at address 0b0101000. 


#### Quad tachometer input
Four channel tachometer input compatible with Spektrum SPM1452 sensors. Uses an Analog Devices ADT7470. With resistor changes the ADT7470 also supports GPIOs and a digital temperature sensor bus that can optionally be enabled at the expense of tachometer channels. This footprint is also compatible with the ON Semiconductor ADT7460 that supports low voltage level tachometer inputs. Uses I2C bus at address 0b0101110. 
