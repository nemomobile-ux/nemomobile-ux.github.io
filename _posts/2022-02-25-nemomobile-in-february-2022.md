---
layout: post
title: Nemomobile in February 2022
excerpt: 
modified: 2022-02-25
author: jmlich
tags: ["GPS", "USB moded", "Alarm clock"]
image:
  feature: ./2022-02-25-nemomobile-in-february-2022/gps.jpg
  teaser: ./2022-02-25-nemomobile-in-february-2022/gps.jpg
  thumb: ./2022-02-25-nemomobile-in-february-2022/gps.jpg

---

We are trying to stabilize nemo packages. There were some improvements in GPS and USB modes.
The Finger print authentication was added. There are some new applications such as calendar,
alarm and welcome screen. You can take a look at how to run SailfishOS apps on Nemo and test
halium devices. We now have Polish translations.

## Stabilization of packages

The aim to is provide stable releases based on tagged versions. At the same time we keep some
packages based on the latest and greatest master branch. Here is a list of packages which was
[renamed](https://pastebin.com/Z1nmMaEa) (i.e. moved to stable). Next step is to make sure
everything is building together with Manjaro repositories. This means update of nemomobile
settings in [manjaro-arm-tools](https://gitlab.manjaro.org/manjaro-arm/applications/manjaro-arm-tools/-/issues/51).
We had an issue with missing autologin group for manjaro user (default user), which was first
solved by an ugly hack, now [a proper fix has been merged](https://gitlab.manjaro.org/manjaro-arm/packages/community/pinephone-post-install/-/merge_requests/3),
but workaround is probably still present in our code.

This means also that stable version should be updated after some period. About 20 packages
were really updated this month. For example [commhistory-daemon](https://github.com/nemomobile-ux/nemo-packaging/commit/0bca5d6ef3b22c13a2d4897c2cef268a2ce5bed2)
or [system-settings-plugging](https://github.com/nemomobile-ux/nemo-packaging/commit/e8651dc3f28945e7dfe2091676cb5fd6e56780b9).

The translation continues. I forgot to mention that last month we added a Polish translation.

There is also some work [on finger print authentication](https://github.com/nemomobile-ux/nemo-qml-plugin-fingerprint)
either with PinePhone fingerprint cover or VollaPhone or other halium based devices. Open source
software is great because improvements in NemoMobile affects also other distributions. There were related [fixes in Plasma](https://invent.kde.org/plasma/plasma-workspace/-/merge_requests/1443/diffs).

## GPS

A lot of debugging of GPS was done. It required manual update of [/etc/geoclue/geoclue.conf](https://pastebin.com/raw/v87LY7Fb)
for tests, testing with gpsmon and new upstream version of geoclue. There was [a typo in configuration](https://github.com/neochapay/nemo-device-dont_be_evil/commit/c3a578faa389508decb61a1cd7daa61649476da0).
There were missing items in [geoclue-gpsd-provider](https://github.com/neochapay/geoclue-provider-gpsd3). Additionally,
It turned out that geoclue doesn’t provide the number of satellites. The [geoclue2 is now optional](https://github.com/nemomobile-ux/glacier-home/commit/2657d648da8de07df55be9eebb19004291ab5358)
for glacier-home. I guess Sergey will continue in summer with that ;-D

## USB-moded

The usb-moded configuration was fixed, hence the daemon should work now. The ini file was [removed](https://github.com/nemomobile-ux/nemo-packaging/commit/df155f91eeb5c9097815268c0cc614f34d7d8a99).
There was some missing configuration or module in kernel. Even g_ether module was missing.

## Applications

The NemoMobile “core” is starting to be stable and providing enough interfaces for end
user applications. Most of applications are still either missing, or have very few features.
The basic functionalities such as alarm clock are not ready. However, we are working on it.

Here is a short demonstration of alarm clock application. It looks like homework for a high
school student, but it actually has some tricky parts. First, the alarm should wake up the
device from deep sleep mode. Second, it shouldn’t prohibit entering deep sleep mode. Luckily,
that part should be solved by timed daemon originally developed for Maemo. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/W2wTbajeqVo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Communication with the daemon is done via dbus. Make sure you are running daemon `systemctl --user status timed-qt5`
and make sure that daemon is not in ACT DEAD state. You can use [unfreeze script](https://github.com/sailfishos/timed/blob/master/tests/ta_voland_service/alarms_unfreeze.sh)
for that purpose. The integration into OS is still to be done.

The glacier-calendar and [nemo-qml-calendar-plugin](https://github.com/nemomobile-ux/nemo-packaging/commit/9c8c66172f80f361684bc0e8a587ef51ce8a09c2)
made it finally into nemo-packaging. The application it self was also [improved a little bit](https://github.com/nemomobile-ux/glacier-calendar/pull/9).
The month view shows now the number of events per day. It allows to choose day and view its events. The agenda view was also a little bit reworked.
It is using ListViewItemWithActions now and allows deletion of the event. There is still a lot of work around.

<iframe width="560" height="315" src="https://www.youtube.com/embed/SBw0ZnFlMgQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

There is also some progress on first boot application called [glacier-welcome](https://github.com/nemomobile-ux/glacier-welcome).
This application should help with initial configuration. Configuration of password, language, wifi, timezone,
and others as is usual with other mobile operating systems.

## Improvements to try

Some people want to run Silica API in Nemo and other APIs to be able to run SailfishOS applications. This could be achieved
by re implementation of closed source parts. Erik made first steps in its [implementation](https://github.com/cutie-shell/qml-module-cutie).
He is using it within Cutie-shell with also runs on top of Manjaro. The [PKGBUILD](https://github.com/cutie-shell/cutie-packaging-manjaro/blob/master/qml-module-cutie/PKGBUILD)
is also available. He was trying to run the [nanofiles](https://github.com/Michal-Szczepaniak/nanofiles) application. You definitely
need to compile [libsailfishosapp](https://github.com/sailfishos/libsailfishapp) and mapplauncherd which we recently removed from Nemo If you want to try it.

Erik also reported the issue with saved networks in glacier-settings. The section basically doesn’t show anything. It turned out,
that libconnman-qt wrapper tries to provide Saved networks. Upstream connman doesn’t export this list, but SailfishOS fork does.
Erik suggested [replacing saved list with favorite list](https://pastebin.ubuntu.com/p/j4dDR3MKFP/). In this case we suggest sending
patches to upstream. Probably could be a good idea to provide both lists. We may include that patch yet or its variant, but I want
to understand its behavior first.

Erik was speaking about some changes in halium images. The images generated by CI are available on [github](https://github.com/manjaro-libhybris/image-ci/releases).
The installation should be easier now. The zips can be sideloaded via TWRP. I am not sure how different that is from the installation instructions described
in previous post. Erik tested it on volla phone (ygdrassil) and sargo, so it should boot at least.
