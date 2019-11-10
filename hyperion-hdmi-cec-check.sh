#!/bin/sh

# Copyright 2016 by Spegeli from PowerPi.de Forum (http://powerpi.de/forum/viewtopic.php?p=11712#p11712)
# Modifed 2018 by ManuVice
# Tested with Hyperion.ng #e438bc6 (https://github.com/hyperion-project/hyperion.ng) and Raspbian Stretch

# Please enter time in seconds
CheckTime=30 #How often should it check if TV and/or Hyperion is running? Standard 15 (Personally I've set it to 60)

#Do not change!
path=$@ #Get the Path of the Config File

while :; do
    echo "ask CEC status"
    command="echo pow 0 | cec-client -s -d 1 | grep 'power status'"
    status=$(eval $command)
    echo $status

    if [ "$status" = "power status: standby" ] || [ "$status" = "power status: unknown" ]; then
      echo "TV is off at the moment!"
      #Ask Hyperion if it's already running
          if $(systemctl -q is-active hyperion.service)
      then
         echo "Hyperion is running - stop it!"
         sleep 15 #give Hyperion some time to disable lights
         eval sudo systemctl stop hyperion.service
         sleep 1
         killall hyperiond
         sleep $CheckTime
      else
         echo "Hyperion isn't running!"
      fi
    elif [ "$status" = "power status: on" ] || [ "$status" = "power status: in transition from standby to on" ]; then
      echo "TV is on at the moment!"
      #Ask Hyperion if it's already running
          if $(systemctl -q is-active hyperion.service)
      then
         echo "Hyperion is running!"
      else
         echo "Hyperion isn't running - start it!"
         killall hyperiond
         sleep 5 #wait some time get an image. <-- You can change or comment this out if you dont want it!!!
         eval sudo systemctl start hyperion.service
         sleep 1
      fi
    fi

    echo "Wait $CheckTime sec before next check"
    sleep $CheckTime

echo $status

done
exit 0
