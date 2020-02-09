#! /system/bin/sh
cp -a /system/etc/wifi/wpa_supplicant.conf /data/misc/wifi/
chmod 0660 /data/misc/wifi/wpa_supplicant.conf
chown system.wifi /data/misc/wifi/wpa_supplicant.conf

#if [ -n "$WCNSS" ] ; then
	echo "insmod /system/lib/modules/wlan.ko"
	insmod /system/lib/modules/wlan.ko
	NUM=$?
	echo $NUM
	if ( test $NUM -ne "0" ) ; then
		echo "rmmod wlan.ko"
		rmmod wlan.ko
		echo "insmod /system/lib/modules/wlan.ko 2222"
		insmod /system/lib/modules/wlan.ko
	fi
#fi

#echo "busybox ifconfig wlan0 up"
#busybox ifconfig wlan0 up

#STATE=`getprop init.svc.wpa_supplicant`
#echo $STATE
#if [ test $STATE -ne "running" ]; then
#	setprop ctl.start wpa_supplicant
#fi
setprop ctl.start p2p_supplicant
sleep 2  ;
#setprop ctl.start p2p_supplicant
# sleep 20;
setprop ctl.start mos
#setprop WPaMod 1
#getprop init.svc.wpa_supplicant



