---
layout: post
title: Nemomobile in November/2021
excerpt: Release 0.6, boot splash, device lock, policy kit agent, and more
modified: 2021-11-05
author: jmlich
tags: ["Release", "Package manager", "Device lock"]
image:
  feature: ./2021-11-05-nemomobile-in-november-2021/bootsplash-landscape.gif
  teaser: ./2021-11-05-nemomobile-in-november-2021/bootsplash-landscape.gif
  thumb: ./2021-11-05-nemomobile-in-november-2021/bootsplash-landscape.gif
---

NemoMobile 0.6 was released. Horay! What else? We have new boot splash, reworked device lock, new policy kit agent and old-new package manager, updates of bluetooth, pulse audio, the translations was updated. PineTab initial support.

The biggest news since last post is a release of the NemoMobile 0.6. These blog posts covers usually newer topics which aren't included into that release yet. 

The sizing rework was merged and is included into 0.6. Unfortunately, this change breaks font sizes in fingerterm.

We are happy that users are trying to start with NemoMobile and are enthusiastic about it same as we are:


> Nemo Mobile: Nemo is an opensource UI alternative to Sailfish as the UI Sailfish uses is proprietary. It uses the same framework as Sailfish called Lipstick. And is made completely from scratch. It’s making great progress but isn’t ready for daily driving yet. I recommend to check it out on an SD Card, it’s very awesome.
>
> &mdash;
> [The ultimate one year review: daily driving the PinePhone](https://medium.com/@camden.o.b/the-ultimate-one-year-review-daily-driving-the-pinephone-25bc41a05533?source=user_profile---------0-------------------------------) - Camden Bruce

## Device lock

<iframe width="560" height="315" src="https://www.youtube.com/embed/cSq9bZtt6_c" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The old-new package manager application was refreshed. In same time, the policy kit agent was created.


The device lock was reworked. Now it should be accessible via settings. It could be also
controlled manually via `/usr/lib/qt5/plugins/devicelock/glacier-devicelock --set <old code> <new code>`
and then reboot. The settings could be disabled in file `/usr/share/lipstick/devicelock/devicelock_settings.conf`.
The right key and value to edit are `nemo\devicelock\automatic_locking=-1` or `nemo\devicelock\automatic_locking=0`.

[Removal](https://github.com/nemomobile-ux/nemo-packaging/commit/025b0133a06d970c677abed22e7523b8959326d8) of `sailfish-access-control-qt5` package is most probably related to that.

## Glacier-packagemanager

The old-new package manager application was refreshed. In same time, the policy kit agent was created.

![](/images/2021-11-05-nemomobile-in-november-2021/packagemanager.jpg){: height="400"}
![](/images/2021-11-05-nemomobile-in-november-2021/polkit.jpg){: height="400"}
![](/images/2021-11-05-nemomobile-in-november-2021/polkit-screensot.jpg){: height="400"}


## Translations

We have added those components also to translation pipeline. Which means that we have new
50 strings to translate for all languages. The lipstick language files was translated, but
it [wasn’t installed](https://github.com/nemomobile-ux/lipstick/pull/18) and hence it wasn’t
loaded.

The lipstick is still using qmake. Now it is quite good example if you need to compile and install your translations with qmake.

Sebastian Heiden started with German langauge translations. I will take yet some time yet, but
we are happy to see new contributors. The translations are one of best places to get familiar
with code and its structure.

## Splash screen

One of things visible on first sight is a new splash screen. It was necessary to check that
image builds properly and also that it boots. This includes also changes in [u-boot files naming](https://gitlab.manjaro.org/manjaro-arm/applications/manjaro-arm-tools/-/commit/bcafde99f7b7d3c3a6e35dc7cb24110e364e4b38)
in Manajro. Additionally, PineTab and its specific packages was added as possible target for building of ISO. Builds are passing, but I didn’t test it, because I don’t have device to test it.

The support of PineTab required change in manjaro-arm-tools to [allow installation of device specific packages](http://manjaro-arm-tools and device specific packages)
for each manjaro edition. Previously, there were hack to allow device specific patches only for PinePhone.

<iframe width="560" height="315" src="https://www.youtube.com/embed/-rY6YQFGFdw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Other changes

Nemo specific [changes in dsme](https://github.com/nemomobile-ux/nemo-packaging/commit/9a7c66c870ed866c10575d2925c8dd8a3612896c) was merged into upstream.

[Bluetooth interface was reworked](https://github.com/nemomobile-ux/lipstick/pull/12/files) and should work now much better. Device should identify it self as a [smart phone](https://github.com/nemomobile-ux/arm-profiles/commit/534601cf8994fc9734b630782239563612b1c785).

![](/images/2021-11-05-nemomobile-in-november-2021/bluetooth.jpg){: height="500"}
![](/images/2021-11-05-nemomobile-in-november-2021/notifications.jpg){: height="500"}


Let’s make Notifications great again, said Sergey and made some cleanup and added [timeout capability to notifications](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/5392724d7976623cc0255867bc5588c4eed0972c).


We have big problem with sound. Lipstick use meego modules who use ohm and many other stuff. Those are mer specific and outdated and we should [replace them](https://github.com/nemomobile-ux/lipstick/pull/19/files).

Mouse support was added. This makes Nemo closer to use on desktop.

<iframe width="560" height="315" src="https://www.youtube.com/embed/dgALx3D3Ngk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Control center is [being reworked](https://github.com/nemomobile-ux/glacier-home/tree/control_center_rework). It means that buttons were moved from puley menu to notification screen.

glacier-mail api was reworked. It is using webkit and nemo controls now.

## Bug to start with

The [usb networking](https://github.com/nemomobile-ux/main/issues/25) doesn’t work. There is a setup-configfs script which is currently failing on missing `/sys/kernel/config/usb_gadget`. Probably kernel interface has changed. I am not sure which module is actually needed. Probably `g_ether`.
