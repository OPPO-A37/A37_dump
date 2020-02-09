#!/system/bin/sh
mount -t debugfs none /sys/kernel/debug

count=1 
while true
do 
echo "Iteration $count" >> /sdcard/meminfo.log
date >> /sdcard/meminfo.log
echo ------------------ >> /sdcard/meminfo.log

echo "Iteration $count" >> /sdcard/procrank.log
date >> /sdcard/procrank.log
echo ------------------ >> /sdcard/procrank.log

echo "Iteration $count" >> /sdcard/slabinfo.log
date >> /sdcard/slabinfo.log
echo ------------------ >> /sdcard/slabinfo.log

echo "Iteration $count" >> /sdcard/pagetypeinfo.log
date >> /sdcard/pagetypeinfo.log
echo ------------------ >> /sdcard/pagetypeinfo.log

echo "Iteration $count" >> /sdcard/kmemleak.log
date >> /sdcard/kmemleak.log
echo ------------------ >> /sdcard/kmemleak.log

echo "Iteration $count" >> /sdcard/iondump.log
date >> /sdcard/iondump.log
echo ------------------ >> /sdcard/iondump.log

cat /proc/meminfo >> /sdcard/meminfo.log
procrank >> /sdcard/procrank.log
cat /proc/slabinfo >> /sdcard/slabinfo.log
cat /proc/pagetypeinfo >> /sdcard/pagetypeinfo.log


cat /sys/kernel/debug/kmemleak >> /sdcard/kmemleak.log
cat /proc/buddyinfo >> /sdcard/kmemleak.log
echo clear > /sys/kernel/debug/kmemleak
echo scan > /sys/kernel/debug/kmemleak

for i in `ls /d/ion` 
do 
echo $i Info >> /sdcard/iondump.log
echo ------------------ >> /sdcard/iondump.log
echo >> /sdcard/iondump.log
cat /d/ion/$i/* >> /sdcard/iondump.log
done

let count="count+1"
sleep 20
echo >> /sdcard/meminfo.log
echo >> /sdcard/meminfo.log
echo >> /sdcard/procrank.log
echo >> /sdcard/procrank.log
echo >> /sdcard/slabinfo.log
echo >> /sdcard/slabinfo.log
echo >> /sdcard/pagetypeinfo.log
echo >> /sdcard/pagetypeinfo.log
echo >> /sdcard/kmemleak.log
echo >> /sdcard/kmemleak.log
echo >> /sdcard/iondump.log

done

