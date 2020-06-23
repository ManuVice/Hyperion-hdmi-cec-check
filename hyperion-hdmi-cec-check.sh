#!/bin/bash

# Script for hyperion which allows you to turn off your LEDs when your AVR is off and vice versa.
# Tested with Raspian on an RPi3
# 1 - Plug your RPi with an HDMI cable TV/AVR/...
# 2 - Copy the script on your RPi
# 3 - Run sudo chmod +x on the script
# 4 - To make it run at startup, add   @reboot /your/path/yourscriptname.sh    to crontab -e
# 5 - Enjoy

# created by RaPiiDe
# modified by ManuVice

remotePath="PathToYourHyperion-remote"
isOn=-1

while :
do
        # We get the CEC status
        status=$(echo pow 0 | timeout 5 cec-client -d 1 -s)
        # If it's off and it wasn't already, let's turn off the LEDS
        if [[ "$status" == *"power status: standby"* ]] && [[ "$isOn" != "0" ]]
        then
                eval "$remotePath --off"
                isOn=0
        # If it's on and it wasn't already, let's turn on the LEDS
        elif [[ "$status" == *"power status: on"* ]] && [[ "$isOn" != "1" ]]
        then
                eval "$remotePath --on"
                isOn=1
        fi
		
        sleep 10 
done
