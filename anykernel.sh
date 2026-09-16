# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

properties() { '
kernel.string=Subsystem Restart Fix for OnePlus 3 (AOSPA)
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=OnePlus3
device.name2=oneplus3
device.name3=OnePlus3T
device.name4=oneplus3t
supported.versions=7.1.2
supported.patchlevels=
'; }

# boot install
BLOCK=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;

# import patching functions/variables - see for reference
. tools/ak3-core.sh;

ui_print " ";
ui_print "==================================================";
ui_print " made by bajader | github: @bajader               ";
ui_print "==================================================";
ui_print " ";
ui_print " INFO: This fix is specifically designed for      ";
ui_print " OnePlus 3 running AOSPA (Paranoid Android 7.3.1).";
ui_print " ";
ui_print " How it works:                                    ";
ui_print " Instead of replacing the kernel, this zip uses   ";
ui_print " AnyKernel3 to inject a custom initialization     ";
ui_print " script (init.subsys.rc) directly into the stock  ";
ui_print " boot.img ramdisk. Upon every boot, it writes     ";
ui_print " 'related' to the sysfs restart_level parameters  ";
ui_print " for all SoC subsystems. This prevents a full     ";
ui_print " Kernel Panic when the Wi-Fi module crashes,      ";
ui_print " forcing the system to softly restart only the    ";
ui_print " affected Wi-Fi module in the background.         ";
ui_print " ";
ui_print " NOTE: In theory, this fix might also work on     ";
ui_print " OnePlus 3T, but it has not been tested, so       ";
ui_print " there is no guarantee. Flash at your own risk!   ";
ui_print "==================================================";
ui_print " ";

# dump boot and extract ramdisk
ui_print "- Unpacking original boot image...";
dump_boot;

# inject our custom init.subsys.rc into the ramdisk's main init.rc
ui_print "- Injecting sysfs fix into the ramdisk (init.rc)...";
insert_line init.rc "import /init.subsys.rc" after "import /init.usb.rc" "import /init.subsys.rc";

# repack ramdisk then build and write image
ui_print "- Repacking and flashing patched boot image...";
write_boot;

ui_print " ";
ui_print "- Installation complete! Enjoy your stable Paranoid Android :)";
ui_print " ";
