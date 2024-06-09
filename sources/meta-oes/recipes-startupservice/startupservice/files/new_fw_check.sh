#/bin/bash
	
	/bin/umount /dev/sda1
 	if [ -f /home/root/usb_detect.txt ]
	then 
		/bin/mount /dev/sda1 /mnt
       		sleep 0.2
        	ls /mnt/oesc*|cut -d 'V' -f2|cut -b -5 > /etc/new_fw_version.txt
        	/bin/umount /dev/sda1
		/bin/sync
	fi
