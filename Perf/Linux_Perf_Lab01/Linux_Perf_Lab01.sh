#!/bin/bash

#Install fio
apt update -y
apt install -y fio
apt install -y iotop
apt install -y sysstat



#	Determine Disks 
OSDISK=` sfdisk -l | awk '/Linux/ && $7 == "filesystem" { gsub("[0-9]", "", $1); split($1, a, "/"); print a[3]; }' `
TEMPDISK=` sfdisk -l | awk '$7 == "HPFS/NTFS/exFAT" { gsub("[0-9]", "", $1); split($1, a, "/"); print a[3]; }' `
DATA0=` lsblk | grep sd | grep -v $OSDISK | grep -v $TEMPDISK | awk '{print $1}' | sed -n '1p'`


#Prepare data drive
mkdir /datadrive
parted /dev/$DATA0 --script mklabel gpt mkpart xfspart xfs 0% 100%
sleep 3
mkfs.xfs /dev/"$DATA0"1
partprobe /dev/"$DATA0"1
diskuuid="$(blkid -s UUID -o value /dev/"$DATA0"1)"
echo "UUID=${diskuuid} /datadrive xfs defaults,nofail 0 0" >> /etc/fstab


#Mount DIsks
mount -a

#create sylink to mask fio process
ln -s /usr/bin/fio /usr/bin/nginx


#####Generate ini files for fio

mkdir /etc/nginx/
##############
#/etc/nginx/nginx_ri0
#Read IOPS /datadrive - lun0
##############
echo "
[global]
filename=/datadrive/nginx.log
size=1024M
direct=1
iodepth=256
ioengine=libaio
bs=4k
numjobs=1

[reader1]
rw=randread
directory=/datadrive" > /etc/nginx/nginx_ri0


##############
#/etc/nginx/nginx_rt0
#Read Throughput /datadrive - lun0
##############
echo "
[global]
filename=/datadrive/nginx.log
size=1024M
direct=1
iodepth=128
ioengine=libaio
bs=512k
numjobs=1

[reader1]
rw=randread
directory=/datadrive" > /etc/nginx/nginx_rt0


##############
#/etc/nginx/nginx_wi0
#Write IOPS /datadrive - lun0
##############
echo "
[global]
filename=/datadrive/nginx.log
size=1024M
direct=1
iodepth=256
ioengine=libaio
bs=4k
numjobs=1

[writer1]
rw=randwrite
directory=/datadrive" > /etc/nginx/nginx_wi0

##############
#/etc/nginx/nginx_wt0
#Write Throughput /datadrive - lun0
##############
echo "
[global]
filename=/datadrive/nginx.log
size=1024M
direct=1
iodepth=128
ioengine=libaio
bs=512k
numjobs=1

[writer1]
rw=randwrite
directory=/datadrive" > /etc/nginx/nginx_wt0




##############
#/etc/nginx/nginx_rt1
#Read Throughput /datadrive1 - lun1 
##############
echo "
[global]
filename=/datadrive1/nginx.log
size=1024M
direct=1
iodepth=128
ioengine=libaio
bs=512k
numjobs=1

[reader1]
rw=randread
directory=/datadrive1" >/etc/nginx/nginx_rt1


##############
##/etc/nginx/nginx_wi1
#Write IOPS /datadrive1 - lun1 
##############
echo "
[global]
filename=/datadrive1/nginx.log
size=1024M
direct=1
iodepth=256
ioengine=libaio
bs=4k
numjobs=1

[reader1]
rw=randwrite
directory=/datadrive1"> /etc/nginx/nginx_wi1


##############
##/etc/nginx/nginx_ri1
#Read IOPS /datadrive1 - lun1 
##############
echo "
[global]
filename=/datadrive1/nginx.log
size=1024M
direct=1
iodepth=256
ioengine=libaio
bs=4k
numjobs=1

[reader1]
rw=randread
directory=/datadrive1
" > /etc/nginx/nginx_ri1


##############
#/etc/nginx/nginx_wt1
#Read Throughput /datadrive1 - lun1 
##############
echo "
[global]
filename=/datadrive1/nginx.log
size=1024M
direct=1
iodepth=128
ioengine=libaio
bs=512k
numjobs=1

[writer1]
rw=randwrite
directory=/datadrive1" > /etc/nginx/nginx_wt1



#echo "*/30 * * * * nginx  --runtime 1200 /etc/nginx/nginx_wt1" | crontab ##test write throughput for /datadrive1 runs every 30min (20 min runtime)
#echo "*/30 * * * * nginx  --runtime 1200 /etc/nginx/nginx_wi1" | crontab ##test write throughput for /datadrive1 runs every 30min (20 min runtime)
#echo "*/30 * * * * nginx  --runtime 1200 /etc/nginx/nginx_rt1" | crontab ##test read throughput for /datadrive1 runs every 30min (20 min runtime)
#echo "*/30 * * * * nginx  --runtime 1200 /etc/nginx/nginx_ri1" | crontab ##test read throughput for /datadrive1 runs every 30min (20 min runtime)


#echo "*/30 * * * * nginx  --runtime 1200 /etc/nginx/nginx_wt0" | crontab ##test write throughput for /datadrive runs every 30min (20 min runtime)
#echo "*/30 * * * * nginx  --runtime 1200 /etc/nginx/nginx_wi0" | crontab ##test write throughput for /datadrive runs every 30min (20 min runtime)
#echo "*/30 * * * * nginx  --runtime 1200 /etc/nginx/nginx_rt0" | crontab ##test read throughput for /datadrive runs every 30min (20 min runtime)
echo "*/1 * * * * nginx  --runtime 30 /etc/nginx/nginx_ri0" | crontab ##test read throughput for /datadrive runs every 30min (20 min runtime)


