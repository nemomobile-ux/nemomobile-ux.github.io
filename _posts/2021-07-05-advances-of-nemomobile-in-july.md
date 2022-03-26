---
layout: post
title: Advances of Nemomobile in July/2021
modified: 2021-07-05
author: jmlich
tags: ["Keyboard", "USB moded"]
image:
  teaser: 2021-07-05-advances-of-nemomobile-in-july/IMG_8578-1-1024x576-620.jpg
  thumb: 2021-07-05-advances-of-nemomobile-in-july/IMG_8578-1-1024x576.jpg
---


While Sergey has made many changes, the overall usability is still very poor. Main issues are frequent crashes (or quitting) of UI. Mostly due to the Maliit software keyboard not working.

Most recent changes can be seen on the screenshots:

![](/images/2021-07-05-advances-of-nemomobile-in-july/2.jpg){: width="300"}
![](/images/2021-07-05-advances-of-nemomobile-in-july/3.jpg){: width="300"}
![](/images/2021-07-05-advances-of-nemomobile-in-july/6.jpg){: width="300"}
![](/images/2021-07-05-advances-of-nemomobile-in-july/1.jpg){: width="300"}
![](/images/2021-07-05-advances-of-nemomobile-in-july/4.jpg){: width="300"}
![](/images/2021-07-05-advances-of-nemomobile-in-july/5.jpg){: width="300"}

* lock screen shows sim card availability and signal strength
* there are some changes related to geoclue
* on screen keyboard Maliit works in the app launcher.
* the dialer is starting but it says `voicecall-manager[4030]: "Dial: org.ofono.Error.InvalidFormat Argument format is not recognized"` now when call button is triggered 

# Maliit

The software keyboard still doesn’t work as needed. It seems part of the problem is that
[environment variables for dbus started apps](https://github.com/nemomobile-ux/arm-profiles/pull/2/commits/aad455fb2dea53180b8b383030389a59ba2acc2d)
are not set. Most important was probably `QT_QPA_PLATFORM=wayland`.

Additionally, other variables for Maliit could be used to get some debug information:

```
export MALIIT_FORCE_DBUS_CONNECTION=1
export MALIIT_DEBUG=1
maliit-server
```

The keyboard shows correctly only on home screen, but in application is split into two windows:


![](/images/2021-07-05-advances-of-nemomobile-in-july/IMG_8578-1-1024x576.jpg)


When trying to find bugs I usually think of the changes which are needed to introduce the bug into perfect
application. That helps me to localize the issue in the code. Now, it looks like incorrect behavior
in compositor which is something I haven’t touched so far.

# Invoker and booster

Next, I was looking into the list of systemd units to find out what is failing (and what is slowing down the system start:

```
systemctl status
systemctl status --user
systemctl
systemctl --user
systemd-analyze blame
```

Many systemd user units were failing because of dependency on user-session.target (and -pre and -post targets).
I guess the right replacement is graphical.target. After that change, most applications stopped working.
The glacier-* apps are using mapplaunchd to accelerate start. The invoker falls back to regular start of
applications when the user service is not running. When the service is running the dbus invocation could be used.

The applications (e.g. voicecall-manager) complained:

```
cannot dynamically load position-independent executable
```

The [mapplauncherd suggests](https://github.com/sailfishos/mapplauncherd/blob/master/doc/usingcmake.dox) to add:

```
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -fvisibility=hidden -fvisibility-inlines-hidden")
set(CMAKE_EXE_LINKER_FLAGS "-pie -rdynamic")
```

In meanwhile I revamped mapplauncherd-booster-qtcomponents and [mapplauncher-qt](https://github.com/sailfishos/mapplauncherd-qt/pull/3)
to cmake and [added those flags into it](https://github.com/nemomobile-ux/mapplauncherd-booster-qtcomponents/pull/3).

# usb-moded

The debugging was slow and I am not sure if I managed to fix mapplauncher related issues. I decided to do an online debugging session on Friday. Many people joined the discussion.

Aleksi (aka @locusf) spotted that usb-moded is not working because of a DBUS issue. For some reason I was focusing on errors with procfs/sysfs. It turned
out that [some XMLs weren’t installed](https://github.com/jmlich/nemo-packaging/commit/f0f307dd7b5d8984704dcc06128d2d65de3444b2). Now the
icons for charging and debug mode are showing correctly. Most important is that 192.168.2.15 is set automatically for usb0 device, which
makes debugging available even without a serial console cable.

![](/images/2021-07-05-advances-of-nemomobile-in-july/usbmoded-577x1024.jpg)


# Manjaro integration

All packages are in manjaro community repositories. The main bottleneck is now in [updating of the package repository](https://forum.manjaro.org/t/automation-of-package-updates/71308).
Some packages still needs to be rebuilt. Personally, I don’t see it as a priority now as the whole UI
is hard to use for development. Maliit and frequent UI crashes must be solved first.