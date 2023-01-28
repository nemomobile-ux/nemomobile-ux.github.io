---
layout: post
title: Nemomobile in January 2023
excerpt: 
modified: 2023-01-28
author: jmlich
tags: ["USB moded", "x86", "Controls"]
image:
  feature: ./2023-01-28-nemomobile-in-january-2023/photo1674831526.jpeg
  teaser:  ./2023-01-28-nemomobile-in-january-2023/photo1674831526.jpeg
  thumb:   ./2023-01-28-nemomobile-in-january-2023/photo1674831526.jpeg

---

In January, various improvements and bug fixes were made to the NemoMobile. These updates include improvements to the x86 installation manual, fixes to the glacier-settings developer mode, and enhancements to the time picker component. Additionally, USB moded settings have been updated to work with MTP, and issues such as disconnecting from the internet and a typo in the polkit agent service definition have been addressed. Notifications have also been improved.

## x86 installation manual

The [installation manual](https://nemomobile.net/installation/) for x86 architecture and/or virtualbox has been updated to include
additional steps for running the lipstick compositor as the desktop environment. In addition to installing packages, configuration
files and user setup are now necessary for proper installation. This includes providing device-specific configuration files, such
as `/var/lib/environment/compositor/*` and `/etc/eglfs-config.json`, as well as ensuring that the user is a member of the appropriate
groups, as demonstrated in the creation of the manjaro user when creating the image.

## Developer mode

The developer mode is a glacier-settings plugin that allows for turning on and off the SSH daemon. There have been some fixes in the use
of [D-Bus interface](https://github.com/nemomobile-ux/glacier-settings-developermode/pull/3), as well as improvements in the handling of
[activating and deactivating states](https://github.com/nemomobile-ux/glacier-settings-developermode/pull/4). Additionally, the D-Bus
permission settings have been fixed to be [installed in the correct folder](https://github.com/nemomobile-ux/glacier-settings-developermode/pull/2).

<iframe width="560" height="315" src="https://www.youtube.com/embed/Nx4To_R1RLM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## glacierconfig --help

The command-line tool glacierconfig, which is part of the libglacierapp package, now has a [--help option](https://github.com/nemomobile-ux/libglacierapp/pull/11), and one typo has been fixed.

## Time picker

The time picker component is part of the Qt Quick controls for Nemo. It now [handles the mouse move event](https://github.com/nemomobile-ux/qtquickcontrols-nemo/pull/37),
which improves the smoothness of use and enhances the user experience. You can test the basic implementation
in the glacier-components application. The component is also used in the glacier-alarms, but some tuning may
be necessary to reach an acceptable level of usability.

<iframe width="560" height="315" src="https://www.youtube.com/embed/_pwqHKkDVno" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## MTP via USB

Previously, the usb-moded settings were fixed to get the daemon working. Now, the
configuration has [been cleaned](https://github.com/nemomobile-ux/nemo-packaging/pull/211)
and [settings required for MTP](https://github.com/nemomobile-ux/nemo-packaging/pull/210)
(Media Transfer Protocol) have been added.

<iframe width="560" height="315" src="https://www.youtube.com/embed/XaICulr68T4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## Disconnecting from the internet

The button to [turn off the mobile internet connection](https://github.com/nemomobile-ux/main/issues/38) was not working.
Now, both the button on the feeds page and the glacier-settings plugin allow for disconnecting from the internet. The
autoconnect behavior is probably controlled via connman, and it needs to be fixed yet. There were related fixes in the
[libqofono example](https://github.com/sailfishos/libqofono/pull/17) application.

## Infinite swiping on home screen

An [issue with infinite swiping](https://github.com/nemomobile-ux/main/issues/27) on the home screen had been present
for a long time. The previously proposed fix had issues with window transparency and did not function as expected.
However, it has now been rebased on the current master branch and is working as expected.

## Notification cleanup, invoking of remote action

The [notifications layout](https://github.com/nemomobile-ux/glacier-home/pull/220) has been tuned a little and the strings’
positions have been rearranged. Additionally, the [remoteAction trigger](https://github.com/nemomobile-ux/glacier-home/pull/221)
should now work. The remoteAction is a mechanism in notifications that invokes a function via D-Bus. For example, when an SMS
message arrives, the notification is created. After clicking on that notification, the Glacier Messages application window
is shown, and the conversation is opened.

<iframe width="560" height="315" src="https://www.youtube.com/embed/DtvDROS161s" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## Development Images

As there has not been an official image release for some time, development images are
available at [https://nemo.mlich.cz/images/](https://nemo.mlich.cz/images/). These images
are based on recent commits in git and come with all the associated consequences.