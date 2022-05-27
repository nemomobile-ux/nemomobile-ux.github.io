---
layout: post
title: Nemomobile in May 2022
excerpt: 
modified: 2022-05-27
author: jmlich
tags: ["Rotation", "Dialer", "Gallery", "Controls", "Conference"]
image:
  feature: ./2022-05-27-nemomobile-in-may-2022/pinephone.jpg
  teaser: ./2022-05-27-nemomobile-in-may-2022/pinephone.jpg
  thumb: ./2022-05-27-nemomobile-in-may-2022/pinephone.jpg

---

What is new in May? The rendering of the home screen, applications, and keyboard orientation
were improved. The dbus permission was fixed. Now it is possible to answer the phone calls,
but the audio still doesn’t work. Glacier-gallery and QtQuick Controls Nemo got some improvements.
Gtk applications have a keyboard. Nemo will be at two conferences in June.

## Window orientation

It might sound like a [trivial task](https://github.com/nemomobile-ux/main/issues/39), but many places
of code need to cooperate together. The sensors need to provide the right information. The glacier-testtool
was improved in order to show [human-readable string](https://github.com/nemomobile-ux/glacier-testtool/commit/a244055b70bae4c275fa71297d6620f087fed4d6)
instead of magic numbers. It helps to understand if input data needs some transformation. So it could be
verified after the change of the [transform matrix](https://github.com/nemomobile-ux/nemo-device-cutiepi/commit/8469a1290c3af2d11e5936f6ae95d9210facc4b3) (CutiePi).

Then UI must be fixed. There are multiple components: lipstick, glacier-home, maliit, and application. The glacier-applications are using qtquickcontrols-nemo.

Glacier-home and lipstick must render the home screen and [AppSwitcher thumbnails](https://github.com/nemomobile-ux/glacier-home/commit/5852cdfa8031cbad189247a2cbf4ca16baa6f057)
properly. The glacier apps are detecting if the keyboard is visible and adjusts the size of the page accordingly. Additionally, also non-glacier applications must be rendered properly.

The last thing, glacier-settings now has an option to lock the screen in portrait, or landscape, or keep it dynamic.

<iframe width="560" height="315" src="https://www.youtube.com/embed/d3k8IY38vzw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Phone Calls

The phone call is probably the most important feature that everyone expects from a phone.
We are moving slowly forward. There are a number of libraries involved. The glacier-dialer
is going through voicecalld to ofono which should send the right command to modem and
switch pulse audio profiles.

It seems we were stuck at [SailfishOS permission model](https://github.com/neochapay/ofono-new/blob/branch-1.34-qmi/ofono/plugins/sailfish_access.c#L48)
which was checking if the current user is a member of the group `privileged`. Some tuning
in `/etc/dbus-1/system.d/ofono.conf` might be still necessary. After that, it is possible
to answer or reject phone calls. The audio profiles are still not switched.

<iframe width="560" height="315" src="https://www.youtube.com/embed/M7z-WVSs0Rg" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The dialer application had an issue with [contact lookup](https://github.com/nemomobile-ux/glacier-dialer/commit/aafba4ecf484981a2a415b0647441e43ac63c779)
so the contact avatar and name weren’t shown even when were known. [Contact search](https://github.com/nemomobile-ux/glacier-dialer/commit/62e232d1b0eccdb5bbd5549c6303755c5b6648a9)
was also fixed. The [microphone and speaker controls](https://github.com/nemomobile-ux/glacier-dialer/commit/9dde2092f72d5461d532ff8f9de9d67a03aa6649) were
added. It didn’t help with audio profiles, unfortunately.

At the same time, there is an issue with [turning off cellular data](https://github.com/nemomobile-ux/main/issues/38).

A new version of the [libphonenumber](https://github.com/nemomobile-ux/nemo-packaging/commit/c99369dda79e96eec536703e029ad3654c3bac4c) package was added.

## Gallery

The gallery application was reworked. It obtained a list view with thumbnails shown on the
bottom of the window and an editor of images that currently allows rotating and flipping the image.

<iframe width="560" height="315" src="https://www.youtube.com/embed/Gfa6iV_efsA" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Improvements of backend

There was a new build of libicu package, which forced us to rebuild nemo-qml-plugin-contacts.
The dependency was changed to the [exact](https://github.com/nemomobile-ux/nemo-packaging/commit/e84ec565c20d1faec1888d9db03767870c5d042d)
version we will see if this breaks updates in the future.

The most visible will be a change in the page header. There is a [bouncing indicator](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/034bf4550438b78fccba199fbc95d5733a781a0c)
that shows that the drawer contains some items. Also, [Button and ListViewItemWithAction](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/f54be1fd8baebb5d29368fbb00619ca038791440)
styles were updated a little bit.

<iframe width="560" height="315" src="https://www.youtube.com/embed/a6zepyStJ18" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

For maliit on-screen keyboard, we have now [maliit-input-context-gtk](https://github.com/nemomobile-ux/nemo-packaging/pull/163)
package which allows keyboard in Gtk apps. The [Gtk4 support](https://github.com/maliit/inputcontext-gtk/issues/4) is
unfortunately not implemented. For example, midori browser can be started. It does work, but showing the popup window
separately in lipstick could be confusing.

![](/images/2022-05-27-nemomobile-in-may-2022/midori-keyboard.png){: height="400"}


## Conferences

There will be at least two talks about NemoMobile in June. The [DevConf Mini](https://www.devconf.info/cz/)
will be on 2nd June in Brno, Czech Republic. The [NemoMobile talk](https://devconfczmini2022.sched.com/event/11l5m/current-status-of-nemomobile) will
be at 4pm CEST. The conference language is English. It is expected that talks will be recorded and published after the conference.

![](/images/2022-05-27-nemomobile-in-may-2022/devconf.jpg)

The second talk will be at [Installfest.cz](https://installfest.cz/if22/) conference which will be in Prague, Czech Republic on 11th June.
The [Nemomobile talk](https://pretalx.installfest.cz/installfest-2022/talk/VV7FRB/) will be at 11am. It is also expected, that
the conference will be streamed online, but both the conference and the talk language will be in Czech.

![](/images/2022-05-27-nemomobile-in-may-2022/installfest.png)

