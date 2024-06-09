#!/bin/bash

echo "--------------$(date +':%d/%m/%Y  %H:%M:%S') usb_firmware_upgrade ---------" >> /var/logs/oes_ota.log

sleep 1

/bin/rm -rf /home/root/oesc_ota*.tar.gz

OTA_DIR="/home/root/ota"
ZIMAGE_FILE="/home/root/ota/Image.gz"
DTB_FILE="/home/root/ota/imx8mm-var-som-symphony-legacy.dtb"
OTA_FILE="/home/root/ota/ota.tar.gz"
OTA_STATUS="/var/logs/oes_ota.log"
OTA_RETURN_STATUS="/home/root/ota_return_status.txt"
VERSION_FNAME="oesc_fwver"


package_extract () {

    if [ -f /home/root/usb_detect.txt ]
    then
        /bin/umount /mnt
	sleep 0.5
        /bin/echo "Mounting /dev/sda$1..."	>> /var/logs/oes_ota.log
        /bin/mount /dev/sda$1 /mnt >> /var/logs/oes_ota.log
        if [ $? -eq 0 ]
        then
			sleep 1
			
			firmware_file_count=`ls /mnt/oesc_ota*.tar.gz |wc -l`

			if [ "$firmware_file_count" -eq 1 ]
			then
		        /bin/cp /mnt/oesc_ota*.tar.gz /home/root/ >> /var/logs/oes_ota.log    
		        if [ $? -eq 0 ]                                                                 
		        then           
			        /bin/echo "firmware package move done" >> /var/logs/oes_ota.log
			        /bin/sync
				sleep 0.5                           

			        /bin/echo "Unmounting /dev/sda$1..."	>> /var/logs/oes_ota.log                                                             			      /bin/umount /dev/sda$1 >> /var/log/oes_ota.log           
			        /bin/sync 
				
				/bin/tar -xf /home/root/oesc_ota*.tar.gz -C /home/root
		                /bin/sync
				sleep 1
:'
			 	 if [ -f "$OTA_DIR/$VERSION_FNAME" ]
				 then
                        		present_version_major=`cat /etc/oesc_fwver |cut -d '.' -f1`
                        		present_version_minor=`cat /etc/oesc_fwver |cut -d '.' -f2`
                        		present_version_build=`cat /etc/oesc_fwver |cut -d '.' -f3`
                        		ota_version_major=`cat /home/root/ota/oesc_fwver |cut -d '.' -f1`
                        		ota_version_minor=`cat /home/root/ota/oesc_fwver |cut -d '.' -f2`
                        		ota_version_build=`cat /home/root/ota/oesc_fwver |cut -d '.' -f3`
                        		
					echo "present version of major is $present_version_major" >> $OTA_STATUS
                        		echo "present version of minor is $present_version_minor" >> $OTA_STATUS
                        		echo "present build number is $present_version_build" >> $OTA_STATUS
                        
                        		echo "ota major number is $ota_version_major" >> $OTA_STATUS
                        		echo "ota minor number is $ota_version_minor" >> $OTA_STATUS
                        		echo "ota build number is $ota_version_build" >> $OTA_STATUS
                        		
					upgrade="0"
                        		
					if [ "$ota_version_major" -gt "$present_version_major" ]
                    			then
                            			upgrade="1"
                        		
						elif [ "$ota_version_major" -eq "$present_version_major" ]
                        			then
                                		if [ "$ota_version_minor" -gt "$present_version_minor" ]
                                		then
                                        		upgrade="1"
                                			elif [ "$ota_version_minor" -eq "$present_version_minor" ]
                                			then
                                        		if [ "$ota_version_build" -gt "$present_version_build" ]
                                        		then
                                                		upgrade="1"
                                        		fi
                                		fi
                    			fi
                        
                        	echo "outside upgrade =$upgrade" >> $OTA_STATUS
                        	if [ "$upgrade" -eq "1" ]
                        	then
                                	echo "need to upgrade as OTA version is higher" >> $OTA_STATUS
                        	else
                                	echo "OTA Failed ::FW version is same or lower" >> $OTA_STATUS
                                	/bin/echo "5" > $OTA_RETURN_STATUS
                                	rm -rf "$OTA_DIR"
                                	exit 0
                                
                        	fi
                		else
                        		/bin/echo "6" > $OTA_RETURN_STATUS
                        		echo "OTA Failed ::version file is not available in main Archive." >> $OTA_STATUS
                        		rm -rf "$OTA_DIR"
                       		 	exit 0
                		fi

				sleep 0.5

				if [ -f $DTB_FILE ]
				then
                			/bin/echo "dtb file is available" >> /var/logs/oes_ota.log

                			/bin/mount /dev/mmcblk1p1 /mnt
                			/bin/rm /mnt/boot/imx8mm-var-som-symphony-legacy.dtb
                			/bin/cp /home/root/ota/imx8mm-var-som-symphony-legacy.dtb /mnt/boot/.
                			/bin/umount /dev/mmcblk1p1

                			/bin/echo "dtb changes successfully" >> /var/logs/oes_ota.log
        			fi

        			if [ -f $ZIMAGE_FILE ]
				then
                			/bin/echo "kernel file is available" >> /var/logs/oes_ota.log

        			        /bin/mount /dev/mmcblk1p1 /mnt
                			/bin/rm /mnt/boot/Image.gz
                			/bin/cp /home/root/ota/Image.gz /mnt/boot/.
                			/bin/umount /dev/mmcblk1p1

                			/bin/echo "zImage changed successfully" >> /var/logs/oes_ota.log
        			fi
'
				if [ -f $OTA_FILE ]
				then
				        /bin/echo "ota file Available"
        				/bin/echo "ota file Available" >> /var/logs/oes_ota.log


        				/bin/tar -xf $OTA_FILE -C /

        				if [ `/bin/echo $?` -eq 0 ]; then
                				/bin/echo "ota Archive extracted successfully." >> /var/logs/oes_ota.log
        				else
                				/bin/echo "Failed to extract archive." >> /var/logs/oes_ota.log
        				fi
				fi

				/bin/cp /home/root/ota/oesc_fwver /etc/oesc_fwver
				/bin/echo "Version file updated" >> /var/logs/oes_ota.log
        			/bin/echo "Removing OTA directory and tar file" >> /var/logs/oes_ota.log
        			/bin/rm -rf /home/root/ota			
				/bin/rm -rf /home/root/oesc_ota*.tar.gz
					
				/bin/echo "OTA applied. Rebooting Device" >> /var/logs/oes_ota.log
				/bin/echo "4" > /home/root/ota_return_status.txt
        			#/sbin/reboot -f	
				
		        else
			        /bin/echo "Unmounting /dev/sda$1..."	>> /var/logs/oes_ota.log
			        /bin/umount /dev/sda$1 &>> /var/logs/oes_ota.log     
			        /bin/sync                                                             
			        /bin/echo "$(date +':%d/%m/%Y  %H:%M:%S SYSTEM: ') firmware package move not done" >> /var/logs/oes_ota.log
		        fi
		elif [ "$firmware_file_count" -gt 1 ]
                then
                        /bin/echo "Multiple packages available" >> /var/logs/oes_ota.log
                        /bin/echo "1" > /home/root/ota_return_status.txt
                        /bin/echo "Unmounting /dev/sda$1..."    >> /var/logs/oes_ota.log
                        /bin/umount /dev/sda$1 &>> /var/logs/oes_ota.log
                        /bin/sync
                        exit
                else
                        /bin/echo "Firmware file not present" >> /var/logs/oes_ota.log
                        /bin/echo "2" > /home/root/ota_return_status.txt
                        /bin/echo "Unmounting /dev/sda$1..."    >> /var/logs/oes_ota.log
                        /bin/umount /dev/sda$1 &>> /var/logs/oes_ota.log
                        /bin/sync
                        exit
                fi

    		fi
	fi	
}


var=`/bin/ls /dev/sda* |wc -l`
if [ $var -ne 0 ]
then
count_partition=`/bin/ls /dev/sda* |wc -l`

        package_extract
        for check in $(seq 0 $count_partition)
        do
                package_extract $check
                sleep 1
        done
else
        /bin/echo "partition not available" >> /var/logs/oes_ota.log
	/bin/echo "3" > /home/root/ota_return_status.txt
fi
