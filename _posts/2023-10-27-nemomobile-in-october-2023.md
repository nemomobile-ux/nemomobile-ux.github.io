---
layout: post
title: Nemomobile in October 2023
excerpt: 
modified: 2023-08-27
author: jmlich
tags: ["Qt6", "Controls", "Telepathy", "Dialer", "Gallery", "Messsage"]
image: 
  feature: 2023-10-27-nemomobile-in-october-2023/ddb7ef0e-a03d-4090-b4fa-be41ac7b5169.jpg
  teaser: 2023-10-27-nemomobile-in-october-2023/ddb7ef0e-a03d-4090-b4fa-be41ac7b5169.jpg
  thumb: 2023-10-27-nemomobile-in-october-2023/ddb7ef0e-a03d-4090-b4fa-be41ac7b5169.jpg

---

In October, several improvements were made to Qt Quick Controls Nemo, including enhancements
to the main menu, the introduction of a back gesture for navigation, and a fix for icon
coloring. Additionally, efforts were underway to optimize the telephony stack by
reducing reliance on Telepathy.


## Enhanced Tablet User Interface

The Menu now incorporates a more [visually appealing](https://github.com/nemomobile-ux/qtquickcontrols-nemo/pull/43)
user interface, similar to the user experience provided by libhandy. When the application is displayed
on a tablet, the menu is situated on the left side, while the content is displayed on the right. On
smaller screens, the menu is presented as a separate page.

<iframe width="560" height="315" src="https://www.youtube.com/embed/PWyBtItretA?si=eTHSMpjbReCfUiBx" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## Returning to the Previous Page

The latest enhancement in Qt Quick Controls Nemo enables effortless navigation between pages through the use
of a back button or a [back gesture](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/c93440fecdbfbe6c4a66333f2462b19c34c40fab).
This functionality can be further enhanced by implementing an immediate UI response, similar to what
Sailfish OS offers.

<iframe width="560" height="315" src="https://www.youtube.com/embed/pGZr90iaqBk?si=AQBmGtCBNfuR1LLJ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## Shifting Away from Telepathy

While Telepathy has traditionally played a significant role in Nemomobile, its future role is currently uncertain, especially in light of compilation challenges with qt6. As of now, we are compiling
[libcommhistory](https://github.com/sailfishos/libcommhistory/pull/8), [voicecall](https://github.com/sailfishos/voicecall/pull/13),
[dialer](https://github.com/nemomobile-ux/glacier-dialer/commit/58cc7230785e6654261f466caf6719d991104699),
[contacts](https://github.com/nemomobile-ux/glacier-contacts/commit/a55150582f5f9c776d345c62d38fb947fdccf74f),
and [messages](https://github.com/nemomobile-ux/glacier-messages/commit/d5b5f36652068acf2849fc4428e501c4162ac5ea)
without the reliance on Telepathy. In the latest Git version, we’ve achieved the capability to handle incoming
calls and display responses for USSD control codes. The community is exploring alternative approaches as
Telepathy’s place in Nemomobile evolves.

![](/images/2023-10-27-nemomobile-in-october-2023/photo1697555680.jpeg){: width="300"}
![](/images/2023-10-27-nemomobile-in-october-2023/photo1697982669.jpeg){: width="300"}
![](/images/2023-10-27-nemomobile-in-october-2023/photo1697982862.jpeg){: width="300"}

## Progressing with Qt6 Porting

The transition to Qt6 is an ongoing effort. A pull request containing a patch
for [qtdocgallery](https://github.com/sailfishos/qtdocgallery/pull/6) has been submitted
for review, making it possible to build [glacier-gallery](https://github.com/nemomobile-ux/glacier-gallery/commit/a919ddc5814fff299e2424dc763b41c0d01d45cc).

Additionally, a bug within the Qt Quick Components, specifically in the Icon component, was causing
issues where shader effects didn’t properly [alter the color of the icon](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/a7532b684f4fb0e1ca63d33e8f60d5f6857aa7d2).
This issue has now been successfully resolved.


