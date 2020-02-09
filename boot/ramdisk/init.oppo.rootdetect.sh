#!/system/bin/sh

###################################################################################################
if [ -f system/bin/su -o -f /system/xbin/su -o -f /system/sbin/su -o -f /sbin/su -o -f /vendor/bin/su ]; then    	
		setprop persist.sys.root.state 1		
fi
#ifdef VENDOR_EDIT
#Bingshu.Zhou@Swdp.Android, 2015/07/08 , add for fix data/app permissions
chmod 0755 /data/app/*
touch /persist/cfu_switch
chown radio:system /persist/cfu_switch
chmod 0664 /persist/cfu_switch
#endif /* VENDOR_EDIT */
######################################################################################################
