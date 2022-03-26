---
layout: post
title: Put your hand to the work on Nemomobile
excerpt:
modified: 2021-12-30
author: jmlich
tags: ["Bugs"]
image:
  feature: ./2022-01-03-put-your-hand-to-the-work-on-nemomobile/broken-nemo.jpg
  teaser: ./2022-01-03-put-your-hand-to-the-work-on-nemomobile/broken-nemo.jpg
  thumb: ./2022-01-03-put-your-hand-to-the-work-on-nemomobile/broken-nemo.jpg

---

There is a number of bugs to solve. This is not prioritized list, but overview all visible issues. Some of them have some explanation, but solution must be found yet. Feel free to pick some issue, write fix, and make an pull request.

## Home screen and core components

* Landscape mode – with keyboard, application should be able rotate to landscape and back to the portrait mode [https://github.com/nemomobile-ux/main/issues/15](https://github.com/nemomobile-ux/main/issues/15)
* Infinite home screen – [https://github.com/nemomobile-ux/main/issues/27](https://github.com/nemomobile-ux/main/issues/27)
* [qtquickcontrols-nemo](https://github.com/nemomobile-ux/qtquickcontrols-nemo) should be migrated to cmake, QtQuick Controls 2, and Qt6
* multiplicative avahi icon – [https://github.com/nemomobile-ux/main/issues/26](https://github.com/nemomobile-ux/main/issues/26)

## Telephony

* Modem doesn’t work for me. setup-modem.sh fails and eg25-manager crashes
  [https://github.com/nemomobile-ux/main/issues/20](https://github.com/nemomobile-ux/main/issues/20)
* [glacier-contacts](https://github.com/nemomobile-ux/glacier-contacts/) is using QtPim which reports error when trying to delete or update contact. Next steps could include migration of QtPIM to KDE framework PIM.

## Messaging

* [glacier-mail](https://github.com/nemomobile-ux/glacier-mail) – application currently doesn’t work
* [glacier-accounts-settings](https://github.com/jmlich/glacier-settings-accounts) – teleptahy-gabble, telepathy-haze could allow connecting with facebook, telegram and other.

## Camera

* [setup-camera.sh](https://github.com/neochapay/nemo-device-dont_be_evil/blob/master/sparse/usr/bin/cameras_setup.sh) reports error and /dev/video0 is not created, glacier-camera application shows only black screen
* [libcamera](https://www.libcamera.org/) integration could probably bring better user experience. It does similar magic as a megapixels app do, but it is generic and usable by other hardware as well.

## Other applications bugs or missing features

* [glacier-gallery](https://github.com/nemomobile-ux/glacier-gallery/) – pinch to zoom doesn’t work
* glacier-gallery – tracker3 throws away data about removable devices (even it is root partition)
```
gsettings set org.freedesktop.Tracker3.Miner.Files removable-days-threshold 0
```
* [glacier-browser](https://github.com/nemomobile-ux/glacier-browser) – needs more user experience. Currently, It opens everything into new tab.
* [glacer-alarmclock](https://github.com/jmlich/glacier-alarmclock/) – proof of concept – how should be alarm triggered with timed?
* [glacier-calendar](https://github.com/nemomobile-ux/glacier-calendar/) – proof of concept – missing nemo-qml-plugin-calendar
* waydroid, flatpak - [keyboard](https://github.com/sailfishos-flatpak/pkg-flatpak-maliit-plugin) and others, desktop apps integration (keyboard, windows)

## Hardware support

It should be discussed for each device. What is missing for PinePhone?

* haptics feedback / vibra motor – the ngfd reports full memory of device. Less patterns in [configuration](https://github.com/nemomobile-ux/ngfd-settings-nemo/blob/master/data/plugins.d/ffmemless.ini) might help.
* nfc
* flash light - but where to add it?
```
echo 1 > /sys/class/leds/white:flash/brightness
```
* gps – geoclue gives data from geoip, but not from gps
* compass – it seems magnetometer gives some data via procfs, but [glacier-testtool](https://github.com/nemomobile-ux/glacier-testtool) shows only frozen needle. Same as [pinephone-compass](https://gitlab.com/lgtrombetta/pinephone-compass) aplication.