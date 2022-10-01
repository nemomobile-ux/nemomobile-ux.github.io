---
layout: post
title: Nemomobile in September 2022
excerpt: 
modified: 2022-09-30
author: jmlich
tags: ["Keyboard", "Controls", "Music", "postmarketOS"]
image:
  feature: ./2022-09-30-nemomobile-in-september-2022/featured.png
  teaser: ./2022-09-30-nemomobile-in-september-2022/featured.png
  thumb: ./2022-09-30-nemomobile-in-september-2022/featured.png

---

We are looking for a postmarketOS maintainer. There have been fixes for development with QtQuickControls
Nemo for the desktop environment. Development continues in glacier-music in a separate branch. The keyboard
with prediction packages is compiling on Manjaro. We have selected our code style to be the same as for Webkit.

## Controls on desktop

Qt Quick Controls Nemo is usable for development on the desktop again. The application will always have
a [portrait orientation on the desktop](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/d67545e8f9d6ae396aba9479148165032c75081a).
The following command could be used to switch into the desktop mode `glacierconfig -d enable`.

The `ListViewItemWithAction` now allows the definition of the icon independently. This allows the use of colorized icons or to turn off the shader effect if needed.

## Qt 5.15.6

The Qt was updated to 5.15.6 in Manjaro and ArchLinux. We are using qt5-sensors with sensorfw,
which is shipped in qt5-sensors-sensorfw package, it was also updated to 5.15.6.

## On-screen keyboard improvements

[Presage](https://github.com/sailfish-keyboard/presage) is a prediction module used in the Nemo maliit plugin.
It had some issues with compilation in Manjaro with `-Werror=format-security` the compiler flag.
The corresponding [code was fixed](https://github.com/sailfish-keyboard/presage/pull/31) also upstream.

## postmarketOS dropped Glacier UI

This is bad news indeed. PostmarketOS doesn’t ship Glacier UI anymore. PureTryOut asked
for help to fix an issue with starting lipstick, but we haven’t managed to find out what
is causing it. After some time he [removed it](https://gitlab.com/postmarketOS/pmaports/-/merge_requests/3433)
from postmarketOS repositories.

> I’m officially going to drop Glacier from postmarketOS due to me not being interested in maintaining it any longer, and it has been broken for ages with no clear cause (other than it being something in Lipstick).

The code is still around and you can still pick up the thrown gauntlet and start [maintaining it](https://wiki.postmarketos.org/wiki/Glacier).

## Music application

The music application got another big rework recently. It is still developed in a [separate branch](https://github.com/nemomobile-ux/glacier-music/tree/move_to_plugins).
The covers should work better. The code is cleaner and could be reused easier. Some parts were placed in separate modules.

## Code style

The code style is often a topic of flame wars on the internet. Some people prefer space before asterisk others vice versa.
We have decided to use [WebKit formatting](https://github.com/WebKit/WebKit/blob/main/.clang-format) as the only possible option.
The format is [checked by github actions](https://github.com/marketplace/actions/clang-format-check). We might include also github actions
with `qmllint` or `qmlformat`. Is there something working and easy to include?