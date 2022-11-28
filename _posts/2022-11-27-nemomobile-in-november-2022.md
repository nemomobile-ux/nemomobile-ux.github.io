---
layout: post
title: Nemomobile in November 2022
excerpt: 
modified: 2022-11-27
author: jmlich
tags: ["Qt6", "Design", "CutiePi", "Conference"]
image:
  feature: ./2022-11-27-nemomobile-in-november-2022/wireframes.png
  teaser:  ./2022-11-27-nemomobile-in-november-2022/wireframes.png
  thumb:   ./2022-11-27-nemomobile-in-november-2022/wireframes.png

---

November brings some necessary rebuilds due to updates of system packages and the adoption of some packages into Arch Linux.
The Qt6 support is closer, but Qt Controls adaptation will be necessary. We are looking for new ideas to improve user experience.
Don’t forget to book your flight to Brussels FOSDEM 2023 was announced. The CutiePi MCU with Nemo is being worked on. Can someone help with mysterious prefixes in file paths?

## Updating OS and moving closer to Qt6

The world is moving forward and Nemo is trying to keep pace. Due to new versions of icu and openssl3 packages it was necessary to rebuild some packages such as libmlocale, libphonenumber, or lipstick.

There have been some fixes related to the Qt5 and Qt6 compatibility in [libglacierapp](https://github.com/nemomobile-ux/libglacierapp/pull/9)
and qtquickcontrols-nemo packages. The c++ part is compiling already. The QML part is incompatible and needs to be rewritten. If you have some
ideas on how the user interface should look, now is the right time to [bring ideas](https://github.com/nemomobile-ux/main/issues/41). Maybe
some wireframes. Attached wireframes are made by Greg Goncharov.

![](/images/2022-11-27-nemomobile-in-november-2022/tweet.png)

[![](/images/2022-11-27-nemomobile-in-november-2022/Figma-screenshot.png)](/images/2022-11-27-nemomobile-in-november-2022/nemo-proposals.pdf)

## Manjaro and Arch packages

[Felix Yan](https://twitter.com/felixonmars) is packaging Nemo packages directly into Arch Linux. It is great
and it can spare a lot of packaging time for development purposes. However, we need to adjust our
[Manjaro packaging accordingly](https://gitlab.manjaro.org/manjaro-arm/packages/community/nemo-ux/qt5-quickcontrols-nemo/-/issues/1).

## Fosdem 2023

Fosdem 2023 [call for presentations](https://fosdem.org/2023/news/2022-11-13-call-for-presentations) is open now.
For Nemomobile the main interest is the [FOSS on mobile dev room](https://lists.fosdem.org/pipermail/fosdem/2022q4/003440.html).
The submission deadline is 8th December, but the abstract of the Nemomobile talk has already been submitted. Can’t wait to see
all fans of Nemomobile in person. You can check out some [talks from last year](https://archive.fosdem.org/2022/schedule/track/foss_on_mobile_devices/)
in the meantime.

## CutiePi battery and power button

The CutiePi tablet is an awesome piece of hardware. It combines technologies that are widely adopted by mainline Linux and/or mainstream Linux distributions.
They are trying to “glue” those parts together. Tablet like device requires also a battery and a power button. This was designed by the CutiePi team on the
[board](https://github.com/cutiepi-io/cutiepi-board) which connects all modules together. The charging and button controls the [MCU](https://github.com/cutiepi-io/cutiepi-firmware)
and passes battery status using a daemon made for that purpose. Nemomobile, however is using the `/sys/class/power_supply` interface. 
Pavel Machek started with implementation of the [serdev driver](https://gitlab.com/tui/cutie/) for it. This will hopefully improve Nemo and all other operating systems on CutiePi.

## Bug of the month

After rework of glacier-settings plugins we found mysterious behavior of the `Qt.reslovedUrl()` function. It [prefixes some URLs](https://forum.qt.io/topic/140463/resolvedurl-is-unexpectedly-prefixed)
with unexpected `/usr` string. The final URL is modified just in certain places of source code.

```
Component.onCompleted: {
     console.log(Qt.resolvedUrl("/"));
}
```