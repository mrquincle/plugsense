#!/bin/bash

# We will use bash functionality here in the form of an associative array
# we require here version > 4

sensor=$1

if [[ ! $sensor ]]; then
	echo "No sensor as argument"
	exit
fi

source plugwise_db

mac_address=${plugwise_db[$sensor]}

if [[ ! $mac_address ]]; then
	echo "Unknown sensor"
	exit
fi

#echo "Check power for sensor with MAC $mac_address"

power=$(plugwise_util -d /dev/ttyUSB0 -m $mac_address -p 2>/dev/null )

echo $power | cut -d':' -f2 | sed 's| ||g' | sed 's|W||g'

