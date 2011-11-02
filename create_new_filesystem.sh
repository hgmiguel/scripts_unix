#/usr/bin/env bash

sudo lvcreate -L50G --name video chicuace1
#/dev/mapper/chicuace1-video: open failed: No such file or directory
#/dev/chicuace1/video: not found: device not cleared
#Aborting. Failed to wipe start of new LV.
#LV chicuace1/video in use: not deactivating
#Unable to deactivate failed new LV. Manual intervention required.
          
hgmiguel@chicuace1:~$ sudo mkfs.ext4 /dev/chicuace1/video 
#mke2fs 1.42-WIP (02-Jul-2011)
#Filesystem label=
#OS type: Linux
#Block size=4096 (log=2)
#Fragment size=4096 (log=2)
#Stride=0 blocks, Stripe width=0 blocks
#3276800 inodes, 13107200 blocks
#655360 blocks (5.00%) reserved for the super user
#First data block=0
#Maximum filesystem blocks=4294967296
#400 block groups
#32768 blocks per group, 32768 fragments per group
#8192 inodes per group
#Superblock backups stored on blocks: 
#32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
#4096000, 7962624, 11239424
#
#Allocating group tables: done                            
#Writing inode tables: done                            
#Creating journal (32768 blocks): done
#Writing superblocks and filesystem accounting information: done   
#
#This filesystem will be automatically checked every 0 mounts or
#0 days, whichever comes first.  Use tune2fs -c or -i to override.
#
sudo e2label /dev/chicuace1/desarrollo desarrollo
sudo mount -t ext4 /dev/chicuace1/video /home/hgmiguel/Videos/


