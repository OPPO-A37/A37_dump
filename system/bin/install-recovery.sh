#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:27215148:981cd140bf12625bb0148c6e0b93a06020f90bf3; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:22050088:d00fa3b46dcadcffcb61b94c2adc4199bb9be377 EMMC:/dev/block/bootdevice/by-name/recovery 981cd140bf12625bb0148c6e0b93a06020f90bf3 27215148 d00fa3b46dcadcffcb61b94c2adc4199bb9be377:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
