---
layout: post
title: Nemomobile in December 2022
excerpt: 
modified: 2022-12-31
author: jmlich
tags: ["Qt6", "Pin Query", "Titan Slim", "Design", "Bugs", "Packaging"]
image:
  feature: ./2022-12-31-nemomobile-in-december-2022/pf2023.jpg
  teaser:  ./2022-12-31-nemomobile-in-december-2022/pf2023.jpg
  thumb:   ./2022-12-31-nemomobile-in-december-2022/pf2023.jpg

---

There has been significant progress in porting NemoMobile to Qt6, with various improvements
implemented in Lipstick and Glacier Home, including changes to the notification screen based
on new UX discussions. A prototype of a Github Actions-based continuous integration system
has also been developed, and various small fixes have been made to other components. In addition,
experiments have been conducted in porting Nemo to the Titan Slim device. The Advent of Code has
summarized the current list of most visible bugs, and the project is currently discussing the
roadmap for 2023. We invite you to join the discussion.

## Porting to Qt6

There isn’t much to say. Many pull requests have been opened:

-    [https://github.com/sailfishos/libresourceqt/pull/3](https://github.com/sailfishos/libresourceqt/pull/3)
-    [https://github.com/sailfishos/libiodata/pull/3](https://github.com/sailfishos/libiodata/pull/3)
-    [https://github.com/sailfishos/timed/pull/3](https://github.com/sailfishos/timed/pull/3)
-    [https://github.com/sailfishos/libmce-qt/pull/2](https://github.com/sailfishos/libmce-qt/pull/2)
-    [https://github.com/sailfishos/libngf-qt/pull/4](https://github.com/sailfishos/libngf-qt/pull/4)
-    [https://github.com/sailfishos/libusb-moded-qt/pull/2](https://github.com/sailfishos/libusb-moded-qt/pull/2)
-    [https://github.com/sailfishos/libqofono/pull/14](https://github.com/sailfishos/libqofono/pull/14)
-    [https://github.com/sailfishos/nemo-qml-plugin-time/pull/3](https://github.com/sailfishos/nemo-qml-plugin-time/pull/3)
-    [https://github.com/sailfishos/nemo-qml-plugin-configuration/pull/4]([https://github.com/sailfishos/nemo-qml-plugin-configuration/pull/4)
-    [https://github.com/nemomobile-ux/lipstick/pull/67](https://github.com/nemomobile-ux/lipstick/pull/67)

And related development branches:

-    [https://github.com/nemomobile-ux/qtquickcontrols-nemo/commits/dev](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commits/dev)
-    [https://github.com/nemomobile-ux/glacier-home/tree/qt6](https://github.com/nemomobile-ux/glacier-home/tree/qt6)

It builds fine, but the plugins and controls development can now be started.

## Titan Slim

TheKit managed to start Nemo on Titan Slim. The device was able to display, but something was missing for the touchscreen. The device lacks kernel sources.

![](/images/2022-12-31-nemomobile-in-december-2022/titan.jpg){: width="400" }

## New UX progress

The discussion about the new user experience is [still open](https://github.com/nemomobile-ux/main/issues/41).
The notifications screen [was updated](https://github.com/nemomobile-ux/glacier-home/pull/208) to match the new
design. See the provided screenshots.

![](/images/2022-12-31-nemomobile-in-december-2022/new-notifications.jpg){: width="100%" }

There is also a [new animation](https://github.com/nemomobile-ux/glacier-home/commit/b432253ad99dabcdf75d64ceca8ed2f168410a10)
when the application is launched.

<iframe width="560" height="315" src="https://www.youtube.com/embed/hoiRE_XPwvc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Advent of Code

The [advent of code](/pages/advent-of-code/) challenge brought some attention to the project. Here is a summary of tasks:

- ✓ Setup SDK  
It was training task which is quite good described.
- [Pinch to zoom](https://github.com/nemomobile-ux/glacier-gallery/issues/20) function in glacier-gallery
- Week and year view in [glacier-calendar](https://github.com/nemomobile-ux/glacier-calendar/)
- Turning on and off the flash light
- ~ Continuous Integration  
  There is a draft or work in progress of [Continuous integration with Github Actions](https://github.com/jmlich/glacier-home/blob/master/.github/workflows/build.yml).
  Aarch64 build needs to be added and its arguments need to be verified and fixed.
- ✓ Broken on screen keyboard  
In fact, there is an issue with the maliit-framework package. Rebuilding the package resolves the issue.
- [Cannot store photos](https://github.com/nemomobile-ux/glacier-contacts/issues/64) in glacier-contacts
- Maliit-input-context-gtk doesn’t work with gtk4
- ~ [Orientation still doesn’t work properly](https://github.com/nemomobile-ux/main/issues/39)  
There were actually [some](https://github.com/nemomobile-ux/glacier-home/commit/ce6b2bd7eb01d8ed59480cb192e3f4a30b72d89d)
[fixes](https://github.com/nemomobile-ux/glacier-home/commit/89cb775cfab304544b7c5817a100e6d644ace919), but it is still not finished.
- ✓ Glacier-pinquery doesn’t detect that a PIN is required properly  
This was actually [fixed](https://github.com/nemomobile-ux/glacier-pinquery/pull/19), although there is still
a lot of work to be done on it. For example, support for multiple SIM cards is missing.

<iframe width="560" height="315" src="https://www.youtube.com/embed/ZGL0q-oaFjQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

- Mysterious /usr prefix
- Synchronization of calendars with Google
- Sending of SMS messages doesn’t work
- ~ usb-moded doesn’t switch to developer mode  
There were a few fixes made to the usb-moded [startup](https://github.com/nemomobile-ux/nemo-packaging/commit/8235827b2551ef3f85c756bc962063d8f7ad849f).
There is still an issue with modules-load and MTP.

<iframe width="560" height="315" src="https://www.youtube.com/embed/59pGRgUBVho" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


- ~ GStreamer camera pipeline doesn’t work  
It seems that the SailfishOS, libcamera, and kernel teams have managed to fix the issue. It is just a matter of compiling the right source codes.
- [Swipe in the loop](https://github.com/nemomobile-ux/main/issues/27) on the home screen doesn’t work
- [PulseAudio profiles are not switched for voice calls](https://github.com/nemomobile-ux/main/issues/34)
- Notifications are not able to open glacier-messages
- Haptic feedback doesn’t work
- Unable to uninstall packages from the UI
- Modem is connected all the time and [it is not possible to disconnect](https://github.com/nemomobile-ux/main/issues/38)
- MTP USB mode doesn’t work
- Call history (e.g. missed calls) is not stored
- Email client is broken

## Improvements, bug fixes, and packaging


- The nemo-ux packages (i.e. Manjaro) were synchronized with our downstream nemo-packaging repository,
and deprecated Manjaro packages were removed. A new iteration of binary packages was published
at [https://img.nemomobile.net/manjaro/05.2023/stable/aarch64/](https://img.nemomobile.net/manjaro/05.2023/stable/aarch64/).
- The interface of glacier-settings was fixed, [allowing settings to be called from services](https://github.com/nemomobile-ux/glacier-settings/commit/b48f9d55f63c4f898d4fc183a896cc62ae04eb51).
- The lipstick volume plugin was [migrated to libresource](https://github.com/nemomobile-ux/lipstick/pull/66).
It still requires pulse audio modules and configuration from SailfishOS.
- The Sliders in qtquickcontrols-nemo was ajdusted to match [selected color scheme](https://github.com/nemomobile-ux/qtquickcontrols-nemo/pull/36)

![](/images/2022-12-31-nemomobile-in-december-2022/sliders.png){: width="600" }

- The glacier-messages now [displays the time](https://github.com/nemomobile-ux/glacier-messages/pull/18) of
each message. A [test script](https://gist.github.com/jmlich/d66cd4c6bf46ba1bc279a3201cc76a5a) can be used to populate the history of glacier-messages.


![](/images/2022-12-31-nemomobile-in-december-2022/messages-before.png){: width="300" }
![](/images/2022-12-31-nemomobile-in-december-2022/messages-after.png){: width="300" }

- A [typo in the systemd unit](https://github.com/nemomobile-ux/glacier-polkit-agent/pull/8) of
glacier-polkit-agent was fixed, and it is now [enabled by default](https://github.com/nemomobile-ux/nemo-packaging/commit/37f35d89c41d052c298d1de4b62593d56f32fd0d).

![](/images/2022-12-31-nemomobile-in-december-2022/polkit-agent.png){: width="300" }

## Roadmap for 2023

The project is currently discussing the roadmap for 2023 and the discussion is open for input. Please visit [https://github.com/nemomobile-ux/main/wiki/Roadmap-2023-(Draft)](https://github.com/nemomobile-ux/main/wiki/Roadmap-2023-(Draft)) to join the conversation.

Happy new year 2023!

