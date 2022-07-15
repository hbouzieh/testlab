#!/bin/bash
# Create Volume group
OSDISK=` sfdisk -l | awk '/Linux/ && $7 == "filesystem" { gsub("[0-9]", "", $1); split($1, a, "/"); print a[3]; }' `
TEMPDISK=` sfdisk -l | awk '$7 == "HPFS/NTFS/exFAT" { gsub("[0-9]", "", $1); split($1, a, "/"); print a[3]; }' `
DATA0=` lsblk | grep sd | grep -v $OSDISK | grep -v $TEMPDISK | awk '{print $1}' | sed -n '1p'`
DATA1=` lsblk | grep sd | grep -v $OSDISK | grep -v $TEMPDISK | awk '{print $1}' | sed -n '2p'`
DATA2=` lsblk | grep sd | grep -v $OSDISK | grep -v $TEMPDISK | awk '{print $1}' | sed -n '3p'`

vgcreate vg00 /dev/$DATA0 /dev/$DATA1 /dev/$DATA2


#Create logical volumes
lvcreate vg00 -n lv0 -L 50G -i 2 -I 128k
lvcreate vg00 -n lv1 -L 10G -m 2
lvcreate -n lv2 -L 100G vg00

# Create the mountpoints, prepare for mount and format the disks
mkdir -p /mnt/lv0
mkdir -p /mnt/lv1
mkdir -p /mnt/lv2

mkfs.ext4 /dev/vg00/lv0
mkfs.ext4 /dev/vg00/lv1
mkfs.ext4 /dev/vg00/lv2

echo "/dev/mapper/vg00-lv0 /mnt/lv0 ext4 defaults,nofail 0 0" >> /etc/fstab
echo "/dev/mapper/vg00-lv1 /mnt/lv1 ext4 defaults,nofail 0 0" >> /etc/fstab
echo "/dev/mapper/vg00-lv2 /mnt/lv2 ext4 defaults,nofail 0 0" >> /etc/fstab

mount -a
#try
yum install -y fio
