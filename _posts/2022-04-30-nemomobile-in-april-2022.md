---
layout: post
title: Nemomobile in April 2022
excerpt: What is new around Nemomobile in April? Release 0.9, CutiePi, reworked dialer, music, new ofono and more..
modified: 2022-04-30
author: jmlich
tags: ["Release", "Music", "Dialer", "CutiePi"]
image:
  feature: ./2022-04-30-nemomobile-in-april-2022/cutiepi-pinephone.jpg
  teaser: ./2022-04-30-nemomobile-in-april-2022/cutiepi-pinephone.jpg
  thumb: ./2022-04-30-nemomobile-in-april-2022/cutiepi-pinephone.jpg

---

The new release is here! Nemo is now running on [CutiePi tablet](https://cutiepi.io/). It is a device based on the Raspberry Pi
Compute Module. There have been a lot of changes in the backend, including ofono, glacier-home, and even the keyboard plugin.
End user applications are also constantly improving. The dialer has a new design. Music app has a lot of bug fixes and was
partially rewritten. The gallery app shows again pictures and has new video controls. We have updated some screenshots on
our website. There are some known bugs waiting for your fixes.

## New Device: CutiePi

CutiePi is a new device to play with. Bringing support for a new device is always a challenge. The designers of the CutiePi
were trying to reuse working perpherials. There is already an arm-profile for rpi4 in Manjaro which was almost ready for
CutiePi. It ships [Raspberry Pi 4 kernel](https://gitlab.manjaro.org/manjaro-arm/packages/core/linux-rpi4).

Required changes include boot parameters in [/boot/cmdline.txt](https://gitlab.manjaro.org/manjaro-arm/applications/manjaro-arm-tools/-/commit/d6eec1da0b97cab0287b1e38e93887afd85f85f8)
and replacement of [/boot/config.txt](https://github.com/nemomobile-ux/nemo-packaging/tree/master/cutiepi-kernel-config). The device configuration
required for booting into lipstick UI was already in [cutiepi-shell](https://github.com/cutiepi-io/cutiepi-shell/blob/master/opt/cutiepi-shell/kms.conf).
The [nemo-device-cutiepi](https://github.com/nemomobile-ux/nemo-device-cutiepi) repo was created to store those device specific configuration files.
It was forked from the PinePhone device, hence it still contain many leftovers not related to CutiePi.

After some [discussion](https://forum.manjaro.org/t/shipping-different-config-txt-and-cmdline-txt-for-cutiepi/109175) was merged related
patche to [manjaro-arm-tools](https://gitlab.manjaro.org/manjaro-arm/applications/manjaro-arm-tools/-/issues/53) and
[arm-profiles](https://github.com/manjaro-pinephone/arm-profiles/pull/7/files), so the image with phosh or plasma mobile
could be built. However, it still needs some [manual changes](https://forum.manjaro.org/t/phosh-on-cutiepi/109646).
The new device configuration is named rpi4-cutiepi.

CutiePi contains mpu6050 accelerometer and gyroscope. The driver is already in the kernel. It is necessary
to add [device tree overlay](https://github.com/cutiepi-io/cutiepi-drivers/blob/master/Gyro/mpu6050-i2c5-overlay.dts)
which describes that mpu6050 is connected via i2c bus. Its compiled binary was added together
with [config.txt](https://github.com/nemomobile-ux/nemo-packaging/blob/master/cutiepi-kernel-config/PKGBUILD).
The overlay contains mount matrix to define its physical orientation. This configuration still needs to be configured
for [sensorfw](https://github.com/nemomobile-ux/nemo-device-cutiepi/tree/master/sparse/etc/sensorfw/sensord.conf.d).

CutiePi is using standard OV5647 camera. Libcamera should work with that. Hopefully will.

The biggest issue is with MCU module. The module is connected via ttyS0. It provides information about battery and
power button. The cutie-pi shell is using its [own daemon](https://github.com/cutiepi-io/cutiepi-middleware) to
communicate with MCU and to provide DBus interface to the rest of the operating system. The `/sys/class/power_supply/` interface
should be used instead. Adjusting system daemons to work with those special daemons leads to extra downstream patches we
don’t want to maintain. Luckily CutiePi developers plans to create necessary drivers. Related
[cutoff](https://github.com/nemomobile-ux/nemo-packaging/blob/master/cutiepi-cutoff/PKGBUILD) application was
already packaged, but it seems that the latest [mcu firmware](https://github.com/cutiepi-io/cutiepi-firmware/commit/cfc2b284f2541754f0e19807aade8ff66bb6abff) needs
to be flashed first.

Due to missing integration of power button, the waking up from sleep mode may require hitting the ESC key on keyboard attached via USB.

## Backend

We are moving forward in upstreaming our changes into [Manjaro](https://github.com/manjaro-pinephone/arm-profiles/). We are
not using our specific arm-profiles anymore, so the repository was deleted to avoid confusion.

The qtquickcontrols-nemo was [migrated to cmake](https://github.com/nemomobile-ux/qtquickcontrols-nemo/pull/31) which
can bring more flexibility and it is a small step forward in the direction of Qt 6.

[Ofono was upgraded](https://github.com/nemomobile-ux/nemo-packaging/commit/b0e052a517e1ebce7936ee97b0b32566ebeaf183) to 1.34
with SailfishOS plugins. However, it is hard to evaluate if everything works properly. Please report how it works on your
phone with your provider. Sergey is using stock modem firmware, Jozef is using [Biktorgj](https://github.com/Biktorgj/pinephone_modem_sdk/releases)‘s 0.6.2.

Home screen search [feature wasn’t showing an application icon](https://github.com/nemomobile-ux/glacier-home/commit/1e939bd031384885a1c8a19fbe61f62656564e75).
There is still an issue with ListView component size and running of items.

Glacier-home now renders [reboot and poweroff on top](https://github.com/nemomobile-ux/glacier-home/commit/d341ab2f6ba37430c2e4c94aac32d2248ca3da3e).
Other applications shouldn’t overlap it anymore.

Nemo keyboard plugin is [now showing currently selected layout](https://github.com/nemomobile-ux/maliit-nemo-keyboard/commit/6cb7900e34dd83336d2679a3f3204c2877e7cb6f).
Unfortunately, the inspection of the code shows that use of the accent characters is not implemented at all. It would be also interesting
to add the accent modifiers keys which adds `ˇ` and/or `´` to regular letters.

The [glacier-settings-accounts](https://github.com/nemomobile-ux/glacier-settings-accounts) was added to regular builds and extended with gmail account.
This settings plugin allow to us work with signond to manage email and social network in a single place. It will appear in settings app once is installed.
It will be included in the default application set once ready to use.

The glacier-settings interface for time configuration wasn’t connected to qml-plugin-system-settings (date settings was).
This is now [fixed](https://github.com/nemomobile-ux/glacier-settings/pull/124), but it turned out that timed daemon cannot
pass the settings to connman:

```
timed-qt5[21598]: WARNING: Failed to call net.connman.Clock.SetProperty: The name net.connman was not provided by any .service files
```
## Applications

The translations are maintained using *.ts files and transifex. The lupdate based export doesn’t cover translations of application titles
in *.desktop files. We are [cheating a little](https://github.com/jmlich/translate-desktop/blob/master/extract_localnames.sh). The Name
field is extracted from *.ts file using xmllit. We are using the application title for that. This approach was unified across glacier apps.
The string can be usually found in main.cpp and it looks like this:
```
app->setTitle(tr("Dialer"));
```

We are using the QtQuick Compiler for most of applications now. It brings some speed. On the other hand almost all URLs needed to be changed.
It depends if the URL was absolute or relative previously and if the image was moved into resource as well. The QtCreator can nicely recognize
the qrc as part of the project. However, some qml files (usually api) are not included in qrc. This may lead to confusion because some files
are not visible. See screenshot. Additionally, it is necessary to recompile application to change single qml file, hence debugging on
the device needs a little more work than before.

![](/images/2022-04-30-nemomobile-in-april-2022/qtcreator-screenshot.png){: height="600"}


Dialer application [was reworked](https://github.com/nemomobile-ux/glacier-dialer/commit/a4916b03596bfbe1df04f54e03b400e3425175a6) and has
a fresh look and feel. It seems there is some bug in nemo-qml-contacts-plugin. The contact name and avatar is not loaded and not shown
on Incoming/Outgoing call page.

![](/images/apps/dialer-180.png)

There were a number of bugs in Music application. There was an issue with unwanted removing of ID3 tags from file meta data. Starting replay
of the song through the playlist started a different song. It looks the same on first impression, but about half of it was rewritten.

Gallery wasn’t working due to change in SPARQL queries in [qtdocgallery](https://github.com/sailfishos/qtdocgallery/commit/71a4ac1c7e9cf28a234ab7f8c4246b4b1e5797ed).
It is likely those changes will be available in the new tracker. We have reverted it to the previous commit until tracker package is updated.
The [video player](https://github.com/nemomobile-ux/glacier-gallery/pull/34) part got video seek feature. 
The [Big Buck Bunny](https://peach.blender.org/) is quite standard to file for video playback demoing and/or benchmark.
Unfortunately, even the 480p version is not playing fluently. 

![](/images/apps/gallery-video-180.png)

Sizing of Calendar and Alarm clock elements was adjusted a little bit to improve its usability on PinePhone screen. 

## Housekeeping

We have updated screenshots on our website to give you better idea of what nemo looks like. Tags in blog posts could be used for search. 

![](/images/2022-04-30-nemomobile-in-april-2022/web-screenshots.png){: width="100%"}

## Known issues

Some package have dependencies, so non graphical feedback daemon (ngfd) and transitively glacier-dialer don’t work on the PinePhone.
It is not clear if it should a be dependency of ngfd or per-device dependency. Workaround is to install the package manually:

```
pacman -S gst-plugins-good
```

There is some issue with glacier-devicelock. It seems the application creates /home/manjaro/.config/glacier-devicelock/ with root
as its owner. It includes directory .config which effectively prevents storing of configuration to other applications (including
glacier-settings). Workaround is to fix file ownership:

```
chown manjaro.users -R /home/manjaro/.config
```

## Release

The images for version 0.9 are available at [img.nemomobile.net](https://img.nemomobile.net/). See [installation](/installation/) section for more details.