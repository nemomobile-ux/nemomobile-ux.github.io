---
layout: post
title: Nemomobile in November 2023
excerpt: 
modified: 2023-12-01
author: jmlich
tags: ["Qt6", "Maliit"]
image: 
  feature: 2023-12-01-nemomobile-in-november-2023/movember.jpg
  teaser: 2023-12-01-nemomobile-in-november-2023/movember.jpg
  thumb: 2023-12-01-nemomobile-in-november-2023/movember.jpg

---

In November, Nemomobile integrated Qt6, enabling 100+ packages, including Lipstick, 
for operational end-user apps. Crucial fixes include Maliit keyboard compatibility.
Qt Quick controls saw improvements. Compatibility achieved on Jelly Star.



Despite some imperfections in functionality, we have chosen to integrate the Qt6
branch of [Nemo-Packaging](https://github.com/nemomobile-ux/nemo-packaging/) into the master branch, given its considerable importance to us. More than 100 packages, including the Lipstick compositor, can now be built with Qt6 support. Notably, approximately half of our end-user apps are operational with this update.

At the same time, Sailfish OS, which maintains the upstream of many packages used in NemoMobile, is merging our pull requests and providing valuable feedback for the rest of them.

Most importantly, the issue of building the [Maliit](https://github.com/nemomobile-ux/nemo-packaging/blob/master/maliit-framework-qt6/0001-move_to_qt6.patch) software keyboard with Qt6 was addressed, allowing essential interactions with the UI, such as connecting to WiFi, to be performed without requiring an external keyboard.

![](/images/2023-12-01-nemomobile-in-november-2023/photo1699370346.jpeg){: width="300"}

The [font loading](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/2e6445a4ae311877952222fca09a3b457c8b3ea3) issue in Qt Quick controls has been resolved.

Nemo was successfully run on Jelly Star (Helio G99, Android 12) by TheKit, showcasing compatibility achievements.

![](/images/2023-12-01-nemomobile-in-november-2023/photo1701347089.jpeg){: width="300"}

P.S. As December approaches, we would like to remind you of the Advent of Code challenge we initiated last year. While new tasks won’t be published daily like last year, the concept remains valid: Fix one of Nemo’s bugs every day, and by Christmas, you will have a fully functional phone.