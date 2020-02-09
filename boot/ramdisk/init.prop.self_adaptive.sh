#!/system/bin/sh
#Jevons@OnLineRD.DeviceService, 2013/10/23 add this file for properties

#  hw_pcb_version:10、11、12、13
#  hw_rf_version：
#	11,		//WCDMA_GSM_
#	12,		//WCDMA_GSM_LTE_	
#	13,		//WCDMA_GSM_LTE_
#	21,		//WCDMA_GSM_CDMA_	
#	22,		//WCDMA_GSM_
#	23,		//WCDMA_GSM_
#	31,		//TD_GSM	
#	32,		//TD_GSM_LTE	
#	33,		//TDD_FDD_TD_W_GSM		

######################################################################
#    Copied from 8974 self-init.c
#    int NETWORK_MODE_WCDMA_PREF = 0; //GSM/WCDMA (WCDMA preferred) 
#    int NETWORK_MODE_GSM_ONLY = 1; //GSM only 
#    int NETWORK_MODE_WCDMA_ONLY = 2; //WCDMA only 
#    int NETWORK_MODE_GSM_UMTS = 3; //GSM/WCDMA (auto mode, according to PRL)
#                                   //         AVAILABLE Application Settings menu
#    int NETWORK_MODE_CDMA = 4; //CDMA and EvDo (auto mode, according to PRL)
#                               //             AVAILABLE Application Settings menu
#    int NETWORK_MODE_CDMA_NO_EVDO = 5; //CDMA only 
#    int NETWORK_MODE_EVDO_NO_CDMA = 6; //EvDo only 
#    int NETWORK_MODE_GLOBAL = 7; //GSM/WCDMA, CDMA, and EvDo (auto mode, according to PRL)
#                                 //           AVAILABLE Application Settings menu
#    int NETWORK_MODE_LTE_CDMA_EVDO = 8; //LTE, CDMA and EvDo 
#    int NETWORK_MODE_LTE_GSM_WCDMA = 9; //LTE, GSM/WCDMA 
#    int NETWORK_MODE_LTE_CMDA_EVDO_GSM_WCDMA = 10; //LTE, CDMA, EvDo, GSM/WCDMA 
#    int NETWORK_MODE_LTE_ONLY = 11; //LTE Only mode. 
#    int NETWORK_MODE_LTE_WCDMA = 12; //LTE/WCDMA 
#    int NETWORK_MODE_TD_SCDMA_ONLY = 13; //TD-SCDMA only 
#    int NETWORK_MODE_TD_SCDMA_WCDMA = 14; //TD-SCDMA and WCDMA 
#    int NETWORK_MODE_TD_SCDMA_LTE = 15; //TD-SCDMA and LTE 
#    int NETWORK_MODE_TD_SCDMA_GSM = 16; //TD-SCDMA and GSM 
#    int NETWORK_MODE_TD_SCDMA_GSM_LTE = 17; //TD-SCDMA,GSM and LTE 
#    int NETWORK_MODE_TD_SCDMA_GSM_WCDMA = 18; //TD-SCDMA, GSM/WCDMA 
#    int NETWORK_MODE_TD_SCDMA_WCDMA_LTE = 19; //TD-SCDMA, WCDMA and LTE 
#    int NETWORK_MODE_TD_SCDMA_GSM_WCDMA_LTE = 20; //TD-SCDMA, GSM/WCDMA and LTE 
#    int NETWORK_MODE_TD_SCDMA_CDMA_EVDO_GSM_WCDMA = 21; //TD-SCDMA,EvDo,CDMA,GSM/WCDMA
#    int NETWORK_MODE_TD_SCDMA_LTE_CDMA_EVDO_GSM_WCDMA = 22; //TD-SCDMA/LTE/GSM/WCDMA, CDMA, and
#                                                            //   EvDo 
######################################################################

#pcb_version=`cat sys/devices/system/soc/soc0/hw_pcb_version`
#rf_version=`cat sys/devices/system/soc/soc0/hw_rf_version`

#ifdef VENDOR_EDIT
#BaoZhu.Yu@Prd.CommApp.Mms, 2014/03/19, Add for 14033, 14017, 14013, 14027.
modem_type=`cat /proc/oppoVersion/modemType`        #区分不同modem制式
operator_name=`cat /proc/oppoVersion/operatorName`  #区分内销,外销等不同运营商,内销 移动：2，联通：3，电信：4
pcb_version=`cat /proc/oppoVersion/pcbVersion`      #区分不同pcb阶段
prj_version=`cat /proc/oppoVersion/prjVersion`      #区分不同项目
reserved_version=`cat /proc/oppoVersion/reserved`   #预留位

setprop ro.modem_type $modem_type
setprop ro.operator_name $operator_name
setprop ro.prj_version $prj_version
setprop ro.reserved_version $reserved_version
#endif /* VENDOR_EDIT */

setprop ro.pcb_version $pcb_version

#ifdef VENDOR_EDIT
#ShaoQiang@EXP.SysFramework.Framework, 2016/04/29, Add for 15399 distinguish ro.product.device and ro.build.fingerprint
#Memtotal example
#A37fs:MemTotal:        3000776 kB
#A37f: MemTotal:        1932040 kB
qcom_soft=`getprop ro.common.soft`

if [ x$qcom_soft = x"MSM_15399" ] ; then
A37f_RAM=`cat /proc/meminfo |grep MemTotal`
A37f_RAM=${A37f_RAM:0-10:7}

    if [ $A37f_RAM -lt "2500000" ] ; then
        setprop ro.product.device A37f
    elif [ $A37f_RAM -ge "2500000" ] ; then
        setprop ro.product.device A37fs
    fi
fi

#endif /* VENDOR_EDIT */

#ifdef VENDOR_EDIT
#wangjimin@EXP.SysFramework.build,add for Singapore Taiwan operator,20141022
#Qiang.shao@EXP.SysFramework.build,add for DZ, 20150213
#Qiang.shao@EXP.SysFramework.build,add for AU OPTUS, 20150520
#Qiang.shao@EXP.SysFramework.build,add for operator dynamic clientid, 20150520
#Qiang.shao@EXP.SysFramework.build,add for 15089 BARCA, 20150818
#Liuli@EXP.SysFramework.Framework, 2015/08/20, Add for full disk encryption
#Qiang.shao@EXP.SysFramework.build,add for 15081 dynamic fingerprint, 20150909
#Qiang.shao@EXP.SysFramework.build,add for 15081 starhub FDE, 20151010
#  Value      Operator
#  00000000   EX
#  00000001   SINGTEL
#  00000010   STARHUB
#  00000011   M1
#  00000100   CHT
#  00000101   FET
#  00000110   TWM
#  00000111   VBO
#  00001000   VN (region)
#  00001001   TWOP    all Taiwan Operators
#  00001010   DZ
#  00001011   OPTUS
#  00001100   3001
#  00001101   3006
#  00001110   MX-TELCEL    //reserved
#  00001111   MX-MOVISTAR  //reserved
#  00010000   BARCA
#  00010001   Indonesia 3G
#  00010010   GLOBE
#  00011011   IN netlock, forbidden fleeing goods
#  00100111   DZ netlock, forbidden fleeing goods
#  00110101   TH TRUE

#no need use the property in MX build,because it compile independently
mx_or_us=`getprop persist.sys.oppo.region`
device=`getprop ro.product.device`
base_os=

if [ $qcom_soft = "MSM_15081" ]; then
    #15081 US
    #fingerprint=OPPO/R7sf/R7sm:5.1.1/LMY47V/1432282665:user/release-keys
    fingerprint=OPPO/R7sfg/R7sf:5.1.1/LMY47V/1443181720:user/release-keys
elif [ $qcom_soft = "MSM_15099" ] ; then
    #15099 US
    fingerprint=OPPO/A53f/A53:5.1.1/LMY47V/1442916888:user/release-keys
elif [ $qcom_soft = "MSM_15095" ] ; then
    #15095 US
    fingerprint=OPPO/A33f/A33:5.1.1/LMY47V/1439868418:user/release-keys
elif [ $qcom_soft = "MSM_15309" ] ; then
    #15309 US
    fingerprint=OPPO/F1f/F1f:5.1.1/LMY47V/1446204931:user/release-keys
elif [ $qcom_soft = "MSM_15399" ] ; then
    #15399 US
    if [ x$device = x"A37fs" ] ; then
        fingerprint=OPPO/A37f/A37fs:5.1.1/LMY47V/1464410042:user/release-keys
        base_os=OPPO/A37f/A37fs:5.1.1/LMY47V/1464410042:user/release-keys
    else
        fingerprint=OPPO/A37f/A37f:5.1.1/LMY47V/1519717078:user/release-keys
        base_os=OPPO/A37f/A37f:5.1.1/LMY47V/1516972692:user/release-keys
    fi
else
    #define default fingerprint, use 15309 US
    fingerprint=OPPO/F1f/F1f:5.1.1/LMY47V/1446204931:user/release-keys
fi

if [ $mx_or_us = "MX" ] ; then
    setprop persist.sys.oppo.region MX
    setprop ro.com.google.clientidbase android-oppo
    setprop ro.com.google.clientidbase.ms android-americamovil-{country}
    setprop ro.com.google.clientidbase.yt android-oppo
    setprop ro.com.google.clientidbase.am android-americamovil-{country}
    setprop ro.com.google.clientidbase.gmm android-oppo
    if [ $qcom_soft = "MSM_15081" ]; then
        #15081 MX
        #fingerprint=OPPO/R7sf/R7sm:5.1.1/LMY47V/1440574505:user/release-keys
        fingerprint=OPPO/R7sfg/R7sf:5.1.1/LMY47V/1440579988:user/release-keys
    elif [ $qcom_soft = "MSM_15099" ] ; then
        #15099 MX
        fingerprint=OPPO/A53f/A53:5.1.1/LMY47V/1442916666:user/release-keys
    elif [ $qcom_soft = "MSM_15095" ] ; then
        #15095 MX
        fingerprint=OPPO/A33f/A33:5.1.1/LMY47V/1442998508:user/release-keys
    fi
    #WangZhi@EXP.CommService.telephony, 2015/07/22, set for MX version to close FD.
    setprop persist.dpm.feature 0
else
    #WangZhi@EXP.CommService.telephony, 2015/07/22, set for MX version to close FD.
    setprop persist.dpm.feature 3

    #Qiang.shao@EXP.SysFramework, 2015/09/02, Support Full Disk Ecryption.
    #Qiang.shao@EXP.SysFramework, 2015/09/08, add for solve bugid 693945. condition is -f /data/opponvitems/6853 true but -s /data/opponvitems/6853 fail
    if [ -s /cache/opponvitems/6853 ]; then
        exp_operator_cache=`cat /cache/opponvitems/6853`
        #Qiang.shao@EXP.SysFramework.build,add for get first 8bits flag, 20150610
        exp_operator_cache=${exp_operator_cache:0:8}
    fi

    if [ -s /data/opponvitems/6853 ]; then
        exp_operator=`cat /data/opponvitems/6853`
        #Qiang.shao@EXP.SysFramework.build,add for get first 8bits flag, 20150610
        exp_operator=${exp_operator:0:8}
        mkdir -p /cache/opponvitems
        cp -rf /data/opponvitems/6853 /cache/opponvitems/6853
    fi

    if [ -s /cache/opponvitems/6853 ] && [ ! -s /data/opponvitems/6853 ] ; then
        exp_operator=${exp_operator_cache:0:8}
    fi

    setprop ro.com.google.clientidbase android-oppo
    if [ x$exp_operator = x"00000001" ] ; then
       setprop ro.oppo.operator SINGTEL
       setprop persist.sys.oppo.region SG
       #display_id=`getprop ro.build.display.id`
       #display_id_op=$display_id"_SINGTEL"
       #setprop ro.build.display.id $display_id_op
        if [ $qcom_soft = "MSM_15081" ]; then
            #15081 SG
            setprop ro.sys.full_disk_ecryption true
            #fingerprint=OPPO/R7sf/R7sm:5.1.1/LMY47V/1440835194:user/release-keys
            fingerprint=OPPO/R7sfg/R7sf:5.1.1/LMY47V/1440836568:user/release-keys
        elif [ $qcom_soft = "MSM_15099" ] ; then
            #15099 SG
            fingerprint=OPPO/A53f/A53:5.1.1/LMY47V/1442921215:user/release-keys
        fi
    elif [ x$exp_operator = x"00000010" ] ; then
       setprop ro.oppo.operator STARHUB
       setprop persist.sys.oppo.region SG
       if [ $qcom_soft = "MSM_15081" ]; then
            setprop ro.sys.full_disk_ecryption true
       fi
       #display_id=`getprop ro.build.display.id`
       #display_id_op=$display_id"_STARHUB"
       #setprop ro.build.display.id $display_id_op
    elif [ x$exp_operator = x"00000011" ] ; then
       setprop ro.oppo.operator M1
       setprop persist.sys.oppo.region SG
    elif [ x$exp_operator = x"00000100" ] ; then
       setprop ro.oppo.operator CHT
       setprop persist.sys.oppo.region TW
       #display_id=`getprop ro.build.display.id`
       #display_id_op=$display_id"_STARHUB"
       #setprop ro.build.display.id $display_id_op
    elif [ x$exp_operator = x"00000101" ] ; then
       setprop ro.oppo.operator FET
       setprop persist.sys.oppo.region TW
    elif [ x$exp_operator = x"00000110" ] ; then
       setprop ro.oppo.operator TWM
       setprop persist.sys.oppo.region TW
    elif [ x$exp_operator = x"00000111" ] ; then
       setprop ro.oppo.operator VBO
       setprop persist.sys.oppo.region TW
    #no need set VN, just delete wechat by EngineerMode,20150205
    #elif [ x$exp_operator = x"00001000" ] ; then
    #   setprop persist.sys.oppo.region VN
    elif [ x$exp_operator = x"00001001" ] ; then
       setprop ro.oppo.operator TWOP
       setprop persist.sys.oppo.region TW
    elif [ x$exp_operator = x"00001010" ] ; then
       setprop ro.oppo.specialdemand DZ
    elif [ x$exp_operator = x"00001011" ] ; then
       setprop ro.oppo.operator OPTUS
       setprop persist.sys.oppo.region AU
       setprop ro.com.google.clientidbase.ms android-optus-au
       setprop ro.com.google.clientidbase.am android-optus-au
       #setprop ro.sys.full_disk_ecryption true
        #WangZhi@EXP.CommService.telephony, 2015/12/16, set for Optus operator to close FD.
        setprop persist.dpm.feature 0
        if [ $qcom_soft = "MSM_15081" ]; then
            #15081 AU
            #fingerprint=OPPO/R7sf/R7sm:5.1.1/LMY47V/1440744277:user/release-keys
            fingerprint=OPPO/R7sfg/R7sf:5.1.1/LMY47V/1440744888:user/release-keys
        elif [ $qcom_soft = "MSM_15099" ] ; then
            #15099 AU
            fingerprint=OPPO/A53f/A53:5.1.1/LMY47V/1442922225:user/release-keys
        elif [ $qcom_soft = "MSM_15309" ] ; then
            #15309 AU
            fingerprint=OPPO/F1f/F1f:5.1.1/LMY47V/1446204988:user/release-keys
        fi
    elif [ x$exp_operator = x"00010000" ] ; then
        if [ $qcom_soft = "MSM_15089" ]; then
            setprop ro.oppo.specialdemand BARCA
        fi
    elif [ x$exp_operator = x"00010001" ] ; then
        if [ $qcom_soft = "MSM_15399" ]; then
            #15399 Indonesia 3G
            if [ x$device = x"A37fs" ] ; then
                fingerprint=OPPO/A37fw/A37fs:5.1.1/LMY47V/1455690779:user/release-keys
            else
                fingerprint=OPPO/A37fw/A37f:5.1.1/LMY47V/1519717163:user/release-keys
                base_os=OPPO/A37fw/A37f:5.1.1/LMY47V/1516972723:user/release-keys
            fi
        fi
    elif [ x$exp_operator = x"00010010" ] ; then
       setprop ro.oppo.operator GLOBE
       setprop persist.sys.oppo.region PH
    elif [ x$exp_operator = x"00100100" ] ; then
        #SG SINGTEL FLEE AVOID VERSION
        setprop ro.oppo.operator SINGTEL
        setprop persist.sys.oppo.region SG
    elif [ x$exp_operator = x"00100101" ] ; then
        #SG STARHUB FLEE AVOID VERSION
        setprop ro.oppo.operator STARHUB
        setprop persist.sys.oppo.region SG
    elif [ x$exp_operator = x"00110101" ] ; then
        setprop ro.oppo.operator.device.lock TRUE
    fi
fi
setprop ro.build.version.base_os ${base_os}
setprop ro.build.fingerprint ${fingerprint}

#for flee avoid version
if [ x$exp_operator = x"00011011" ] ; then
   #IN PUBLIC
   setprop ro.oppo.region.netlock IN
elif [ x$exp_operator = x"00100011" ] ; then
   #SG PUBLIC
   setprop ro.oppo.region.netlock SG
elif [ x$exp_operator = x"00100100" ] ; then
   #SG SINGTEL
   setprop ro.oppo.region.netlock SG
elif [ x$exp_operator = x"00100101" ] ; then
   #SG STARHUB
   setprop ro.oppo.region.netlock SG
elif [ x$exp_operator = x"00100111" ] ; then
   #DZ PUBLIC
   setprop ro.oppo.region.netlock DZ
fi

#DZ for hide ring on price less than RMB1500 product
if [ x$exp_operator = x"00100111" ] ; then
   #DZ PUBLIC
   setprop ro.oppo.specialdemand DZ
fi

#debug for current pid
#echo "PID of this script: $$"
#setprop ro.test $$
#endif /* VENDOR_EDIT */
