---
layout: post
title: Nemomobile on Volla Phone
excerpt: How to install NemoMobile on Volla Phone (yggdrasil)
modified: 2021-12-08
author: jmlich
tags: [main]
image:
  feature: ./2021-12-08-nemomobile-on-volla-phone/20211119_004-1-1024x577.jpg
  teaser: ./2021-12-08-nemomobile-on-volla-phone/20211119_004-1-1024x577.jpg
  thumb: ./2021-12-08-nemomobile-on-volla-phone/20211119_004-1-1024x577.jpg
---

Some time ago Erik posted a link to NemoMobile images for Volla Phone. I would like to describe exact step by step
instructions how to install it, but it is not as simple as it might seem. In addition, I'm not entirely sure of
the initial conditions, because halium relies on parts of Android to remain on the phone. 

## Initial state

First, I want to be sure that I am able to get into initial state. The SP Flash tool is used for that purpose.
With this tool you can do phone recovery even if it is stuck in an infinite loop of restarts. So far, 
it has worked for me, thank God, always. First, I set the path `/home/jmlich/gs290/ubuntu-touch-yggdrasil-ota15-flashtool/MT6763_Android_scatter.txt` and
press Download button. I don't usually use any other options. However, once I used an additional Firmware upgrade option. Then I connect the turned off
device to USB and wait. In the status bar, you can see the progress of the flashing. The check mark appears when finished.
Then the phone can be disconnected and operating system boots.

![](/images/2021-12-08-nemomobile-on-volla-phone/Screenshot-at-2021-12-05-09-45-38-1024x677.png){: width="400"}
![](/images/2021-12-08-nemomobile-on-volla-phone/Screenshot-at-2021-12-05-09-49-51.png){: width="400"}

## Installation of TWPR

The TWPR is tool for recovery of the operating system. The abbreviation stands for Team Win Recovery Project.
Honestly, I am not sure what exactly it does and why is not used the default recovery system or just fastboot with flash parameter. In any case, I couldn't do it without it.

To switch to recovery mode, you need to turn on the phone by holding down the power button and the volume up
button at the same time. Unfortunately, the behavior is not always clear or at least I have not been able to
figure out what I am doing differently. Sometimes a basic menu appears. It has the following options: recovery,
fastboot, and normal boot. Sometimes, however, it seems that the menu is hidden behind the Volla logo. 
It works exactly the same, you just don't see what you choose. 

![](/images/2021-12-08-nemomobile-on-volla-phone/20211119_013-3-577x1024.jpg){: height="500"}
![](/images/2021-12-08-nemomobile-on-volla-phone/20211119_017-4.jpg){: height="500"}

If you do not see what you are selecting, sometimes you select the recovery option and boot to the default recovery system. 

![](/images/2021-12-08-nemomobile-on-volla-phone/20211119_014-2.jpg){: height="500"}


Then you can use `adb reboot bootloader` to boot into flash mode and load twrp.
Unfortunately, for some reason, I couldn't start twrp without flashing it. The adb boot twrp.img command didn't worked.

```
adb reboot bootloader
fastboot flash recovery twrp.img
```

Then the twrp itself was waiting for me. The welcome screen with the logo appeared first, then the warning was acknowledged, and finally the twrp was started. 

![](/images/2021-12-08-nemomobile-on-volla-phone/20211119_011-577x1024.jpg){: height="500"}
![](/images/2021-12-08-nemomobile-on-volla-phone/20211119_002-577x1024.jpg){: height="500"}
![](/images/2021-12-08-nemomobile-on-volla-phone/20211119_003-scaled.jpg){: height="500"}


## Installation of NemoMobile

The twpr is required to be started, but all commands are entered via terminal on
your computer. It copies the files into the device and that's it.

```
[root@jmlich-dell nemo]# adb push android-rootfs.img /data
android-rootfs.img: 1 file pushed, 0 skipped. 9.2 MB/s (575799296 bytes in 59.451s)
[root@jmlich-dell nemo]# adb push Manjaro-ARM-nemomobile-yggdrasil-halium9-aarch64.img /data/rootfs.img
Manjaro-ARM-nemomobile-yggdrasil-halium9-aarch64.img: 1 file pushed, 0 skipped. 9.5 MB/s (4294967296 bytes in 432.360s)
[root@jmlich-dell nemo]# adb reboot bootloader
[root@jmlich-dell nemo]# fastboot flash boot boot.img
< waiting for any device >
Sending 'boot' (13798 KB)                          OKAY [  0.928s]
Writing 'boot'                                     OKAY [  0.184s]
Finished. Total time: 1.139s
[root@jmlich-dell nemo]# fastboot reboot
Rebooting                                          OKAY [  0.001s]
Finished. Total time: 0.051s
```

Sergey noted that it might still be necessary to wipe device in twpr.

What can NemoMobile on Volla Phone do? Not much! The status is more or less the same or even worse as on the PinePhone. I was able to connect to
the internet through the Wifi and to update packages. Neither GSM, nor VoiceCalls, nor Internet connection worked. Accelerometers (sensorfw)
probably needs different configuration. I have explored filesystem for a while, but then I returned my daily driver back to previous OS.
First test was succesful!

![](/images/2021-12-08-nemomobile-on-volla-phone/20211118_001-scaled.jpg){: height="500"}

Disclaimer: this blog post describes my own experience only. There is no guarantee that you will manage to do the same. Think twice before you brick your device.
