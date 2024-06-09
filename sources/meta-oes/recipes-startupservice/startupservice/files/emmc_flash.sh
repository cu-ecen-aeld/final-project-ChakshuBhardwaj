#!/bin/bash

if [ -f /home/root/usb_detect.txt ]
then
        /bin/umount /mnt
        /bin/mount /dev/sda1 /mnt
        if [ $? -eq 0 ]
        then
                /bin/cp /mnt/b2qt-embedded-qt6-image.wic.gz /home/root/
                if [ $? -eq 0 ]
                then
                        /bin/echo 0 > /sys/block/mmcblk2boot0/force_ro
                        gunzip -c /home/root/b2qt-embedded-qt6-image.wic.gz|dd of=/dev/mmcblk2 bs=1M status=progress && sync
                        sleep 2
                        /bin/echo "4" > /home/root/ota_return_status.txt
			/bin/umount /mnt
                        /bin/rm -rf /home/root/b2qt-embedded-qt6-image.wic.gz
                else
                        /bin/echo "2" > /home/root/ota_return_status.txt
                fi
        fi
fi
