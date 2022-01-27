---
layout: post
title:  NemoMobile in January/2022
excerpt: FOSDEM talk, PinePhone Pro image, PineTab image, Release 0.7.1
modified: 2022-01-27
author: jmlich
tags: [main]
image:
  feature: ./2022-01-27-nemomobile-in-january-2022/fosdem-talk-980.jpeg
  teaser: ./2022-01-27-nemomobile-in-january-2022/fosdem-talk-620.jpeg
  thumb: ./2022-01-27-nemomobile-in-january-2022/fosdem-talk.jpeg

---

This month we invite you to watch our FOSDEM talk. There have been some changes around PineTab and PinePhone Pro. We have released 0.7.1. The next big release is slowly coming closer and a lot of smaller changes have been made.

## FOSDEM 2022

For many open source enthusiasts [FOSDEM](https://fosdem.org/) is one of the most important
events in a year. This year the conference will be again online. It will be the same as
format last year and similar to many other conferences. The schedule is huge as always,
but if you look into [FOSS on Mobile Devices devroom](https://fosdem.org/2022/schedule/track/foss_on_mobile_devices/),
you will find the talk [Nemomobile – Bringing freedom to mobile](https://fosdem.org/2022/schedule/event/mobile_nemomobile/).
It will be at Saturday 5th February at 10:50 CET.

## Release 0.7.1

New minor release was [published](https://twitter.com/neochapay/status/1484525327795855365).
We are trying to stabilize NemoMobile, so there have been many changes to the way how packages
are built. Previously, the latest and greatest commit from the master branch were used. Now,
the packages are using tagged version.

Upgrades will probably bring some conflicts. Prefer a clean installation if you want to be sure about package status.

Probably the most important fix is adding [manjaro user into autologin group](https://gitlab.manjaro.org/manjaro-arm/applications/manjaro-arm-tools/-/issues/50). Without that settings lightdm doesn’t start lipstick (NemoMobile compositor).

[https://img.nemomobile.net/2022.05/](https://img.nemomobile.net/2022.05/)

## PinePhone Pro and PineTab

The release 0.7.1 also includes an image for the PinePhone Pro. Please
be careful with flashing not to brick your device. We recommend only
[removal of preinstalled AOSP](https://wiki.pine64.org/wiki/PinePhone_Pro_Developer_Edition#Nuking_the_factory_AOSP_installation)
and use Nemo only from SD card.

In order to get PinePhone Pro working, the [uboot was updated](https://github.com/nemomobile-ux/uboot-pinephonepro/commit/ffd8a06303299d39afca8ffbdfe49ff514363ad6).
It turned out that new version of manjaro-arm-tools and arm-profiles
was needed. Make sure to update those packages if you build your own images.

![](/images/2022-01-27-nemomobile-in-january-2022/nemo-on-pinephonepro.jpg){: height="400"}

Similar, there were some issue with [uboot configuration for PineTab](https://gitlab.manjaro.org/manjaro-arm/packages/core/uboot-pinetab/-/commit/37203c5871b1c2c2ee39935a4d8515a156517a98). The
PineTab now boots. The kernel is loaded, but lipstick cannot find the panel
which means that it doesn’t boot into UI.

## Other changes

The libhybris build on aarch64 was fixed with [right change of ifdef](https://github.com/libhybris/libhybris/pull/502/commits/d700b48c525d99dd3b9fff4cb2c24e75cfd858bd).

[Sending sms](https://github.com/nemomobile-ux/nemo-packaging/blob/master/telepathy-mission-control/0003-McdSlacker-Revert-use-of-org.gnome.SessionManager-in.patch) and [sms notifications](https://github.com/nemomobile-ux/nemo-packaging/blob/master/telepathy-mission-control/PKGBUILD#L40) was fixed.

Work on migration to Qt6 has started. The libglacierapp have now [qt6 branch](https://github.com/nemomobile-ux/libglacierapp/tree/qt6).
If you want to help with porting of QtQuick.Controls.Nemo to QQC2 you can start with [QtWS talk or Richard Gustavsen](https://resources.qt.io/on-demand/styling-a-qt-quick-controls-desktop-application-user-interface-qtws21).

## Bug to start with

There was [a little](https://github.com/nemomobile-ux/glacier-home/pull/198) progress with the [infinite home screen issue](https://github.com/nemomobile-ux/main/issues/27), but it still needs some love:

![](/images/2022-01-27-nemomobile-in-january-2022/infinite-scrolling-screenshot.png){: height="400"}
