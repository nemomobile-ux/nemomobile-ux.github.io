---
layout: post
title: Nemo for PinePhone v0.8
modified: 2020-04-27
author: neochapay
tags: ["PinePhone", "Release"]
image:
  teaser: pinephone-620.jpg
  thumb: pinephone.jpg
---

# Image of Nemo with Glacier UX for PinePhone

![](https://sun9-41.userapi.com/c200620/v200620091/3a74e/sbKlDMbA0eA.jpg)

# Links for download
[Version 0.8 rootfs](https://yadi.sk/d/VAbtKV-Hnql60g)

[Version 0.8 2gb sdcard image](https://yadi.sk/d/8oSZp-frGidscw)

# How to flash

A SD card with a capacity of 2GB or higher is necessary to flash Nemo Mobile.

## Prepare SD card

Use GParted or any other tool to create the following ext4 partitions:

* boot: holds the mainline kernel image and device tree files
* data: holds the Nemo root filesystem

GParted will ask you to leave the first MB free of the SD card when creating the first partition, this is correct. It'll be used to store the U-Boot bootloader.

_Note: Make sure you have a `msdos` partition table! If you don't, flashing U-Boot will make the partition table unusable (for example in case of GPT)!_

## Burn U-Boot to your SD card

Copy the compiled U-Boot bootloader to the first sector on your SD card: `sudo dd if=u-boot-sunxi-with-spl.bin of=/dev/sdX bs=8k seek=1`.

## Unpack root filesystem

Unpack the downloaded archive into the data partition of the SD card.
Afterwards, copy all the files from the `/boot` directory into the boot partition of the SD card.

# Known bugs

* Voicecalls don't work
* Sound doesn't work
* Camera doesn't work

# How to contribute

Problems with all user-interface components should be reported directly to those projects on Github.
For example, a problem with the dialer can be reported to [https://github.com/nemomobile-ux/glacier-dialer](https://github.com/nemomobile-ux/glacier-dialer).

Any hardware problems should be reported to [https://github.com/neochapay/nemo-device-dont_be_evil](https://github.com/neochapay/nemo-device-dont_be_evil).

# Chat

* Telegram: [https://t.me/NemoMobile](https://t.me/NemoMobile)
* Matrix: [https://matrix.to/#/#nemomobile:matrix.org](https://matrix.to/#/#nemomobile:matrix.org)
