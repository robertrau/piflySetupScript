#!/bin/bash
#
#
# Written: 7/18/2017
#    Rev.: 1.00
#      By: Robert S. Rau
#
# see http://www.rau-deaver.org/Project_PiFly.html
# see https://github.com/robertrau/piflySetupScript
#
echo "PiFly Tachometer test"
echo ""
#
# set to 250ms update rate, low frequency PWM
i2cset -y 1 0x2e 0x40 0x61
#
# set to four pulses being counted as one period (for high speed motors)
i2cset -y 1 0x2e 0x43 0xff
#
ADToscMinD4=1350000
#
#
#
#
# First, throw away first reading, it is sometimes goofy
i2cget -y 1 0x2e 0x2a
i2cget -y 1 0x2e 0x2b
i2cget -y 1 0x2e 0x2c
i2cget -y 1 0x2e 0x2d
i2cget -y 1 0x2e 0x2e
i2cget -y 1 0x2e 0x2f
i2cget -y 1 0x2e 0x30
i2cget -y 1 0x2e 0x31
#
#
echo "Tach1   Tach2   Tach3   Tach4"
echo " RPM     RPM     RPM     RPM"
#
for i in {1..25}
do
Tach1lowByte=`i2cget -y 1 0x2e 0x2a | sed "s/0x//"`
Tach1highByte=`i2cget -y 1 0x2e 0x2b | sed "s/0x//"`
if [ $Tach1highByte$Tach1lowByte = "ffff" ]; then
  echo -n "     0"
else
  TachPeriod1=`echo $Tach1highByte$Tach1lowByte | sed 's,\(..\)\(..\)\(..\)\(..\),\4\3\2\1,g' | (read hex; echo $(( 0x${hex} )))`
  echo -n $ADToscMinD4 $TachPeriod1 | awk '{ printf "%6.1f", $1/$2 }'
fi
#echo -n 1=$TachPeriod1
Tach2lowByte=`i2cget -y 1 0x2e 0x2c | sed "s/0x//"`
Tach2highByte=`i2cget -y 1 0x2e 0x2d | sed "s/0x//"`
if [ $Tach2highByte$Tach2lowByte = "ffff" ]; then
  echo -n "       0"
else
  TachPeriod2=`echo $Tach2highByte$Tach2lowByte | sed 's,\(..\)\(..\)\(..\)\(..\),\4\3\2\1,g' | (read hex; echo $(( 0x${hex} )))`
  echo -n "      "
  echo -n $ADToscMinD4 $TachPeriod2 | awk '{ printf "%6.1f", $1/$2 }'
fi
Tach3lowByte=`i2cget -y 1 0x2e 0x2e | sed "s/0x//"`
Tach3highByte=`i2cget -y 1 0x2e 0x2f | sed "s/0x//"`
if [ $Tach3highByte$Tach3lowByte = "ffff" ]; then
  echo -n "       0"
else
  TachPeriod3=`echo $Tach3highByte$Tach3lowByte | sed 's,\(..\)\(..\)\(..\)\(..\),\4\3\2\1,g' | (read hex; echo $(( 0x${hex} )))`
  echo -n "      "
  echo -n $ADToscMinD4 $TachPeriod3 | awk '{ printf "%6.1f", $1/$2 }'
fi
#
Tach4lowByte=`i2cget -y 1 0x2e 0x30 | sed "s/0x//"`
Tach4highByte=`i2cget -y 1 0x2e 0x31 | sed "s/0x//"`
if [ $Tach4highByte$Tach4lowByte = "ffff" ]; then
  echo "       0"
else
  TachPeriod4=`echo $Tach4highByte$Tach4lowByte | sed 's,\(..\)\(..\)\(..\)\(..\),\4\3\2\1,g' | (read hex; echo $(( 0x${hex} )))`
  echo -n "      "
  echo  $ADToscMinD4 $TachPeriod4 | awk '{ print "%6.1f", $1/$2 }'
fi
done
