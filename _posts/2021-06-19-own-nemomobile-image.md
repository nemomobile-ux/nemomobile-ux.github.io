---
layout: post
title: Own Nemomobile image
modified: 2021-06-19
author: jmlich
tags: ["Web browser", "Image build"]
image:
  teaser: 2021-06-19-own-nemomobile-image/Screenshot_manjaro_2021-06-19_150855-620.png
  thumb: 2021-06-19-own-nemomobile-image/Screenshot_manjaro_2021-06-19_150855.png
---


It looks like we have a long journey ahead of us to reach the dream goal. Fully working and fully open source linux
smart phone is a damn difficult task. What have been achieved since the last post?

# Web browser

The Web browser application is one of the most frequently used applications. There are many requirements
on it. When I started with PinePhone I was testing different operating systems such as Ubuntu Touch,
postmarketOS with Phosh, Plasma mobile and so on. One of the tests was web browser. The experience
was mostly terrible. The browsers was slow, crashing time to time, or rendered pages incorrectly.

I packaged the glacier-browser and added some minor changes. It is very very very simple. It has just
an address line, repeater with WebEngineView, bookmarks and browsing history. I have replaced WebKitView
by WebEngineView and added bookmarks. You can see on the screencast that I haven’t even fixed the address
line behavior yet (the same address stays there all the time).

![browser](/images/2021-06-19-own-nemomobile-image/1623184186.avi.gif "Glacier-browser with Qt WebEngine")

Many people recommended to getting rid of Chrome based Qt WebEngine in favor of gecko-dev, qtmozembed-qt5,
and sailfish-components-webview. The long story is that Firefox is not developing mobile optimized firefox.
Jolla people are keeping that alive with security fixes and so on.

One possible way is to use non-glacier browser. It could be midori or desktop Firefox. There
is an [mobile-config profile](https://wiki.postmarketos.org/wiki/Firefox) for Firefox to get
it mobile friendly.

# Phone calls or bursts

Right now I am in phase of burst. I have noticed few warnings during boot of PinePhone. One of
them was about old version of ANX7688 firmware. I have updated it according to [guide on pine forum](https://forum.pine64.org/showthread.php?tid=13001).
Similar I have updated [modem firmware](https://forum.pine64.org/showthread.php?tid=11815).
I have tried also phone call with mobian, but without success.

# Back to nemo packaging

I continued with attempts to recompile manjaro based nemo packages for aarch64. There were [multiple iterations](https://github.com/nemomobile-ux/nemo-packaging/pull/28)
and dozens of commits. The deploy.sh is using `buildarmpkg -k -p package`, where `-k` stands for keep build root. Hence dependencies were missing.

There was very random error during build of qmake based project. The arch/manjaro’s makepkg adds `-j $number`
to every make command. After addinig `-j 1` to every `make install` the issue disappeared. I wasn’t able to
find exact place of problem, but I have created an [QTBUG ticket](https://bugreports.qt.io/browse/QTBUG-94543) on qmake.

When I was rebuilding mkcal, I have found, that we are using [wrong paths with cmake](https://github.com/nemomobile-ux/nemo-packaging/pull/30).
It was most likely caused by copy paste from some other project. For most of projects it was working correctly,
but in the end the libmkcal.pc had incorrect prefix entry, which caused errors in build of its dependencies (contactsd package).

# Improvements of glacier-settings

I was looking into glacier-settings and I have found and [changed a few things](https://github.com/nemomobile-ux/glacier-settings/pull/23):

* incorrect height of element in Wifi access point list view.
* the list of “supported” languages (we don’t support anything (-; ) wasn’t installed into right place. Now the list is full of languages
* The setlocale was originally installed into libexec path which is not recommended in Arch. glacier-settings was pointing to incorrect path, hence nothing was started. Now there is probably missing the access control list.

# Nemo moves forward

The qt-virtualkeyboard was abandoned in favor of Maliit. Now, the variable shoud be as follows:

```
export QT_IM_MODULE=Maliit
```

# Building own image

I was facing many challenges when I was building own image. First, there is a parameter `quiet` on `/proc/cmdline` by default.

This could be overridden by editing of command in grub in KVM or by editing of `/boot/boot.txt` and running `./mkscr` in
same directory on PinePhone. Unfortunately, you have to wait until everything fails and console on tty is started.

This could be a little bit tricky, because the unit may cause failure of everything and avoid startup of shell.
This has a workaround on KVM. You can start early shell by changing of grub or enabling right systemd unit:

```
systemctl enable debug-shell
```

I haven’t found a way to use it on PinePhone. The terminal must be most likely started on different tty.
Also it is hard to change kernel parameters without booting. There is probably some command in uboot, but
I haven’t found it so far (I probably didn’t look long enough).

There were [tricky error](https://github.com/nemomobile-ux/nemo-packaging/pull/23/commits/12df8e8cb98eea18faff9ad37c14afcccc2dfab0)
in `/usr/lib/startup/booster-cgroup-mount`. The script was trying to create cgroup, but it expected
read-only filesystem. Previous approach was to remount it read write, create cgroup, and remount
it back as read only. But following applications was expecting read/write access. If I remember
correctly, many distributions were migrating from cgroups v1 to v2 some time ago. It could be
related to change of its workflow.

# Upstream first!

Manjaro is upstream for nemomobile. It make sense to make tests outside, but production should follow upstream.

I have gained access to [nemo-ux](https://gitlab.manjaro.org/manjaro-arm/packages/community/nemo-ux) subgroup from @Spikerguy.
Thanks! I have created an [jmlich/nemo-ux](https://github.com/jmlich/nemo-ux) repository with submodules to be able compare
it side-by-side. I have moved all changes to manjaro repo, but it has to be rebuilt and pushed into community repo.

For build it self could be used and is used gitlab ci. Pushing into repository is done manually. For that reason,
some packages cannot be built.

Unfortunately, both repositories `nemomobile` and `community` are present in OS, so package conflicts may affect result.
For example renaming of nemo-qml-plugin-models-git to nemo-qml-plugin-models because of version in dependency is
an issue, because it provides and conflicts package the other package.

# Finally It boots!

In the end, I was able to create an bootable image \o/

If you want to test latest and greatest build:

(1) download image

(2) flash it on your sd card

(3) wait 3 minutes during boot until mce fails. `quiet` parameter suppressed most of messages.

# Known issues

* Maliit keyboard causing crashing
* lipstick is restarting frequently for some reason.
* my first image booted into ui on PinePhone \o/

# Easy task to start with

In repository glacier-home is app launcher and it contain folder view. There is
[something broken](https://github.com/nemomobile-ux/glacier-home/issues/147) with its rendering.

![folder](/images/2021-06-19-own-nemomobile-image/Screenshot_manjaro_2021-06-19_150855.png "Broken folder view")


I hope you will take a look at it (-; I am looking forward to your questions and contributions.
