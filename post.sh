#!/bin/bash

cred_file=credentials.txt

# file should have as contents
# username = common-sense user name
# password = md5 hashed password for common-sense
if [ -e "$cred_file" ]; then
	#echo "Source file $cred_file"
	source "./$cred_file"
fi

sensor=$1
value=$2

if [[ "$sensor" == "" ]]; then
	echo "There is no sensor id defined as argument"
fi

if [[ "$value" == "Unknown" ]]; then
	echo "Value is unknown, let us not post it"
	exit
fi

if [[ "$value" == "" ]]; then
	echo "There is no value defined as argument"
fi

if [[ "$username" == "" ]]; then
	read -p "Fill in your username of your common-sense account: " u
	username="$u"
fi

if [[ "$password" == "" ]]; then
	read -p "Fill in your password of your common-sense account: " p
	password=$(echo -n "$p" | md5sum | awk '{print $1}')
fi

#echo "Send value $value to sensor $sensor in account $username"
#echo " # note 1: you can use $cred_file to store username and md5 hash of your password)"
#echo " # note 2: you can expect nothing back from sense to indicate success, navigate to their online database instead"
#echo "Result: "
curl -s -H "Content-Type: application/json" -d "{\"data\": { \"value\": \"$value\"}}" https://api.sense-os.nl/sensors/$sensor/data?username\=$username\&password\=$password
#echo
#echo "Done"
