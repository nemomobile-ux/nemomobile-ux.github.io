---
layout: post
title: Nemomobile in August/2021
modified: 2021-08-17
author: jmlich
tags: ["Dialer", "Settings", "Release"]
image:
  feature: PinePhone_Beta_Edition-border-980.png
  teaser: PinePhone_Beta_Edition-border-620.png
  thumb: PinePhone_Beta_Edition-border.png
---

As last month, we have some news about project progress to share. I am
publishing this on my [personal blog](https://blog.mlich.cz) and usually one or two days later
on [nemomobile.net](https://nemomobile.net). I would like to say thank you to Sergey for most
of changes and to Mark who is fixing my grammar in those blog posts.

## Desktop icons

Previously, I was testing flatpak and found out that flatpak applications could be installed and
started, but icons on desktop are missing. Sergey added right directory into lookup for `*.desktop`
files and voila. It works!

![](/images/2021-08-17-nemomobile-in-august-2021/20210816152819.png){: width="300"}
![](/images/2021-08-17-nemomobile-in-august-2021/20210802205502.png){: width="300"}

There is probably some bug in window rendering as could be seen in 2048 game installed from flatpak
However, natively installed modRana behaves the same.

I have extended [the list of directories](https://github.com/nemomobile-ux/lipstick/commit/de393f8c291e653e16f84e523981208b6d56b800) to
be searched for application icons. As the result flatpaks and also other applications have icons.
We can probably still add a few resolutions. I have also [removed scroll decorator](https://github.com/nemomobile-ux/glacier-home/commit/e201f67ed994a934836b9f1a54dff7377af14e53)
in application launcher, because I don’t like it.

## Action buttons

The action buttons are part of `ListViewItemWithActions` component. The availability of actions are indicated
by blue stripe on the left side (color depends on theme). After `pressAndHold` the icons are shown. Previously,
the size of area to show wasn’t detected correctly. Now it detects if the icon is visible and only necessary
space is used.

![](/images/2021-08-17-nemomobile-in-august-2021/actionButtons.gif){: height="360"}

## Updating of the theme

The `ListView` and `ListViewItemWithActions` demo is demonstrated on the list of animals.
Its icons weren’t used correctly. During inspection of this I found that font-awesome icons
are outdated. I needed icon of pig, horse, and others

The [nemo qtquick controls](https://github.com/nemomobile-ux/qtquickcontrols-nemo) have
image provider wrapper which is using icons from [nemo-theme-glacier](https://github.com/jmlich/nemo-theme-glacier/blob/master/icons/fontawesome/heart.png).
The [NemoIcon](https://github.com/jmlich/qtquickcontrols-nemo/blob/master/src/controls/qml/NemoIcon.qml) component utilizes FragmentShader to change color of icon according your needs (by
default it is according to the theme). You can use it like this:

![](/images/2021-08-17-nemomobile-in-august-2021/path2-150x150.png)

```
NemoIcon {
    source: "image://theme/heart"
    color: "#a40000"
}
```

## Connection to the internet

Sergey updated two settings sections related to internet connection. First the mobile network dialog. 


![](/images/2021-08-17-nemomobile-in-august-2021/MobileNetworks.png){: height="460"}
![](/images/2021-08-17-nemomobile-in-august-2021/mobile-settings.jpg){: height="460"}

For some reason, it doesn’t work for me. I have added the status field to be visible
after `Enabled` word. At first attempt, I thought that selection preffered network
type might help, but my carrier provides here only LTE network anyway.

```
[manjaro@manjaro-arm ~]$ ofonoctl 
Modem         Status    SIM
------------  --------  -----------
quectelqmi_0  Denied    T-Mobile CZ

[manjaro@manjaro-arm ~]$ ofonoctl poweron;ofonoctl online; ofonoctl
Powered on quectelqmi_1
Brought quectelqmi_1 online
Modem         Status     SIM
------------  ---------  -------
quectelqmi_1  Searching  Unknown
```

Sergey reworked also Wifi connection settings. Now it allows connection to unprotected and
networks secured with WEP encryption. Although, those improvements are great additions more
development is needed. The connman interface doesn’t provide right value for `saved` field
for some reason.

# Voice calls

Ultimate target of all Linux distributions on PinePhone is a fully working smart phone
including reliable phone calls. Nemo mobile is not that far yet.

The [incoming call page](https://github.com/nemomobile-ux/glacier-dialer/commit/e78991b23ad1e1bd5a97aea4b8788eadd7750e68)
was reworked and fixed.

I was working on sound and vibration settings page. Now you can set your favorite ring tone. You can check it in attached video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/KDIZb9Vdqf4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Currently, there are a number of issues which need to be addressed. Current implementation of
settings is based on profiled, but I am not sure if the setting is used by glacier-dialer application.
The [systemsettings interface](https://github.com/nemomobile-ux/nemo-qml-plugin-systemsettings/blob/master/src/profilecontrol.cpp)
doesn’t provide list of profiles. It mainly works with general profile. I would expect configuration
of it for different profiles. The interface design should be probably updated further. The nemo
[profiled](https://github.com/nemomobile-ux/profiled-settings-nemo/blob/master/ini/10.meego-default.ini) settings
was [packaged](https://github.com/nemomobile-ux/nemo-packaging/pull/78) so appropriate settings should be there by default.

We have packaged OpenMoko ringtones. Right now it must be installed manually by running `pacman -S nemo-theme-openmoko-git`,
but we might add it to default package set.

## Time and timezone

The settings of time and timezone had only automatic mode, but it didn’t worked well. There were issue with permissions
in qt5-timed. The `RingIndicator` used for visualization of clock was reworked. Now, there are two new dialogs.
One for settings of the time zone and second for settings of the date and time. See screenshots below: 

![](/images/2021-08-17-nemomobile-in-august-2021/20210803132800.png){: width="300"}
![](/images/2021-08-17-nemomobile-in-august-2021/20210818100858.png){: width="300"}
![](/images/2021-08-17-nemomobile-in-august-2021/20210818100941.png){: width="300"}




## File manager shows files

Not so long time ago I was trying to move some file on SailfishOS on my Jolla 1 into ~/.local into settings path
of some application. It was impossible task. Therefore I am very happy, that glacier-filemuncher now allows work
with hidden files. For those who are not aware Linux conventions, the files starting with dot are hidden by default.

## Storage overview

The whole settings is undergoing overhaul. Many things are missing, many others are outdated. The settings
is divided into plugins. Each plugin is defined by in json file and points to qml file with details. This
allows moving settings from various applications directly into device settings.

The newly added storage settings provides overview of partitions usage. It is rather simple, but
enough for daily use. See screenshot below:

![](/images/2021-08-17-nemomobile-in-august-2021/20210817131455.png){: width="300"}

## MCE and boot time

Sergey [updated unit file of mce service](https://github.com/jmlich/nemo-packaging/commit/662d92f0fc6e58f6fdcede0a6addb4c8a8529701) and
it is starting in less than 3 seconds now. Overall startup time is now shorter by 3 minutes.

```
[manjaro@manjaro-arm ~]$ systemd-analyze 
Startup finished in 4.308s (kernel) + 37.673s (userspace) = 41.982s 
graphical.target reached after 27.573s in userspace
[manjaro@manjaro-arm ~]$ systemd-analyze --user
Startup finished in 727ms (userspace) 
default.target reached after 727ms in userspace
```

## Web site

I am very happy, that we managed to improve website of the project [nemomobile.net](https://www.nemomobile.net/). Now, the webpage covers
[installation](/installation/) of Nemo mobile on PinePhone from image to µSD card. Next, there is [overview of basic user interface](/glacier-home/),
which includes application launcher, list of running applications, notification area, and screensaver. For developers we have [SDK section](/sdk/)
which covers compilation of packages and composition of image. The Nemo is based on the own [QtQuick Controls extension](/qtquickcontrols-nemo/)
which is described on a separate page.

People are asking about that in the Telegram group, which means that they are trying to use it and they are interested
in the project. I am looking forward to seeing new patches from new people.

## Release 0.5

Today was published new version. It have number 0.5. Currently, there is only image for PinePhone. We are looking forward for your feedback.

```
wget https://img.nemomobile.net/2021.10/Manjaro-ARM-nemomobile-pinephone-0.5.img.xz
xz -dc Manjaro-ARM-nemomobile-pinephone-0.5.img.xz | dd if=/dev/stdin of=/dev/mmcblk0 status=progress conv=fsync bs=4M
```

## Bug to start with

As usual here is some task to start with. It is not necessarily easy tak, but it will have notable impact on all users.

Right now is the issue, that accelerometers doesn’t work. Similar task was solved in 
[ubuntu-touch](https://forums.ubports.com/topic/6354/sensors-for-the-pinephone). The freedesktop
has [iio-sensor-proxy](https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/) which is unrelated, but can contain some hints.

The data should go from hardware to application as follows.

`sysfs` &rarr; `sensorfw` &rarr; `Qt5` &rarr; `Application`

The device provides data see `/sys/bus/iio/devices/iio\:device3/in_magn_y_raw`

The profiled logs shows details only about proximity sensor which means, accelerometers aren’t either so verbose either not processed by sensorfw.

```
systemctl stop sensorfwd.service
/usr/bin/sensorfwd -c=/etc/sensorfw/primaryuse.conf --systemd --log-level=test --no-magnetometer-bg-calibration 2>&1 |less
```

The end user application should be glacier-home. There is some “parallax” effect which should be visible.
The screen should switch between landscape and portait mode. Another option is to compile some example
application. I was trying to use [Qt Sensors Examples](https://doc.qt.io/qt-5/qtsensors-examples.html).

