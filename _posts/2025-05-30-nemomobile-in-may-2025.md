---
layout: post
title: Nemomobile in May 2025
excerpt: In the past month, several improvements have been made across the Nemo ecosystem to
    accommodate recent changes in the Kremium API. A number of core applications were updated,
    the lock screen experience was significantly enhanced, and support for UI scaling was improved.
modified: 2025-05-30
author: jmlich
tags: ["Kremium", "Device lock", "Scaling"]
image:
  feature: 2025-05-30-nemomobile-in-may-2025/lock4-3.jpg
  teaser: 2025-05-30-nemomobile-in-may-2025/lock4-3.jpg
  thumb: 2025-05-30-nemomobile-in-may-2025/lock4-3.jpg
comments:
  host: mastodon.social
  username: nemomobile
  id: 114599622588875546
---

In the past month, several improvements have been made across the Nemo ecosystem to accommodate recent changes in the Kremium API.
A number of core applications were updated, the lock screen experience was significantly enhanced, and support for UI scaling was
improved.

As mentioned in a previous blog post, changes to the *Kremium API* — a reimplementation of the SailfishOS Silica API used by Qt Quick
Controls Nemo — have required updates to several Nemo applications. Over the past month, the following apps were adjusted: 
[glacier-filemuncher](https://github.com/nemomobile-ux/glacier-filemuncher/commit/2f5959d5f4b3fef7b6463e6fd66e4fe89fa3beaf), *glacier-music*,
*glacier-dialer*, *glacier-pinquery*, and *glacier-alarm-listener*. These apps can now be run again.

A significant amount of work was also done on the *lock screen*. The related API, `glacier-device-lock-plugin`, was refined, and the overall
user experience was improved. New animations were introduced, giving the lock screen a more polished appearance. A lock 
[screen preview application](https://github.com/nemomobile-ux/glacier-home/commit/fbcd35e19779b605dce7256682e5e6d7c24d44f5)
was created to allow for easier fine-tuning of the lock screen’s look and feel. See the demo video below.

<video width="300" style="width: 300px !important" controls>
  <source src="/images/2025-05-30-nemomobile-in-may-2025/simplescreenrecorder.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

<video width="300" style="width: 300px !important" controls>
  <source src="/images/2025-05-30-nemomobile-in-may-2025/simplescreenrecorder-(2).mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

To support this fine-tuning, libglacierapp was updated to allow the [QML path of an application to be specified](https://github.com/nemomobile-ux/libglacierapp/commit/d284f752597d4ce2dc1f11a84110bd4f85cb7414)
— while still defaulting to Qt resources.

In addition, a new app called [glacier-welcome](https://github.com/nemomobile-ux/glacier-welcome) was developed. It is shown on the device’s first start and allows the user to set a device lock password.

Further improvements were made to the [scaling feature](https://github.com/nemomobile-ux/glacier-settings/commit/d5869f1d08660a0915b9f2f78ba58c630d676912),
which now allows fonts and UI elements to be resized in applications based on [Qt Quick Controls Nemo](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/59047d88e862ba83b825048e5cf802f12c882631),
making them more adaptable to different screen sizes.

<video width="300" style="width: 300px !important" controls>
  <source src="/images/2025-05-30-nemomobile-in-may-2025/document_5271721761954625763.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

<video width="300" style="width: 300px !important" controls>
  <source src="/images/2025-05-30-nemomobile-in-may-2025/simplescreenrecorder-(3).mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

