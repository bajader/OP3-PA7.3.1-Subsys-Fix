# OP3 AOSPA Subsystem Restart Fix

A small flashable zip that fixes the random reboots (Kernel Panic) caused by Wi-Fi crashes on Paranoid Android (AOSPA) 7.3.1 for the OnePlus 3.

## Why does it reboot?
On the stock PA 7.3.1 kernel, the Wi-Fi subsystem (CNSS) driver has `restart_level` set to `system`. Because of this, every time the Wi-Fi firmware crashes, the whole SoC resets. The phone just reboots.

## How to fix it
Compiling a custom kernel for a 2017 ROM using my M1 MacBook Air was a pain in the ass, ended up compiling a kernel that bricked my device. So instead of touching the kernel binary, this zip just edits the ramdisk.

It uses [AnyKernel3](https://github.com/osm0sis/AnyKernel3) to inject `init.subsys.rc` into your `boot.img` during TWRP installation. On every boot, it simply writes `related` to the sysfs `restart_level` for all subsystems. 
If the Wi-Fi module crashes now, only the Wi-Fi subsystem restarts in the background. The OS stays up.

## Installation
1. Download `OP3-PA7.3.1-Subsys-Fix.zip` from Releases.
2. Boot into TWRP.
3. Flash your ROM and GApps (if clean flashing).
4. Flash the fix zip.
5. Reboot.

## Troubleshooting / Clean Install Guide
If it still acts up, you might need a proper clean wipe:
1. Flash stock **OxygenOS 3** via MSM Download Tool.
2. OTA update all the way to **OxygenOS 4.5.1**.
3. Unlock bootloader, flash TWRP.
4. In TWRP, go to Wipe -> **Format Data**.
5. Flash PA 7.3.1 -> GApps -> `OP3-PA7.3.1-Subsys-Fix.zip`.

## Compatibility
- **Tested:** OnePlus 3 (AOSPA 7.3.1)
- **Untested:** OnePlus 3T (flash at your own risk)

## Credits
- AnyKernel3 by [osm0sis](https://github.com/osm0sis/AnyKernel3)
- Crashlog analysis & script generated using Claude Opus 4.6 and Gemini 3.1 Pro
