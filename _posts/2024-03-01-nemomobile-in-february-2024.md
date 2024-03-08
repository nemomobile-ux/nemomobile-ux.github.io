---
layout: post
title: Nemomobile in February 2024
excerpt: 
modified: 2024-03-01
author: jmlich
tags: ["Conference", "FOSDEM", "Maliit", "Qt6", "NGFD"]
image: 
  feature: 2024-03-01-nemomobile-in-february-2024/image20240203_095538296.jpg
  teaser: 2024-03-01-nemomobile-in-february-2024/image20240203_095538296.jpg
  thumb: 2024-03-01-nemomobile-in-february-2024/image20240203_095538296.jpg

---


In February, numerous fixes were implemented in Nemomobile. Lipstick is no longer crashing.
The Maliit on-screen keyboard is now appearing. Key controls improvements have been made to
the qt quick controls in Nemo. Furthermore, the NGFD settings have been fixed. Additionally,
the project was showcased at the FOSDEM conference as part of the Linux on Mobile stand.

In previous builds, the Lipstick compositor experienced [crashing issues when setting the top-level window](https://github.com/nemomobile-ux/lipstick/commit/68af06a4a26e2ba288ee94b3ad59ae1d9519633b).

Progress has been made in [porting the Maliit on-screen keyboard to Qt6](https://gitlab.manjaro.org/manjaro-arm/packages/community/nemo-ux/maliit-framework-qt6/-/commit/0e2b99e013cbf0a96f46014beb86296b066e0a33),
moving the project forward. As a result, the on-screen keyboard now successfully appears.

![](/images/2024-03-01-nemomobile-in-february-2024/photo1707743430.jpeg){: width="180"}

Following the resolution of issues with the compositor and on-screen keyboard, development of the user experience can now resume. Furthermore, the qt quick controls in Nemo have been enhanced with keyboard navigation support.

<iframe width="560" height="315" src="https://www.youtube.com/embed/5MXsZtWLGFs?si=55mpdqsHQYG0AnD_" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

For a period of time, there were issues with the Non-Graphical Feedback Daemon (NGFD), which handles
the sound notifications for incoming phone calls or messages. The crashing of NGFD has been addressed
in previous fixes, and now the correct configuration file for [PinePhone has been provided](https://github.com/neochapay/nemo-device-dont_be_evil/commit/92bac87f800f54d4f89e3592ab4159ff1b9358da),
resolving the issue.

<iframe width="560" height="315" src="https://www.youtube.com/embed/CnNRKA1953U?si=UlmmcrcJg5Nlbe4V" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

We were fortunate to showcase the results of our work at FOSDEM, Europe’s largest open-source event.
Nemomobile was featured as part of the [Linux On Mobile](https://www.linuxonmobile.net/) stand,
alongside other mobile Linux platforms such as postmarket OS, Sailfish OS, Ubuntu Touch, AsteroidOS,
and others. It was a pleasure to reconnect with old friends and engage in discussions about future
development. Currently, Nemomobile remains in a very raw state, resembling more of a toy project
or sandbox for experimenting with new ideas.
