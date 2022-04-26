#!/bin/bash
# Dettect data disk
DISK=$(lsblk | grep 128 |awk '{ print $1 }')
# Create Partitions
parted /dev/sdb mklabel gpt
parted -a optimal /dev/$DISK mkpart primary 0% 100%
# Dettect UUID of primary partition of Data Disk
DISKID=$(blkid | grep "$DISK" | awk '{ print $2 }')
# Create Filesystems and mount them
mkfs.ext4 /dev/"$DISK"1
mkdir /mnt/datadisk
echo $DISKID /mnt/datadisk ext4 defaults,nofail 0 0 >> /etc/fstab
mount -a
# Install and Run FIO (Adjust runtime according to needs... it's set to run for 1 hour)
apt update
apt install fio -y
fio --directory=/mnt/datadisk --name=randrw2.dat --ioengine=libaio --iodepth=128 --rw=randwrite --bs=1024k --direct=1 --numjobs=1 --runtime=3000 --size=3000000 --group_reporting --time_based &>/dev/null &
