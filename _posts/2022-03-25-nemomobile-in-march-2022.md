---
layout: post
title: Nemomobile in March/2022
excerpt: 
modified: 2022-03-25
author: jmlich
tags: gps contacts calendar
image:
  feature: ./2022-03-25-nemomobile-in-march-2022/index.jpg
  teaser: ./2022-03-25-nemomobile-in-march-2022/index.jpg
  thumb: ./2022-03-25-nemomobile-in-march-2022/index.jpg

---

GPS support has made a huge step forward again. The operating system components are being mostly updated only. Some smaller changes being done. The applications Contacts, Calendar, and Settings are getting a number of fixes. The new release of NemoMobile for PinePhone, PinePhone Pro and hopefully also PineTab is coming soon.

## GPS

The QtLocation API includes both geoclue and geoclue2 providers. Position can be obtained from GPS or from other sources.
For example from the geoclue-providers-mlsdb. The mlsdb stands for [Mozilla Location Services Database](https://location.services.mozilla.com/)
and it enables the position to be obtained via wifi bsid, bluetooth mac, and/or cell tower id.

The [settings page](https://github.com/nemomobile-ux/glacier-settings/commit/ae6f13fd0388938c31383ec475892204afa8fcc8) and
[geoclue provider](https://github.com/nemomobile-ux/nemo-packaging/commit/96aa09448149626e53b1fb97cea871ded378e166) was
updated in order to allow enabling satellites location and location over online services independently.

![](/images/2022-03-25-nemomobile-in-march-2022/gps.jpg){: height="400"}


## Parts of OS

There was an issue with showing of [transparent application window when background wasn’t set](https://github.com/nemomobile-ux/qtquickcontrols-nemo/pull/28).

If you are looking for a difficult task to debug then you can take a look at compilation of [buteo-mtp](https://github.com/sailfishos/buteo-mtp/pull/9).
It seems the Link Time Optimization (-flto flag for gcc) is causing undefined reference. For now we have
[removed unit test](https://github.com/nemomobile-ux/nemo-packaging/commit/213f97dcc40e57de0bcb7e5192bfc6fee122fb31) which
wasn’t compiling.

Recently the German translations of Nemo got some love. The translations are frequently updated also in Czech, Polish, and Russian.

## Applications

The calendar application received [small improvements](https://github.com/nemomobile-ux/glacier-calendar/pull/11) in layout.
There is one interesting or hard problem to solve. The placement of the events on the screen. It must be computed with
respect to overlap with other events. Currently used algorithm is rather simple and works well for some cases, but will
badly fail for other cases. Previously, the boxes were rendered over each other so other events wasn’t visible at all.

![](/images/2022-03-25-nemomobile-in-march-2022/calendar.png){: height="400"}

The contacts application received some fixes. Most importantly, [editing and deleting of contacts](https://github.com/nemomobile-ux/glacier-contacts/issues/35)
is now possible. There were many other changes. The contact editor can [modify many more fields](https://github.com/nemomobile-ux/glacier-contacts/pull/60).
Contact details such as birthday or website are shown in the contact card.

There is long way to go yet. I haven’t found a way to rename contacts. It seems that displayName field is still the same.
Some fields such as notes or anniversaries are editable, but the user experience is rather bad. The date must be entered
in a certain format and it is not possible to select type of anniversary. Notes should be shown in text area rather than
text field. The Import button doesn’t import the contact avatar. As a workaround the `vcardconverter` command could be used.
It seems there is some regression in glacier-gallery or more likely in [qtdocgallery](https://github.com/sailfishos/qtdocgallery),
because changing of avatar or gallery app doesn’t show any picture anymore.

<iframe width="560" height="315" src="https://www.youtube.com/embed/mq14LUck4e8" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The settings application also got some improvements. Now it is possible to
[disable certain settings plugins](https://github.com/nemomobile-ux/glacier-settings/commit/b8ae00d559d29c6e28c91cc4c2887d83eb7514e2).
This can improve user experience on devices without some hardware. For example it doesn’t make much sense to show mobile internet
settings when a modem is not present. Additionally, the keyboard selection dialog was simplified, the brightness settings in pulley
menu now allows switching to automatic brightness. The [RightCheckbox](https://github.com/nemomobile-ux/glacier-settings/commit/33fcbbfb0caf8b224456e409c22c95d5d758b0a4)
component was introduced, which caused a big cleanup and polishing a lot of code.

## Task to start with

You can try to add your local keyboard layout. The place to start is the [maliit-nemo-keyboard layout](https://github.com/nemomobile-ux/maliit-nemo-keyboard/blob/master/qml/org/nemomobile/layouts.js).
Displaying of accents seems to be not implemented yet.