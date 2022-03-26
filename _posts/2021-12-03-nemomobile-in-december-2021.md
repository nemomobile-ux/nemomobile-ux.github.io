---
layout: post
title: Nemomobile in December/2021
excerpt: Halium devices, PineTab, PinePhone/+Pro, Package manager, Weather, Pure maps, Fixed DPI, improved voice calls, SMS, and more..
modified: 2021-12-03
author: jmlich
tags: ["Package manager", "Weather", "Pure Maps", "Dialer", "Messages", "Release"]
image:
  feature: ./2021-12-03-nemomobile-in-december-2021/nemo-on-volla2-980.jpg
  teaser: ./2021-12-03-nemomobile-in-december-2021/nemo-on-volla2-620.jpg
  thumb: ./2021-12-03-nemomobile-in-december-2021/nemo-on-volla2.jpg
---
Last month NemoMobile 0.7 was released. After that release some progress was made with sending of SMS and voice calls. There was nice progress in package manager and there is a new weather application. We have also seen NemoMobile on many new devices.

## Release 0.7

Shortly after November post version 0.7 was released. There were some articles
on [itsfoss.net](https://www.itsfoss.net/distribution-kit-for-mobile-phones-nemomobile-0-7-released), 
[opennet.ru](https://www.opennet.ru/opennews/art.shtml?num=56207), [linux.org.ru](https://www.linux.org.ru/news/pda/16654020)
and [root.cz](https://www.root.cz/zpravicky/bylo-vydano-nemomobile-0-7-operacni-system-pro-mobily-postaveny-na-manjaru/).
We will be happy if you make some noise in your local communities as well.

Beware, credentials are different:

```
root/root
manjaro/manjaro
```

## Package Manager

The 0.7 version includes updated package manager, but there were some changes after release. It allows package updates,
installation, and removal. It is using libpamac. The interface is separated in own module, thus it could be replaced e.g. by apk in postmarketOS.

<iframe width="560" height="315" src="https://www.youtube.com/embed/L6T9YrD4YP4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<iframe width="560" height="315" src="https://www.youtube.com/embed/ypxTJtwqHqo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Weather application

There is a new application called [glacier-weather](https://github.com/nemomobile-ux/glacier-weather/). As
data source [openweathermap](https://openweathermap.org/) is used. The application is fork
of [qt weatherinfo example](https://doc.qt.io/qt-5/qtpositioning-weatherinfo-example.html).

![](/images/2021-12-03-nemomobile-in-december-2021/IMG_20211120_105023-500.jpg){: height="500"}


## Translations progress

Some new translations are needed since many things are still changing. Only 🇨🇿 Czech and 🇷🇺 Russian language are 100% translated.
🇩🇪 German, 🇫🇮 Finish, and 🇵🇱 Polish language are at 80% of translated strings. Next is the 🇫🇷 French translation with 66% and 🇳🇱 Dutch 
with 30% . You can improve your language easily via [transifex](https://www.transifex.com/nemomobile/public/). New languages could be added as well.

## Pure Maps

The pure maps doesn’t have user interface based on [Qt Quick Controls Nemo](https://github.com/nemomobile-ux/qtquickcontrols-nemo), but it is compiled with Qt Quick Controls 2.0 and available in nemo repositories.

To make it work it is required to update geoclue configuration file. The [pull request](https://gitlab.freedesktop.org/geoclue/geoclue/-/blob/master/data/geoclue.conf.in#L13) was already merged,
but it has not been released yet. Geoclue can provide position from GeoIP and IP address. The other source is gpsd, but it probably needs some settings.

<iframe width="560" height="315" src="https://www.youtube.com/embed/OYacHR0Z1AI" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Voice call with audio and SMS

There were some progress in voice calls with audio. To reach the voice calls the pulse audio support was reworked. Some pulse audio
related [packages were removed](https://github.com/nemomobile-ux/nemo-packaging/commit/37d6f17c556513beb6f7f639833a6fc8ff8db2be).
The [volume Up/Down step](https://github.com/nemomobile-ux/glacier-home/commit/4bb63bb7fbbbea3b93260c57c7ea8230ea433d9f) was set to 10.
It may need audio profiles from manjaro-tweaks (not sure if it is included right now).

<iframe width="560" height="315" src="https://www.youtube.com/embed/HegimsdVw_o" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The [call duration counter](https://github.com/nemomobile-ux/glacier-dialer/commit/40f35138d4281f1d6a8f46d41fff40dee3e709f7) was also fixed.

There were also some changes in glacier-messages. It looks like it is possible to send and receive messages now. Make sure mission-control daemon works correctly, a restart might help sometimes.

![](/images/2021-12-03-nemomobile-in-december-2021/glacier-messages-500.jpg){: height="500"}
![](/images/2021-12-03-nemomobile-in-december-2021/glacier-messages2-500.jpg){: height="500"}


The Nemo configuration for ngfd (Non Graphical Feedback Daemon) were added. The ngfd-plugin-native-vibrator package were created to allow vibrations, but there is still missing something, because vibration still doesn’t work.

## Home, Settings, and Controls

The [DPI for non glacier-applications](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/2719a63a54abc3222176fcb025b5561489d97bf7) such
as telegram and fingerterm was fixed. The [blurred transparent background](https://github.com/nemomobile-ux/qtquickcontrols-nemo/pull/20) patches from Eric was merged.

The glacier-home is using [listview instead of pager](https://github.com/nemomobile-ux/glacier-home/commit/ee66e029b036ce5a6161303816edbf68883d3ba0) which means
that it is not possible to scroll from notifications running applications directly, but it is necessary to flick via application launcher. Previous
implementation had some issue on PineTab.

The control center was moved to left-side panel (notification page).

The [media controls on lockscreen](https://github.com/nemomobile-ux/glacier-home/commit/e67d6f4b59e8457368461711040af98a486fff91) is shown now only when media player is running.

Additionally, the it is possible to [set theme via settings](https://github.com/nemomobile-ux/glacier-settings/commit/f6dd55024d026c52f6d8c6d317eac78030092dee) application.
The [theme](https://github.com/nemomobile-ux/qtquickcontrols-nemo/blob/master/src/styles/themes/glacier_black.json) allows to set base colors, font element sizes and spacing.

![](/images/2021-12-03-nemomobile-in-december-2021/lockscreen-play-500.jpg){: height="500"}
![](/images/2021-12-03-nemomobile-in-december-2021/volla-background-qtquick-nemo-500.jpg){: height="500"}

## Website

The landing page was reduced and in my opinion also simplified to make life easier for newcomers. You can compare previous and current version:

![](/images/2021-12-03-nemomobile-in-december-2021/web1-500.jpg){: height="500"}
![](/images/2021-12-03-nemomobile-in-december-2021/web2-500.jpg){: height="500"}

After some feedback the [installation in Virtualbox](https://github.com/nemomobile-ux/nemomobile-ux.github.io/commit/b32dc9fe6b4e9b7256e6f743e03d23535d8465a7) description was improved also.

## Devices

Erik, Luka, and others managed to run NemoMobile on new devices. They managed to run nemo on **Volla Phone** (yggdrasil), **Pixel3** (sarge), and **Xiaomi mi9t Pro**. Current status is Proof of Concept. The installation images are changing almost every day and are build manually by them. It seems many features 4g and Wifi or even Waydroid is working.

The way to run it is following. Put image to /data/rootfs.img with recovery and flash halium-boot.img to boot with fastboot

* boot to twrp
* adb push android-rootfs.img /data
* adb push rootfs.img /data

The development is done around [manjaro-libhybris](https://github.com/manjaro-libhybris/) repository and [@manjaroonhalium](https://telegram.me/manjaroonhalium) telegram group.

![](/images/2021-12-03-nemomobile-in-december-2021/4g-on-pixel-500.jpg){: height="500"}
![](/images/2021-12-03-nemomobile-in-december-2021/nemo-google-pixel-500.jpg){: height="500"}
![](/images/2021-12-03-nemomobile-in-december-2021/nemo-google-pixel-google-sargo-500.jpg){: height="500"}
![](/images/2021-12-03-nemomobile-in-december-2021/volla-flashing-wipe-helped-400.jpg){: height="400"}
![](/images/2021-12-03-nemomobile-in-december-2021/Xiaomi Mi 9T Pro-400.jpg){: height="400"}
![](/images/2021-12-03-nemomobile-in-december-2021/xiaomi-waydroid-400.jpg){: height="400"}


There are images for **PineTab**, but it seems that they don’t work right now. You can help with debugging if you have a PineTab and expertise.

It seems the **PinePhone Pro** images could be build by manjaro-arm-tools and/or in gitlab CI.

## Bug to start with

As always there are many issues to fix. Here is a tip where to find interesting one:

The application launcher sometimes suffers by [duplication of launchers](https://github.com/nemomobile-ux/main/issues/26). In some circumstances the Avahi Zeroconf launcher is duplicated after every reboot.

<iframe width="560" height="315" src="https://www.youtube.com/embed/KV4nfhZ0xLo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The configuration is placed at `~/.config/lipstick/applications.menu`. and file looks like this:

```
<?xml version="1.0" encoding="UTF-8"?>
<Menu>
    <Name>
    </Name>
    <Filename>glacier-dialer.desktop</Filename>
    <Filename>glacier-messages.desktop</Filename>
    <Filename>glacier-contacts.desktop</Filename>
    <Filename>glacier-settings.desktop</Filename>
    <Menu>
        <Name>folder</Name>
        <Filename>bvnc.desktop</Filename>
        <Filename>bvnc.desktop</Filename>
        <Filename>bvnc.desktop</Filename>
        <Filename>bvnc.desktop</Filename>
        <Filename>bvnc.desktop</Filename>
        <Filename>bvnc.desktop</Filename>
        <Filename>bssh.desktop</Filename>
    </Menu>
    <Filename>bvnc.desktop</Filename>
    <Filename>bvnc.desktop</Filename>
    <Filename>bvnc.desktop</Filename>
    <Filename>glacier-browser.desktop</Filename>
    <Menu>
        <Name>folder</Name>
    </Menu>
    <Filename>qvidcap.desktop</Filename>
    <Menu>
        <Name>folder</Name>
        <Filename>bvnc.desktop</Filename>
        <Filename>bvnc.desktop</Filename>
        <Filename>bvnc.desktop</Filename>
        <Filename>bvnc.desktop</Filename>
        <Filename>bvnc.desktop</Filename>
        <Filename>bvnc.desktop</Filename>
        <Filename>bvnc.desktop</Filename>
        <Filename>bvnc.desktop</Filename>
        <Filename>bvnc.desktop</Filename>
```

Deleting these duplicate entries can fix this buggy behavior.