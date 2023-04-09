#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Preparing to set up Akamai Redirect Checker (Archer)"

echo "Updating repositories..."
UPD=$(apt-get update -y)

echo "Installing Python dependencies..."
DEP=$(apt-get install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev -y)

echo "Installing Python3 & PIP3..."
PY=$(apt-get install python3 python3-pip -y)

echo "Installing script dependencies..."
SC=$(pip3 install -r requirements.txt)

echo -n "Would you like to create the 'archer' command? (y/n): "
read makecommand
if [ "$makecommand" == "y" ]
	then echo "Make script executable..."
	EX=$(chmod +x archer.py)
	echo "Copy script to /usr/bin ..."
	MV=$(cp archer.py /usr/bin/archer)
fi
