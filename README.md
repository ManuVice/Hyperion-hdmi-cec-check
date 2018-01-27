# Hyperion-hdmi-cec-check 
Copyright 2016 by Spegeli from PowerPi.de Forum (http://powerpi.de/forum/viewtopic.php?p=11712#p11712)  
Modifed 2018 by ManuVice  
Tested with Hyperion.ng #e438bc6 (https://github.com/hyperion-project/hyperion.ng) and Raspbian Stretch  
Checks HDMI CEC signal to start/stop Hyperion service 

## Requirements:
- https://github.com/Pulse-Eight/libcec
- Hyperion
- Systemd
- Hyperion.service

## Install:

- You have to create or change a "hyperion.service" in /etc/systemd/system/  

  [Unit]
  Description=Hyperion ambient light systemd service  

  [Service]  
  ExecStart=PATHTOhyperiond  
  WorkingDirectory=PATHTO/bin  

  [Install]  
  WantedBy=multi-user.target
  
- Register it:  
    sudo systemctl enable hyperion.service  
    
## Optional:

- start this script on boot  
- create hyperion-hdmi-cec-check.service in /etc/systemd/system/  

  [Unit]
  Description=HDMI CEC Check  
  After=network.target

  [Service]  
  ExecStart=PATHTOYOURSCRIPT  
  TimeoutStopSec=5  
  KillMode=mixed  
  Restart=always  
  RestartSec=2  
  
  [Install]  
  WantedBy=multi-user.target
  
- register it:  
  sudo systemctl enable hyperion-hdmi-cec-check.service
