---
layout: post
title: Nemomobile in June 2022
excerpt: 
modified: 2022-07-28
author: jmlich
tags: ["Settings", "Camera"]
image:
  feature: ./2022-07-28-nemomobile-in-july-2022/pinephone-postmarketos.jpg
  teaser: ./2022-07-28-nemomobile-in-july-2022/pinephone-postmarketos.jpg
  thumb: ./2022-07-28-nemomobile-in-july-2022/pinephone-postmarketos.jpg

---

There weren’t many changes due to the holiday season. The changes were in libconnman-qt, Settings
application, and Camera application. Translations are getting better. Packages are moving into
Manjaro repositories.

## libconnman-qt

The previously mentioned issue with recompilation libconnman-qt package in GCC 12 was resolved by the WebOS
team and [merged to upstream](https://github.com/sailfishos/libconnman-qt/pull/9). This is how the open
source software is supposed to work. Thank you, guys!

## Glacier settings plugins rework

The glacier settings [architecture has changed](https://github.com/nemomobile-ux/glacier-settings/pull/125).
Previously, there were some JSON with descriptions of items in the main menu and names of the QML file to load.

Now each item in the menu has its own shared object (*.so) in the `/usr/lib/glacier-settings` directory.
This allows changing the list of settings plugins dynamically including removing some items entirely, for
example when some hardware is not available. Items can be updated on the fly. For example, the current
status of the wifi connection can be shown now.

![](/images/2022-07-28-nemomobile-in-july-2022/screenshot-settings.png){: height="400"}

## Camera application

Support for the PinePhone camera seems to be just around the corner. With the right kernel and libcamera
it is possible to get the camera output to the screen with the [GStreamer API](https://gitlab.com/tui/tui/-/tree/master/cam).
This should be just a little step away from Qt Multimedia API. The colorimetry issue was addressed
in this [libcamera branch](https://github.com/RISHI27-dot/libcamera/tree/colorspace_integration_patch).

In the meantime, the glacier camera application was updated to be able to take a picture when the
[focus mode](https://github.com/nemomobile-ux/glacier-camera/pull/22/files) is not available. This
is the case of USB cameras redirected into the virtual machine.

![](/images/2022-07-28-nemomobile-in-july-2022/screenshot-camera.png){: height="400"}

## Translations are moving forward

Polish 🇵🇱 translation reached 100% at some point in time. Many other languages are in good shape and ready to use.

At the same time, we are thinking about how to avoid translating things that will be removed, and how not to
lose translations when reorganizing code. Right now it doesn’t make much sense to translate the mail application
as it has very raw edges and it will be likely reworked.

## Moving closer to Manjaro

We have had own [group in the Manjaro Gitlab](https://gitlab.manjaro.org/manjaro-arm/packages/community/nemo-ux) for
a long time, but we are using mainly the [Github repository](https://github.com/nemomobile-ux/nemo-packaging/) because
it allows us to use the workflow with forks and pull requests. Nevertheless, Sergey and FK are rebuilding the packages
and updating the packages repositories manually. It means also removing the -git suffix from the package names. This
should allow building the Nemomobile with the Manjaro repositories only without any extra repositories.

After finishing that new release will be published.

## Bugs to solve

Phone calls still do not work. The [audio profiles aren’t switched](https://github.com/nemomobile-ux/main/issues/34) automatically.

Qt Quick Controls in [desktop mode and orientation](https://github.com/nemomobile-ux/main/issues/39) of non-glacier
apps doesn’t work properly. For desktop development it may be better to stay at [`f54be1f`](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/f54be1fd8baebb5d29368fbb00619ca038791440) commit.

![](/images/2022-07-28-nemomobile-in-july-2022/screenshot-orientation-bug.png){: height="400"}
