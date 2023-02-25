---
layout: post
title: Nemomobile in February 2023
excerpt: 
modified: 2023-02-24
author: jmlich
tags: ["Messages", "Conference", "Controls", "Release"]
image:
  feature: ./2023-02-24-nemomobile-in-february-2023/IMG_20230204_151926.jpg
  teaser:  ./2023-02-24-nemomobile-in-february-2023/IMG_20230204_151926.jpg
  thumb:   ./2023-02-24-nemomobile-in-february-2023/IMG_20230204_151926.jpg

---

February kicked off with the FOSDEM conference, which brought about progress on the mali driver issue and a sneak peek behind the Necunos prototype device running Nemomobile with the Glacier UI. Among the highlights, the window size problem in the lipstick compositor was resolved. Efforts to improve ofono and pulse audio were made with the aim of getting phone calls and text messages to function properly.

## FOSDEM

February began with the FOSDEM conference in Brussels, where many interesting [topics](https://blog.mlich.cz/2023/02/fosdem-experience/) were presented in sessions. However, from a Nemomobile perspective, some of the most fascinating discussions took place in the hallways.

One of the small talks during the conference revolved around the mali driver issue that caused the glacier-settings application to freeze when opening the Wi-Fi settings dialog. The maintainer of mali recommended using apitrace to provide the necessary details for a [bug report](https://gitlab.freedesktop.org/mesa/mesa/-/issues/8262). He also suggested using some /proc/cmdline arguments to adjust timeouts as a possible workaround for the issue. However, it turned out that this information was not sufficient to reproduce the issue. It is suspected that the issue may also be related to the revision of the mainboard.

In addition, Eetu showcased the Necunos prototype device, which was running a branch of Nemomobile with the Glacier UI. They had already ported it to Qt Quick Controls 2.

![](/images/2023-02-24-nemomobile-in-february-2023/IMG_20230204_163848.jpg){: width="180"}
![](/images/2023-02-24-nemomobile-in-february-2023/IMG_20230204_164123.jpg){: width="180"}
![](/images/2023-02-24-nemomobile-in-february-2023/IMG_20230204_164136.jpg){: width="180"}
![](/images/2023-02-24-nemomobile-in-february-2023/IMG_20230204_164148.jpg){: width="180"}
![](/images/2023-02-24-nemomobile-in-february-2023/IMG_20230204_164220.jpg){: width="180"}


## Keyboard size, window size, and related changes

The lipstick compositor received a [fix for the window size issue](https://github.com/nemomobile-ux/glacier-home/commit/d5147732446393e707787dbef3c4273bbb10d0bb), resolving
the problem with the PinQuery dialog displaying incorrect dimensions. The issue would occur when the application was already running and the window suddenly appeared. This
problem also affected the Settings application when opened using the press and hold action from the Wi-Fi button on the notifications page, as well as when launching the Messages application from a message notification.

Additionally, there was a separate issue with the window size not [updating properly when the on-screen keyboard appeared](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/f3755c764fbde910fb742e46e36f55b0c908a346),
causing the text area to be hidden behind the keyboard.

![](/images/2023-02-24-nemomobile-in-february-2023/photo1676896580.jpeg){: height="500"}
![](/images/2023-02-24-nemomobile-in-february-2023/image20230224_151246944.jpg){: height="500"}



It’s worth noting that during the same period, lipstick was [updated](https://github.com/nemomobile-ux/lipstick/commit/97de1f3e56ce59949d38b6f84d617063fde884f6) to
the most recent upstream version. This update included a significant refactor and simplification of the code base, resulting in a reduction of 700 lines of code.
Interestingly, this was caused by our 10-line [pull request](https://github.com/sailfishos/lipstick/pull/39).

## Towards a Smartphone OS

Despite the progress that has been made, additional issues were encountered that required attention. Specifically,
an [incorrect DBus permission configuration in ofono](https://github.com/nemomobile-ux/nemo-packaging/commit/200ffb7ccd149cc5aaf6014d27892b6bc33724b5) affected functionality and needed to be addressed.

Changes related to recent upstream updates to [pulse audio volume in lipstick](https://github.com/nemomobile-ux/lipstick/commit/67bbffb49fa4c02982a4c831da5c271d7faa948a) were
made, including adjusting the [volume step](https://github.com/nemomobile-ux/glacier-home/commit/7d303131b643b7266a4241e1197b4acbcf2ce47f) from 10 to 1 and modifying
[pulse audio profile names](https://github.com/neochapay/nemo-device-dont_be_evil/commit/910e4869ffe26cef54083f5a8408e188f2811b0d). However, the profiles are not yet switching properly for phone calls.

While testing phone calls, we discovered that [displaying avatars](https://github.com/nemomobile-ux/glacier-dialer/pull/64) could cause issues. Previously, using a high-resolution picture could significantly slow down the loading of the phone call answer dialog and cause the text and control buttons to be hidden. To address this, we limited the avatar size in memory and implemented asynchronous loading. As a result, the avatars no longer overflow and control buttons, such as loudspeaker, are now visible at all times.

![](/images/2023-02-24-nemomobile-in-february-2023/219876557-d8ed4205-97c3-494a-a5e0-d14664dda68f.jpg){: width="400"}
![](/images/2023-02-24-nemomobile-in-february-2023/219876560-d4c4f0fc-eb04-4b61-b80a-9dff053f11d3.jpg){: width="400"}

Additionally, it was found that the [configuration for haptic feedback](https://github.com/neochapay/nemo-device-dont_be_evil/commit/d561948392cf1d310ec25d25cbd2fc0eb75818a5) was missing or pointing to a non-existing file.

Finally, while attempting to make the mobile stack work, it was discovered that some SMS messages were successfully sent depending on the correct order of service starting, specifically the mission-control service. A [pull request](https://github.com/nemomobile-ux/glacier-wayland-session/pull/5) has been submitted to address this issue.

These efforts move towards a more reliable and user-friendly smartphone operating system.

## New image to test

New images are ready for download and testing at [https://img.nemomobile.net/2023.05/](https://img.nemomobile.net/2023.05/) 
