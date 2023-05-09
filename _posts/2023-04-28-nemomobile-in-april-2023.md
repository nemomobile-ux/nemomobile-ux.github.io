---
layout: post
title: Nemomobile in April 2023
excerpt: 
modified: 2023-04-28
author: jmlich
tags: ["Conference"]
image:
  feature: ./2023-04-28-nemomobile-in-april-2023/Linux-App-Summit-2023.png
  teaser:  ./2023-04-28-nemomobile-in-april-2023/Linux-App-Summit-2023.png
  thumb:   ./2023-04-28-nemomobile-in-april-2023/Linux-App-Summit-2023.png

---

In the past month, NemoMobile made progress on the Weather app, Qt *.prf file compilation issues, and device orientation functionality. NemoMobile was also featured in a Lightning talk at the LinuxAppSummit conference.

## Weather application improvements

The configuration of the Weather application has been reworked, and the city model is now stored in an sqlite database.

## Qt *.prf wasn’t in the right folder

The *.prf file was moved to the correct folder. This file is usually provided by a library and included in the Qt project
client application using CONFIG += something, adding definitions to the Qt project such as linking with qt dbus module, etc.
Some libraries installed this file in a different folder, causing missing features. This issue arose while rebuilding
nemo-qml-plugin-calendar. The fix with *.prf also resolves the problem with including libraries. The addition of -liodata-qt5 here may 
[no longer be necessary](https://github.com/nemomobile-ux/nemo-packaging/blob/master/timed/0001-Fixes-build.patch#L9), as 
CONFIG += iodata takes the same information from [iodata.prf](https://github.com/sailfishos/libiodata/blob/master/iodata.prf#L1).
Unfortunately, qmake does not produce an error message when the *.prf file is not found.

## Orientation in qqc-nemo

The part of Qt Quick Controls Nemo that handles device orientation has undergone significant rework,
resulting in the removal of a large block of code. This simplification was necessary as these parts
must be done on the compositor side.

## Nemo at LinuxAppSummit

The LinuxAppSummit conference was held in Brno on April 22-23 and covered many topics such as flatpak, snap,
flutter, app testing, accessibility, and more. The conference concluded with a lightning talk
on [NemoMobile](https://conf.linuxappsummit.org/event/5/contributions/178/).

<iframe width="560" height="315" src="https://www.youtube.com/embed/J7-3Qj_oVMM?start=24818" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>