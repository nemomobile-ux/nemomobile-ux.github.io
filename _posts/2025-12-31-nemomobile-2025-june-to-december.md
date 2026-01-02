---
layout: post
title:  Nemomobile 2025 June to December 
excerpt: 
    The progress is not as fast as all of us hope for, but development continues steadily.
    Recent work includes improvements to the device lock implementation, moving the platform
    towards openSUSE and OBS, various fixes and cleanups across Glacier components, 
    Qt 6–related updates, and successful testing on new hardware.
modified: 2025-12-31
author: jmlich
tags: ["OBS", "Open Build Service", "Lipstick", "Device lock"]
image:
  feature: 2025-12-31-nemomobile-2025-june-to-december/photo_5193074726468189971_y.jpg
  teaser: 2025-12-31-nemomobile-2025-june-to-december/photo_5193074726468189971_y.jpg
  thumb: 2025-12-31-nemomobile-2025-june-to-december/photo_5193074726468189971_y.jpg
comments:
  host: mastodon.social
  username: nemomobile
  id: 115821297780186780
---

The progress is not as fast as all of us hope for, but development continues steadily.
Recent work includes improvements to the device lock implementation, moving the platform
towards openSUSE and OBS, various fixes and cleanups across Glacier components, Qt 6–related
updates, and successful testing on new hardware.


## Device lock improvements

There were several fixes and improvements in the device lock implementation. Glacier Welcome
is started on first boot and allows the initial setup of the device lock code. The
devicelock-plugin is a daemon that handles password verification. In addition,
nemo-qml-plugin-devicelock provides an API for communicating with the daemon.

Glacier Home detects whether the service is running and locks the device if it is not.
The Glacier Settings application includes a plugin that allows users to change the
device lock password. The entire device lock flow was reviewed and thoroughly tested.


## Moving towards openSUSE

It turned out that Manjaro Linux ships some outdated components, such as Meson, GObject
Introspection, Mesa, and others. Because of this, fixing all dependencies just to rebuild
Lipstick would require significant effort. Using openSUSE proved to be a more practical approach.

As part of this transition, several packages in [OBS (Open Build Service)](https://build.opensuse.org/project/show/devel:NemoMobile)
were updated, including: `ngfd`, `libprolog`, `libtrace-ohm`, `ohm-plugin-misc`, `lipstick-glacier-home`, `systemd-user-session-target`,
and `nemo-mobile-session`, and others.

At the moment, installation is only possible manually. openSUSE provides a concept called patterns, which should eventually allow installation of all required packages and apply additional system settings automatically. Work on this is still in progress.

For debugging, the `DEBUG_COMPOSITOR_IS_WINDOW=y` environment variable was introduced, which allows the compositor to run in a window.

![](/images/2025-12-31-nemomobile-2025-june-to-december/photo_5269322082581941497_y.jpg){: height="250"}
![](/images/2025-12-31-nemomobile-2025-june-to-december/photo_5269322082581941536_y.jpg){: height="250"}
![](/images/2025-12-31-nemomobile-2025-june-to-december/photo_5859327078677809927_y.jpg){: height="250"}
![](/images/2025-12-31-nemomobile-2025-june-to-december/photo_5859327078677809928_y.jpg){: height="250"}
![](/images/2025-12-31-nemomobile-2025-june-to-december/photo_5859327078677809929_y.jpg){: height="250"}
![](/images/2025-12-31-nemomobile-2025-june-to-december/photo_5859327078677810222_y.jpg){: height="250"}


Currently, the installation process involves installing openSUSE JeOS (Just Enough OS), adding the OBS repository, and installing the required packages. After that, several manual configuration steps are still necessary.

These steps will likely include ensuring that the mce daemon is running, providing configuration files such as `/etc/eglfs-config.json`, and making sure the correct user groups exist (see
[https://github.com/nemomobile-ux/arm-profiles](https://github.com/nemomobile-ux/arm-profiles) and
[https://gitlab.manjaro.org/manjaro-arm/applications/manjaro-arm-tools/-/blob/master/lib/functions.sh](https://gitlab.manjaro.org/manjaro-arm/applications/manjaro-arm-tools/-/blob/master/lib/functions.sh)).

In the end, Lipstick was successfully brought up on openSUSE:

<iframe width="560" height="315" src="https://www.youtube.com/embed/-2mEQRadVa0?si=6IZnNVxKVkp1OAgm" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## Other fixes

There were many important changes and fixes across the stack.

A memory leak in the Glacier Home [search plugin was fixed](https://github.com/nemomobile-ux/glacier-home/commit/7925a34c1c6150920df644d25625d77e8c04c2c7).

Maliit was updated to the latest version, and the Nemo keyboard plugin [was adjusted](https://github.com/nemomobile-ux/maliit-nemo-keyboard/commit/d36e993a125c1f2c22014a9b1587d34eb74e53d6)
to the new Controls naming and updated to use the Qt 6 version of Maliit. As a result, the on-screen keyboard works again.

Drawer levels were removed from shared controls and from [Glacier Settings](https://github.com/nemomobile-ux/glacier-settings/commit/d3711d82e5e1037b78e4983957a8c516e08bc548) to
make the interface cleaner and simpler. Glacier Settings now also shows the Bluetooth plugin [only when the BlueZ daemon is enabled](https://github.com/nemomobile-ux/glacier-settings/commit/b919deb90fd62d3144e478036e5e1c18693c0aea),
and the same applies to time settings when timed daemon is not running.

Glacier Weather was split into a [daemon and a UI component](https://github.com/nemomobile-ux/glacier-weather/commit/ee16c0637c98f8c1afdc2584b1cd45df6970911a),
and the code was reorganized and cleaned up accordingly. This allows weather information to be updated in the background.

Finally, GeoClue was replaced by a custom implementation called [locationd](https://github.com/nemomobile-ux/locationd). The new implementation
is cleaner and should enable more advanced features, such as support for Mozilla Location Services.

Last but not least, Nemo Mobile was successfully started on the Beresta devkit.