#!/bin/bash

#dayTime=$(cat /home/prabhash/abc.txt | awk ' FNR==1 {printf $3}')
#nightTime=$(cat /home/prabhash/abc.txt | awk ' FNR==2 {printf $3}')
#dayHour=$(cat /home/prabhash/abc.txt | awk ' FNR==1 {printf $2}' | head -c 2)
#nightHour=$(cat /home/prabhash/abc.txt | awk ' FNR==2 {printf $2}' | head -c 2)
#dayMin=$(cat /home/prabhash/abc.txt | awk ' FNR==1 {printf $2}' | tail -c 2)
#nightMin=$(cat /home/prabhash/abc.txt | awk ' FNR==2 {printf $2}' | tail -c 2)
#dayBrightness=$(cat /home/prabhash/abc.txt | awk ' FNR==1 {printf $4}')
#nightBrightness=$(cat /home/prabhash/abc.txt | awk ' FNR==2 {printf $4}')

WAIT_TIME_BEFORE_STARTUP=60
CYCLIC_SLEEP=1
time=12

#sleep $WAIT_TIME_BEFORE_STARTUP

#echo "hello" >> /root/pebbu

echo $dayBrightness
echo $nightBrightness

while [ 1 ]
do
	#echo "helloword" >> /root/pebbu
	sleep $CYCLIC_SLEEP
	#dayTime=$(cat /h.txt | awk ' FNR==1 {printf $3}')
	#nightTime=$(cat /home/prabhash/abc.txt | awk ' FNR==2 {printf $3}')
	dayHour=$(cat /etc/Brightness.txt | awk ' FNR==1 {printf $2}' | head -c 2)
	nightHour=$(cat /etc/Brightness.txt | awk ' FNR==2 {printf $2}' | head -c 2)
	dayMin=$(cat /etc/Brightness.txt | awk ' FNR==1 {printf $2}' | tail -c 2)
	nightMin=$(cat /etc/Brightness.txt | awk ' FNR==2 {printf $2}' | tail -c 2)
	dayBrightness=$(cat /etc/Brightness.txt | awk ' FNR==1 {printf $4}')
	nightBrightness=$(cat /etc/Brightness.txt | awk ' FNR==2 {printf $4}')

	currentHour=$(date +%H)
	currentMin=$(date +%M)


	if [ $currentHour -ge "12" ] && [ $currentMin -ge "00" ]; then
		#echo "PM time is here"
		currentHour=$((currentHour - time))
		#echo $currentHour

		if [ $currentHour -ge $nightHour ] && [ $currentMin -ge $nightMin ];then
			#echo "value of night here"
			echo $nightBrightness > /sys/class/backlight/backlight/brightness
		else
			echo $dayBrightness > /sys/class/backlight/backlight/brightness
		fi

	else

		#echo "AM time is here"
		if [ $currentHour -ge $dayHour ] && [ $currentMin -ge $dayMin ];then
			#echo "value of morning here"
			echo $dayBrightness > /sys/class/backlight/backlight/brightness
		else
			echo $nightBrightness > /sys/class/backlight/backlight/brightness
		fi

	fi
	sleep 2
done


