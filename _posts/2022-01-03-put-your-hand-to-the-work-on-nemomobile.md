---
layout: post
title: Put your hand to the work on Nemomobile
excerpt:
modified: 2021-12-30
author: jmlich
tags: [main]
image:
  feature: ./2022-01-03-put-your-hand-to-the-work-on-nemomobile/broken-nemo.jpg
  teaser: ./2022-01-03-put-your-hand-to-the-work-on-nemomobile/broken-nemo.jpg
  thumb: ./2022-01-03-put-your-hand-to-the-work-on-nemomobile/broken-nemo.jpg

---

There is a number of bugs to solve. This is not prioritized list, but overview all visible issues. Some of them have some explanation, but solution must be found yet. Feel free to pick some issue, write fix, and make an pull request.

## Home screen and core components

* Landscape mode – with keyboard, application should be able rotate to landscape and back to portrait [https://github.com/nemomobile-ux/main/issues/15](https://github.com/nemomobile-ux/main/issues/15)
* Infinite homescreen – [https://github.com/nemomobile-ux/main/issues/27](https://github.com/nemomobile-ux/main/issues/27)
* qtquickcontrols-nemo should be migrated to cmake, QtQuick Controls 2, and Qt6
* multiplicative avahi icon – [https://github.com/nemomobile-ux/main/issues/26](https://github.com/nemomobile-ux/main/issues/26)

## Telephony

* Modem doesn’t work for me. setup-modem.sh fails and eg25-manager crashes
  [https://github.com/nemomobile-ux/main/issues/20](https://github.com/nemomobile-ux/main/issues/20)
* glacier-contacts is using QtPim which reports error when trying to delete or update contact. Next steps could include migration of QtPIM to KDE framework PIM.

## Messaging

* glacier-mail – application currently doesn’t work
* glacier-accounts-settings – teleptahy-gabble, telepathy-haze could allow connecting with facebook, telegram and other.

## Camera

* setup-camera.sh reports error and /dev/video0 is not created, native camera application returns black screen only
* libcamera integration could probably bring better user experience. It does similar magic as a megapixels app, but it is generic and usable by other hardware as well.

## Other applications bugs or missing features

* glacier-gallery – pinch to zoom doesn’t work
* glacier-gallery – tracker3 throws away data about removable devices (even it is root partition)
```
gsettings set org.freedesktop.Tracker3.Miner.Files removable-days-threshold 0
```
* glacier-browser – needs more user experience. Currently, It opens everything into new tab.
* glacer-alarmclock – proof of concept – how should be alarm triggered for timed?
* glacier-calendar – proof of concept – missing nemo-qml-plugin-calendar
* waydroid, flatpak, desktop apps integration (keyboard, windows)

## Hardware support

It should be discussed for each device. What is missing for PinePhone?

* haptics feedback / vibra motor – the ngfd reports full memory of device. Less patterns in configuration might help.
* nfc
* flash light
* gps – geoclue gives data from geoip, but not from gps
* compass – it seems magnetometer via procfs gives some data, but glacier-testtool shows only frozen needle