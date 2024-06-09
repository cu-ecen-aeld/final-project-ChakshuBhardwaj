#!/bin/sh
sleep 5
/usr/bin/hciattach /dev/ttymxc3 any 115200 flow
/usr/sbin/rfkill unblock bluetooth
/usr/bin/hciconfig hci0 up
# Change BT UART baudrate to a higher speed, for example 921600
/usr/bin/hcitool -i hci0 cmd 0x3F 0x09 0x00 0x10 0x0e 0x00
/bin/stty -F /dev/ttymxc3 921600
