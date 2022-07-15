#!/bin/bash
# Perf Lab scenario 2 script

yum update -y --disablerepo='*' --enablerepo='*microsoft*'

fdisk /dev/sdc << FDISK_CMDS
n 
p
1


w
FDISK_CMDS

mkfs /dev/sdc1

for disk in c; do diskuuid="$(blkid -s UUID -o value /dev/sdc1)"; \
mkdir /data; \
echo "UUID=${diskuuid} /data ext4 defaults,nofail 0 0" >> /etc/fstab; \
mount -a; \
done

yum install fio --assumeyes

echo "* * * * * fio --directory=/data --name=randrw2.dat --ioengine=libaio --iodepth=4 --rw=randwrite --bs=128k --direct=1 --size=1024M --numjobs=1 --runtime=60 --group_reporting --time_based" | crontab