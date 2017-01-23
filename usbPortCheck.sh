#!/bin/bash

BUS=6
PORT1=1
PORT2=2
ttyUSB1_BUS=`find /sys/bus/usb/devices/usb*/ -name dev | grep ttyUSB0 | awk -F "/" '{print $8}' | awk -F ":" '{print $1}' | awk -F "-" '{print $1}'`
echo $ttyUSB1_BUS

ttyUSB1_PORT=`find /sys/bus/usb/devices/usb*/ -name dev | grep ttyUSB0 | awk -F "/" '{print $8}' | awk -F ":" '{print $1}' | awk -F "-" '{print $2}'`
echo $ttyUSB1_PORT

if (($ttyUSB1_BUS == 6));
then 
	if (($ttyUSB1_PORT == 1));
		then
		echo "ttyUSB0 is connected to PORT1"
        elif (($ttyUSB1_PORT == 2));
		then
		echo "ttyUSB0 is connected to PORT2"
        fi
fi

