---
layout: post
title: Nemomobile in February 2025
excerpt: It’s been a while since the last update. We’ve been migrating Nemo to Qt6, fixing compatibility
    issues, updating upstream components, and tackling Manjaro’s package changes. Notable progress
    includes Lipstick fixes, merged patches, and the Kremium compatibility layer for running
    Sailfish OS apps.
modified: 2025-02-22
author: jmlich
tags: ["Kremium", "Lipstick"]
image: 
  feature: 2025-02-23-nemomobile-in-february-2025/kremium.jpg
  teaser: 2025-02-23-nemomobile-in-february-2025/kremium.jpg
  thumb: 2025-02-23-nemomobile-in-february-2025/kremium.jpg
comments:
  host: mastodon.social
  username: nemomobile
  id: 114053650316753237
---

It’s been a while since the last update. We’ve been migrating Nemo to Qt6, fixing compatibility
issues, updating upstream components, and tackling Manjaro’s package changes. Notable progress
includes Lipstick fixes, merged patches, and the Kremium compatibility layer for running
Sailfish OS apps.

The software industry moves incredibly fast, and many technologies quickly become obsolete. Our
efforts in Nemo have focused on migrating our software stack to Qt6. Previously, we introduced
the compatibility package qt-old-features, which provided an interface for compiling Qt .pri files
for some components. Recently, we encountered an issue with [CONFIG+=stack_protector_strong](https://github.com/nemomobile-ux/qt6-old-features/pull/1), which
was resolved by Michal.

In Manjaro, there are additional challenges. With the new version of GCC, some warnings have
been promoted to errors. Other components are also evolving—for example, PulseAudio is being
replaced by PipeWire, which has become an obstacle in building Lipstick, as our compositor
still depends on PulseAudio.

We’ve been working on updating upstream components. Our patches to [libngf-qt](https://github.com/sailfishos/libngf-qt/pull/4)
and [libusb-moded-qt](https://github.com/sailfishos/libusb-moded-qt/pull/4)
have been merged. The NemoMobile fork of the Lipstick compositor has been rebased to the latest
upstream version, along with nemo-qml-plugin-systemsettings. Additionally, Lipstick’s tests have
been fixed.

Glacier Gallery relies on Tracker Miner with its SPARQL plugin and, consequently, QtDocGallery.
Besides compilation issues, Manjaro has replaced the Tracker packages with a different solution.
These components are complex, and Sergey has suggested [moving away from them](https://github.com/nemomobile-ux/glacier-gallery/tree/move_from_qdocgallery).

Michal faced challenges with glacier-devicelock-plugin, discovering that the plugin was being
installed to the wrong path. He submitted a [fix for that](https://github.com/nemomobile-ux/glacier-devicelock-plugin/pull/7).

One of NemoMobile’s ultimate goals is to support running Sailfish OS apps. A major obstacle is
the closed-source Silica API. Sergey has developed a compatibility layer called [Kremium](https://github.com/nemomobile-ux/kremnium/pull/1/files), named
after the Russian translation of “Silica.” It has already been demonstrated to run the
harbour-gpsinfo app.

<iframe width="560" height="315" src="https://www.youtube.com/embed/d7LvIvmKCtI?si=gGEhR4ZW2fg6zrAl" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

We have created a Mastodon account with the nemomobile.net RSS feed. This should allow for
adding comments to articles in the future.