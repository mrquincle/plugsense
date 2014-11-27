#!/bin/bash

sleeptimestep=20

source plugwise_db

source config.txt

for sensor in "${!plugwise_db[@]}" ; do
	echo " ./sync.sh $sensor &"
	./sync.sh $sensor &
	sleep $sleeptimestep
done

