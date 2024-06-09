#!/bin/bash


while [ 1 ]
do

	current_ntp_address=`systemctl status systemd-timesyncd |grep Status|awk '{print$7}'|cut -d ':' -f1`
	systemctl status systemd-timesyncd |grep Status|awk '{print$7}'|cut -d ':' -f1 > /etc/ntp_address.txt
	
	[ -s /etc/ntp_address.txt ]
        if [ $? -eq 0 ]
	then
		 echo "$(date +':%d/%m/%Y  %H:%M:%S'): NTP restarted and address is $current_ntp_address" >> /var/logs/oes_ota.log
	else
		#killall udhcpc
		systemctl restart systemd-timesyncd
		systemctl status systemd-timesyncd |grep Status|awk '{print$7}'|cut -d ':' -f1 > /etc/ntp_address.txt
	fi

	if [ -f /home/root/pendrive.txt ]
	then
		echo "pendrive inserted" >> /var/logs/oes_ota.log
		var=`/bin/ls /dev/sda* |wc -l`
        	if [ $var -ne 0 ]
        	then  
			if [ -f /home/root/usb_detect.txt ]
			then 
				echo "usb_dectected" >> /var/logs/oes_ota.log
			else
				bin/touch /home/root/usb_detect.txt
				/bin/mount /dev/sda1 /mnt
				/bin/cp /mnt/*.mp3 /home/root
				/bin/cp /mnt/*.jpg /home/root	
			fi
        	else
                	echo "usb not detected" >> /var/logs/oes_ota.log
                	/bin/rm /home/root/usb_detect.txt
        	fi
	else
		echo "pendrive removed" >> /var/logs/oes_ota.log
		/bin/rm /home/root/usb_detect.txt
		/bin/rm /home/root/*.mp3
		/bin/rm /home/root/*.jpg
	fi

sleep 1
done
