#!/bin/bash

sensor=$1
sleep_time=10

source config.txt

if [[ ! $sensor ]]; then
	echo "No sensor as argument"
	exit
fi

while true; do

	value=$(./get_plug.sh $sensor)
	if [[ $value ]]; then
		error0=$(echo $value | grep -i "failed")
		error1=$(echo $value | grep -i "dev")
		if [[ ! ( $error0 || $error1 ) ]]; then
			echo "[*] Send sensor $sensor: value $value"
			./post.sh $sensor $value
		else
			echo "Error message: $value"
		fi
	fi

	sleep $sleep_time
done
