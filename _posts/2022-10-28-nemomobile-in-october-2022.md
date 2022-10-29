---
layout: post
title: Nemomobile in October 2022
excerpt: 
modified: 2022-10-28
author: jmlich
tags: ["Music", "Hacktoberfest", "Battery", "Qt6", "Dialer", "Pin Query"]
image:
  feature: ./2022-10-28-nemomobile-in-october-2022/hacktoberfest.jpg
  teaser:  ./2022-10-28-nemomobile-in-october-2022/hacktoberfest.jpg
  thumb:   ./2022-10-28-nemomobile-in-october-2022/hacktoberfest.jpg

---

Nemomobile also joined [hacktoberfest](https://hacktoberfest.com/) event by adding the tag to a few repositories.
All contributors are welcome in other months also. Main developer Sergey Chupligin has moved outside of Russia.
Some infrastructure is still in Russia. The settings application has fixed translations for plugins and new battery
health settings. There is some progress on Qt6 support. The dialer and pin query app is going closer to proposed
graphical design.

## Settings application translations

The settings application functionality was previously moved into plugins. Its translations were [split apart](https://github.com/nemomobile-ux/glacier-settings/commit/13e6163c4478da74068bb799890b38cd46f0959f)
as well. As a consequence, the existing translations are preserved.

![](/images/2022-10-28-nemomobile-in-october-2022/settings.png){: height="500"}

## Battery health settings

The power save plugin for the glacier settings application was extended with a [battery health](https://github.com/nemomobile-ux/glacier-settings/commit/7aebea74600ea172a3fdf539e7592dd0052ba4d3)
dialog. It was updated in order to allow settings of the threshold for start and end charging. This may extend battery life. 

![](/images/2022-10-28-nemomobile-in-october-2022/health.jpg){: height="400"}

## Music application is being migrated to plugins

[Big rework](https://github.com/nemomobile-ux/glacier-music/pull/33) of the Music application is in progress.
In the end, it should be possible to add different audio sources such as podcasts, audio books, or internet radios.

## Moving towards Qt6

The target and reasons are probably clear. We would like to keep pace with the rest of the world and to
be able to use the latest and greatest technologies. It is needed to update all libraries in the chain.
For start, it is [mlite](https://github.com/sailfishos/mlite/pull/4), [libglacierapp](https://github.com/nemomobile-ux/libglacierapp/pull/7).
Then, the migration of Qt Quick Controls Nemo to Qt Quick Controls 2 [can be started](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/67bb2e018b909c70fa65ca6c3d133332d979ce55).

## Facelift of Dialer and PIN Query

The proposal for [controls layout](https://github.com/qwazix/glacier-controls-spec/blob/master/numpad-static/numpad-static.pdf) from qwazix exists since 2017.
The [dialer](https://github.com/nemomobile-ux/glacier-dialer/pull/62) application and [PIN Query](https://github.com/nemomobile-ux/glacier-pinquery/pull/18) application
were updated in order to get closer to that proposal. However, there is still oFono related issue with detection if is PIN required. Similar to voice calls and switching of audio profiles. 


![](/images/2022-10-28-nemomobile-in-october-2022/dialer-pin-query.png){: height="500"}

