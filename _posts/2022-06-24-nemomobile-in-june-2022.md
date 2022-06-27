---
layout: post
title: Nemomobile in June 2022
excerpt: 
modified: 2022-06-24
author: jmlich
tags: ["Dialer", "Alarm Clock", "Translations", "Camera", "Gallery"]
image:
  feature: ./2022-06-24-nemomobile-in-june-2022/teaser.jpg
  teaser: ./2022-06-24-nemomobile-in-june-2022/teaser.jpg
  thumb: ./2022-06-24-nemomobile-in-june-2022/teaser.jpg

---

There haven’t been any revolutions in June. We still have to fix compatibility with
the new toolchain. Phone calls and the camera still don’t work. The call history and
alarm handler have been reworked and the Gallery app improved. Translations of plurals
caused some extra effort during the merge.

There were two conference talks: At the DevConf Mini conference and at the Installfest conference. The Installfest (CZ) will cut the stream into separate talks soon. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/Ya0nSC-68OU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<iframe width="560" height="315" src="https://www.youtube.com/embed/CNyNdqd4VCQ?start=5131" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Manjaro has updated to a [new toolchain](https://forum.manjaro.org/t/arm-stable-update-2022-06-19-toolchain-perl-calamares-firefox-gnome-and-kernels/114394).
This caused some troubles with the rebuild of Nemo packages. Namely [libdsm package](https://github.com/sailfishos/libdsme/pull/4) and libconnman-qt package.
The WebOS team is working on [Qt6 support](https://github.com/sailfishos/libconnman-qt/pull/9) of it. Their code fixed partially the issue with GCC 12, but
there was still some [ambiguous use of namespace](https://github.com/webOS-ports/libconnman-qt/pull/4).

The libglacierapp now contains two new features. There is a function to wipe application data and to the set application language. The wipe function doesn’t remove data provided by libraries. For example, the contact list is stored in another location.

Presage packages were added to the nemo-packaging repository, so the working predictive keyboard is coming very soon.

Glacier UI on postmarketOS seems to be not working right now.

## Phone calls

As was shown in the previous blog post phone calls are not working with audio. A phone call could be done after the profile switched manually:

```
pactl set-card-profile 0 "Voice Call"
```

After the phone call, it must be switched back to HiFi profile to be able to play a ringtone or any other music.

The call history page [was reworked](https://github.com/nemomobile-ux/glacier-dialer/pull/59). The icon
is distinguishing incoming, outgoing, and missed calls. By default, it dials the number, but it allows also
writing a text message. The connection to the contact editor is not ready yet. The data itself
is [currently mocked up](https://github.com/sailfishos/libcommhistory/blob/master/tools/addcalls.sh) because
records are not created after finishing of the phone call. 

![](/images/2022-06-24-nemomobile-in-june-2022/call-log.png){: height="400"}

Meanwhile, UBports users are fighting with spam calls. It seems that the [proposed solution](https://forums.ubports.com/topic/7808/howto-block-unwanted-calls-create-blacklist)
could be used after small changes also in Nemo.

## Camera

The camera is connected from hardware to application with video 4 linux device using media-ctl, gstreamer, and QtMultimedia.
It seems the /dev/video2 needs to be created in a [different way](https://github.com/neochapay/nemo-device-dont_be_evil/pull/6).
After all, the colorimetry plugin reports an error when the glacier-camera application is started.

```
CameraBin error: "Device '/dev/video2' does not support 2:0:0:0 colorimetry"
```

There is currently some Google Summer of Code student working on the color space GStreamer plugin. So it will be hopefully fixed soon.

The MegaPixels application has its own processing pipeline, so it works there. It seems the following pipeline can grab some images:

```
gst-launch-1.0 v4l2src device=/dev/video2 ! 'video/x-bayer,format=bggr,width=1280,height=720,framerate=15/1,colorimetry=(string)1:1:0:0' ! bayer2rgb ! videorate \! video/x-raw,framerate=3/1 \! videoscale \! video/x-raw,width=320,height=240 \! videoconvert \! xvimagesink
```

In Nemo it should use `glimagesink` or `waylandsink` instead, but it doesn’t work for some reason.

The libcamera should be able to provide some features into the GStreamer pipeline, such as control of focal point and so on.

In KVM, it is possible to redirect the USB camera into it and use it with the glacier-camera application. It turned out
that there are a [couple of bugs to fix](https://github.com/nemomobile-ux/glacier-camera/pull/21). There are a couple of
features missing. For example, it is not possible to take a photo and save it into a file. The [reference implementation](https://github.com/qt/qtmultimedia/tree/dev/examples/multimedia/declarative-camera)
from Qt Multimedia works perfectly fine, so now it is just about finding the missing or incorrect method or parameters.

## Gallery

Glacier gallery got another improvement. Now it is possible to crop the image.

<iframe width="560" height="315" src="https://www.youtube.com/embed/8pkYeqo-W1g" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Alarm handler

The alarm handler application was reworked. It can now show the [calendar and alarm events](https://github.com/nemomobile-ux/glacier-alarm-listener/pull/4).
Previously, the application was popping up repeatedly. It turned out that the timed daemon had the `WakeUp` event in the list
of events. Now is possible to [filter those events](https://github.com/sailfishos/nemo-qml-plugin-alarms/pull/2) out of the list.

![](/images/2022-06-24-nemomobile-in-june-2022/alarm-handler.png){: height="400"}

## Translations

There was a little confusion caused by the number of plural forms in Transifex and in Qt Linguist. The first one showed two forms and the second one showed three forms of plurals:

![](/images/2022-06-24-nemomobile-in-june-2022/linguist.png){: height="400"}
![](/images/2022-06-24-nemomobile-in-june-2022/transifex.png){: height="400"}

It turned out that Transifex is using newer ISO Standard and [Unicode CDLR](https://community.transifex.com/t/important-update-languages-plural-rules/2832) data
than Qt Linguist which includes that [feature](https://bugreports.qt.io/browse/QTBUG-101214) in Qt 6.4 which is planned to be released in September this year.

As a consequence, Transifex considered the translation reimported from GitHub as incomplete and discarded it.

Moreover, Transifex recommends writing the translations directly within their user interface or using the import dialog in the same place. Merging of translations into GitHub and consequent import to Transifex is not recommended. 