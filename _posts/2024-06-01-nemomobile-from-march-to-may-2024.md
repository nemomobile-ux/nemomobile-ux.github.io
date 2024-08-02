---
layout: post
title:  Nemomobile from March to May 2024 
excerpt: 
modified: 2024-03-01
author: jmlich
tags: ["Bluetooth", "Manjaro", "Open Build Service", "Lipstick"]
image: 
  feature: 2024-06-01-nemomobile-from-march-to-may-2024/photo1711281385.jpeg
  teaser: 2024-06-01-nemomobile-from-march-to-may-2024/photo1711281385.jpeg
  thumb: 2024-06-01-nemomobile-from-march-to-may-2024/photo1711281385.jpeg

---


News has been ongoing since February, with progress made in several areas. Porting to OpenSuSE continues,
issues in Manjaro-based images are being addressed, the maliit keyboard has been improved, and the Bluetooth
dialogs in Lipstick are being reworked.

The porting to OpenSuSE is being continued. Glacier-settings has been successfully started by Michał in OpenSuSE.
Currently, there are 103 working packages in the [OBS repository](https://build.opensuse.org/project/show/devel:NemoMobile).

The fixing of issues in Manjaro-based images is also ongoing. Most of these issues are related to the transition to Qt6
and the move away from telepathy-qt. For example, the Qt6-based mlite package was renamed to mlite6, and dependencies
were updated accordingly. The entire development can be found on the [Manjaro GitLab](https://gitlab.manjaro.org/manjaro-arm/packages/community/nemo-ux).
The builds are being done against the Manjaro unstable branch. New [image builds](https://github.com/nemomobile-ux/nemo-images/releases) have even been made possible.

Work has been done by Sergey on the maliit keyboard, and it has been possible to run and use the Telegram client with the on-screen keyboard.

![](/images/2024-06-01-nemomobile-from-march-to-may-2024/photo1710420913.jpeg){: width="500"}



The [Bluetooth dialogs in Lipstick](https://github.com/nemomobile-ux/lipstick/pull/74) are being reworked. This includes the OBEX agent
for file transfers and the authentication agent, which should allow for entering passwords or simply confirming actions.

Lipstick and some other packages are now utilizing [logging categories](https://github.com/nemomobile-ux/lipstick/commit/699260c7d4a7b7e21d7b1711b47c81400137c3d2)
(`Q_LOGGING_CATEGORY`), which allows effective filtering of debugging messages.

Previously, the [application was crashing when it was closed](https://github.com/nemomobile-ux/lipstick/commit/09358e6bda2446754d66b80e38586bde6300da0a);
now it is correctly terminated. The fix comes from the [AsteroidOS project](https://asteroidos.org/). Thanks!