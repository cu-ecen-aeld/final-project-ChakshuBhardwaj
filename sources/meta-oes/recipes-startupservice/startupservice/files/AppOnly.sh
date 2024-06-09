#!/bin/bash

APP_NAME=oes_app
DATABASE_FILE_NAME=OESDatabase.db
VERSION_FILE=oesc_fwver
LOG_FILE=/var/logs/oes_ota.log

umount -q /mnt
echo "**************APP UPDATE BEGIN**************" >> ${LOG_FILE}
echo "Mounting Device /dev/sda"
echo "Mounting Device /dev/sda" >> ${LOG_FILE}

update_app () {
	if [ $1 -eq 99 ]
	then
		mount /dev/sda /mnt
	else
		mount /dev/sda$1 /mnt
	fi
if [ $? -eq 0 ]
then
	echo "Mounting complete"
	echo "Mounting complete" >> ${LOG_FILE}
	mkdir -p /home/root/UpdateTemp
	/bin/cp /mnt/ISC_Edge.tar.gz /home/root/UpdateTemp/
	
	
	if [ $? -eq 0 ]
	then
		echo "tarball copied"
		echo "tarball copied" >> ${LOG_FILE}
		cd /home/root/UpdateTemp/
		tar -xf ISC_Edge.tar.gz
		cd /home/root/UpdateTemp/ISC_Edge/

		if [ -f ${VERSION_FILE} ]
		then
			rm -f /etc/${VERSION_FILE}
			cp ${VERSION_FILE} /etc/
			chmod 777 /etc/${VERSION_FILE}
			echo "Version file ${VERSION_FILE} copied"
			echo "Version file ${VERSION_FILE} copied" >> ${LOG_FILE}
		else
			echo "Version file ${VERSION_FILE} is missing, exiting the update process without updating"
			echo "Version file ${VERSION_FILE} is missing, exiting the update process without updating" >> ${LOG_FILE}
			rm -drf /home/root/UpdateTemp
			exit 1
		fi

		if [ -f ${APP_NAME} ]
		then
			rm -f /usr/bin/${APP_NAME}
			cp -f ${APP_NAME} /usr/bin
			chmod 777 /usr/bin/${APP_NAME}
			echo "Application file ${APP_NAME} copied"
			echo "Application file ${APP_NAME} copied" >> ${LOG_FILE}
		else
			echo "Application file ${APP_NAME} is missing, exiting the update process without updating"
			echo "Application file ${APP_NAME} is missing, exiting the update process without updating" >> ${LOG_FILE}
			rm -drf /home/root/UpdateTemp
			exit 1
		fi
		if [ -f ${DATABASE_FILE_NAME} ]
		then
			rm -f /home/vvdn/${DATABASE_FILE_NAME}
			cp -f ${DATABASE_FILE_NAME} /home/vvdn/
			chmod 777 /home/vvdn/${DATABASE_FILE_NAME}
			echo "Database file ${DATABASE_FILE_NAME} copied"
			echo "Database file ${DATABASE_FILE_NAME} copied" >> ${LOG_FILE}
		else
			echo "Database file ${DATABASE_FILE_NAME} is missing, skipping the update for this file"
			echo "Database file ${DATABASE_FILE_NAME} is missing, skipping the update for this file" >> ${LOG_FILE}
		fi
	else
		echo "Failed to copy tarball"
		echo "Failed to copy tarball" >> ${LOG_FILE}
		echo "**************APP UPDATE ENDED**************" >> ${LOG_FILE}
		rm -drf /home/root/UpdateTemp
		exit 1
	fi

	if [ $? -eq 0 ]
	then
		echo "Extraction and Copy Successful, unmounting drive"
		echo "Extraction and Copy Successful, unmounting drive" >> ${LOG_FILE}
		echo "App and Database file updated"
		echo "App and Database file updated" >> ${LOG_FILE}
		if [ $1 -eq 99 ]
		then
			umount -q /dev/sda
		else
			umount -q /dev/sda$1
		fi
		rm -drf /home/root/UpdateTemp
		echo "Rebooting in 3 seconds"
		echo "**************APP UPDATE ENDED**************" >> ${LOG_FILE}
		sleep 3
		/sbin/reboot -f
	else
		echo "Failed to extract and copy"
		echo "Failed to extract and copy" >> ${LOG_FILE}
		echo "**************APP UPDATE ENDED**************" >> ${LOG_FILE}
		rm -drf /home/root/UpdateTemp
		exit 1
	fi
else
	echo "Mounting Unsuccessful, try again!!"
	echo "Mounting Unsuccessful, try again!!" >> ${LOG_FILE}
	umount -q /mnt
	echo "**************APP UPDATE ENDED**************" >> ${LOG_FILE}
	rm -drf /home/root/UpdateTemp
	#exit 1
fi

}

var=`/bin/ls /dev/sda* |wc -l`
if [ $var -gt 1 ]
then
count_partition=`/bin/ls /dev/sda* |wc -l`

        for check in $(seq 0 $count_partition)
        do
                update_app $check
                sleep 1
        done
else
	update_app 99
	#/bin/echo "partition not available"
    #/bin/echo "partition not available" >> ${LOG_FILE}
	#/bin/echo "3" > /home/root/ota_return_status.txt
fi
