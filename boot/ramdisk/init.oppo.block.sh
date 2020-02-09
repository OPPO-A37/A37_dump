#!/system/bin/sh

#ifdef VENDOR_EDIT
#Peirs@Swdp.Android.FrameworkUi, 2014/07/30, add provide a function to indentify the usage of the phone.
#recommend set in the stage of "on post-fs"
chmod 0660 /dev/block/mmcblk0p36
chown root.system /dev/block/mmcblk0p36
#endif

#ifdef VENDOR_EDIT
#ShaoQiang@EXP.SysFramework.Framework, 2016/04/18, Add for allow engineermode read/write reserve_exp1 for sellmode flag
#ShaoQiang@EXP.SysFramework.Framework, 2016/05/11, Add for allow rild read reserve_exp1 for sellmode flag
#Wenfeng.Li@PSW.AD.BuildConfig.0, 2018/01/11, Add for allow rild write reserve_exp1 for TH lock
chmod 0664 /dev/block/mmcblk0p37
chown system.radio /dev/block/mmcblk0p37
#ifdef VENDOR_EDIT

