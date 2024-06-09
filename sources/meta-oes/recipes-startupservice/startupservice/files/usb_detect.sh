#!/bin/bash

sleep 1

counter=35

while [ $counter -ne 0 ]
do
        sleep 1
        var=`/bin/ls /dev/sda* |wc -l`
        if [ $var -ne 0 ]
        then                
		echo "pendrive detected" >> /var/logs/oes_ota.log
                /bin/touch /home/root/usb_detect.txt
        else
                echo "pendrive not detected" >> /var/logs/oes_ota.log
		/bin/rm /home/root/usb_detect.txt
        fi
        echo $counter >> /var/logs/oes_ota.log
        ((counter-=1))
done
