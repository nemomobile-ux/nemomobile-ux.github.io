---
layout: post
title: Nemomobile in March 2023
excerpt: 
modified: 2023-02-24
author: jmlich
tags: ["Lipstick", "Device lock"]
image:
  feature: ./2023-03-31-nemomobile-in-march-2023/lock-screen.jpg
  teaser:  ./2023-03-31-nemomobile-in-march-2023/lock-screen.jpg
  thumb:   ./2023-03-31-nemomobile-in-march-2023/lock-screen.jpg

---

In this update, improvements were made to phone call functionality and the code base was updated.
Despite recent changes, phone calls are still experiencing issues. However, progress has been made
with the resolution of the Non-Graphical Feedback daemon issue and the incorporation of the
telepathy-ring module into Nemo. Additionally, the code base was polished by adding DTMF
sounds to the glacier-dialer app and updating more than 30 packages to their most recent
versions.

## Removal of LightDM

The LightDM display manager was replaced by autologin based on [systemd units](https://github.com/nemomobile-ux/glacier-wayland-session/blob/master/rootdir/usr/lib/systemd/system/start-user-session.service) to
address timing issues related to the startup of certain services. However, seat0 was left unassigned,
resulting in failed permission checks. As a consequence, several features such as usb-moded and
turning off (dsme) were not functioning properly. Although there is a [workaround for connman](https://github.com/nemomobile-ux/glacier-wayland-session/commit/2c869c49f5a116b4236e025d5d68656568d7dc06),
the absence of seat0 continues to pose challenges.

```
[root@pinephone ~]# loginctl list-sessions
SESSION  UID USER    SEAT TTY  
     c1 1000 manjaro      pts/0
     c2 1000 manjaro      pts/1
```

## Toward Phone Calls

Despite recent changes, phone calls are still not functioning properly. The pulse audio profiles
were updated, and the telepathy stack was analyzed to determine what components are missing.
The issue with the Non-Graphical Feedback daemon (ngfd) has been resolved.

Previously, the pulse audio profiles had been adjusted, but issues arose with the visibility [property binding breakage](https://github.com/nemomobile-ux/glacier-home/pull/223).
As a result, the slider showing the current volume disappeared after the first use and did not reappear until reboot.

<iframe width="560" height="315" src="https://www.youtube.com/embed/jA7yiqHapGg" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

The SailfishOS stack utilizes the telepathy-ring module, rather than telepathy-ofono. To incorporate this module into Nemo,
[permission settings](https://github.com/nemomobile-ux/nemo-packaging/blob/master/telepathy-ring/0001-fixup_access.patch) had to
be modified via a #define clause in the source code. Additionally, an issue was encountered where the telepathy-ring was
crashing when attempting to connect to ngfd via dbus. This issue was resolved by updating to
[new dbus functions](https://github.com/nemomobile-ux/nemo-packaging/blob/master/telepathy-ring/0002-fixup_connection.patch).

The ngfd was experiencing segfaults, which were resolved by identifying the cause of the crashes and [providing a patch upstream](https://github.com/sailfishos/ngfd/pull/8).
After adjusting the configuration for the PinePhone, haptic feedback began working in the hardware testing application.
However, phone calls are still experiencing issues, indicating that there may be further unresolved problems.

## Improving code base

In an effort to stay up to date with the latest operating system, we have updated more than 30 packages to their most recent upstream version.

The glacier-dialer app now includes DTMF sounds, but the keyboard still cannot be displayed during a phone call.

<iframe width="560" height="315" src="https://www.youtube.com/embed/TQ80nAlwTNg" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

The nemo-device-lock --help command was [reviewed and updated](https://github.com/nemomobile-ux/glacier-devicelock-plugin/pull/5). Here is a brief summary of its usage:

```
# change configuration https://github.com/sailfishos/nemo-qml-plugin-devicelock/blob/master/src/nemo-devicelock/private/settingswatcher.cpp#L68

[manjaro@pinephone ~]$ /usr/lib/qt5/plugins/devicelock/glacier-devicelock --set-config-key 123456 /desktop/nemo/devicelock/automatic_locking 1; echo $?
0

# clear code
[manjaro@pinephone ~]$ /usr/lib/qt5/plugins/devicelock/glacier-devicelock --clear-code; echo $?
0

# verify if cleared. Indicated by exit code
[manjaro@pinephone ~]$ /usr/lib/qt5/plugins/devicelock/glacier-devicelock --is-set; echo $?
255

# the previous code is ignored if wasn't used
[manjaro@pinephone ~]$ /usr/lib/qt5/plugins/devicelock/glacier-devicelock --set-code 123456 123456; echo $?
0

[manjaro@pinephone ~]$ /usr/lib/qt5/plugins/devicelock/glacier-devicelock --is-set; echo $?
0
```