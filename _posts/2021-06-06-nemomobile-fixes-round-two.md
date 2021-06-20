---
layout: post
title: Nemomobile fixes round two
modified: 2021-05-28
author: jmlich
tags: [main]
image:
  teaser: 2021-06-06-nemomobile-fixes-round-two/Screenshot_manjaro_2021-06-02_213439.png
  thumb: 2021-06-06-nemomobile-fixes-round-two/Screenshot_manjaro_2021-06-02_213439.png
---

Development of Nemo continues, hence I have new overview of fixed bugs. This time application launcher, Nemo Controls, glacier-gallery, and boosters.

# Drag and drop in application launcher

Application launcher drag zone size was computed in `Component.onCompleted:` probably before the window was created.
As result it has strange size. The fix was to use property binding and recompute the value when size changes. And
it is [already merged](https://github.com/nemomobile-ux/glacier-home/pull/145).

# Making and disposing folder

In application launcher, when you leave just one icon in folder it should transform folder to application launcher.
The Connection object contained function(modelData). The parameter refers to removed item, but it had the same name
as variable pointing to folder launcher. [The fix](https://github.com/nemomobile-ux/glacier-home/pull/146) is simly
using different name for variable.

![applauncher](/images/2021-06-06-nemomobile-fixes-round-two/1.gif "Application launcher drag and drop before and after") ![applauncher](/images/2021-06-06-nemomobile-fixes-round-two/2.gif "Application launcher drag and drop before and after")

# Incorrect drawer size

The Nemomobile brings own set of [graphical components](https://github.com/nemomobile-ux/qtquickcontrols-nemo),
which are widely used in Nemo’s native applications. The components can be easily used by inserting following
`import QtQuick.Controls.Nemo 1.0`. You may recognize font awesome icons which are nicely integrated into
library by the way.

```
Image {
     source: "image://theme/trash" 
}
```

The drawer component is used for making of menu integrated for each Page. It was somehow working in portrait mode,
but the landscape mode was obviously broken. I am not sure about explanation of the problem. Currently, I think
it was [circle binding loop](https://github.com/nemomobile-ux/qtquickcontrols-nemo/pull/3) which was causing
incorrect dimension of component.

![drawer](/images/2021-06-06-nemomobile-fixes-round-two/Screenshot_manjaro_2021-06-02_213439.png)
![drawer](/images/2021-06-06-nemomobile-fixes-round-two/Screenshot_manjaro_2021-06-02_213212.png)

Drawer in glacier-components showcase app before and after fix

I think it is related also to portrait bug which was causing scrolling issue:

> I know which items are cut off because you can pull down on the Settings screen to see them, but you cannot select them because as soon as you lift your finger, the screen bounces back to its prior state.
> --- [Brad Linder](https://linuxsmartphones.com/nemomobile-brings-glacier-ux-to-the-pinephone-and-other-linux-handhelds/)

# Don’t colorize profile pictures.

The [NemoIcon](https://github.com/nemomobile-ux/qtquickcontrols-nemo/blob/master/src/controls/qml/NemoIcon.qml) is an image,
which suppose use font-awesome icon. It contains ShaderEffect which changes color of the icon according to selected theme.
This behavior is not intended for photos and [should be turned off in glacier-contacts](https://github.com/nemomobile-ux/glacier-contacts/pull/3)
by iconColorized property.

# glacier-gallery and tracker3

The glacier-gallery wasn’t working at all. First, I have recompiled it with qtdocgallery with disabled tracker.
Then I have tried to compile it together, but the compatibility with c++ was broken. I was about to make a
fix for that, but later that day, I have found that the [fix is already in master](https://gitlab.gnome.org/GNOME/tracker/-/commit/a11eb47ee19cc9849e790aa6331f242f9fa480a9).
Unfortunately not released yet I suggest to workaround it in qtdocgallery rather then repackaging tracker.
Then I was trying to fix qtdocgallery, but it was total disaster. Its complexity is scary. Luckily, the
SailfishOS guys did that tremendous job. 


<iframe width="560" height="315" src="https://www.youtube.com/embed/DYdZyJul7zE" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
// Overview of glacier-gallery

With that fix I was able to start work on adoption of it into glacier-gallery. The progress could be seen
on video. The qtdocgallery is generating [SPARQL queries](https://en.wikipedia.org/wiki/SPARQL) to get data
from tracker. Unfortunately, the complexity of tracker scheme leads to (complexity of query generator)².
Therefore it is currently not possible to reach all data by single query which would include filtering
and sorting. In the end are created two models. First for Pictures and second for Videos. They are merged
together in QML. The [pull request](https://github.com/nemomobile-ux/glacier-gallery/pull/11) contains
that merge and many minor changes. Fixes are welcome.

# Boosting of launcher

Same as MeeGo and SailfishOS, the Nemomobile is trying to boost apps. It means, it is preloading whole application
or some its parts into memory to accelerate startup of application. Some of them must be running in background anyway.
For example the dialer must be running to be able answer phone call.

This is done in `/usr/share/applications/*.desktop` files with two techniques. First, invoker application is used.
Second, `X-Maemo-Service` and `X-Maemo-Method` entries describes DBus interface to bring the application to foreground when needed.

It seems the booster for Nemomobile wasn’t packaged into manjaro yet and the glacier-dialer was referring to [its previous name](https://github.com/nemomobile-ux/glacier-dialer/pull/5).

# Web browser, mail client, maps, and more

Nemo already have glacier-browser application which is using QtWebkit, which was [deprecated in Qt 5.6](https://wiki.qt.io/New_Features_in_Qt_5.6)
and replaced by QtWebEngine. The WebEngineView is overlapped by historySearch ListView and doesn’t accept mouse click event.

The nemo have [glacier-mail](https://github.com/nemomobile-ux/glacier-mail), but it is not packaged in Manjaro version
of Nemo yet. There is a dependency on [nemo-qml-plugin-email](https://git.sailfishos.org/mer-core/nemo-qml-plugin-email) which
not packaged yet as well. I am not sure if it is planned to use that qml-plugin or migrate to different backend.

There are many map and navigation apps around there. Martin Kolman was working on [modRana](https://modrana.org/) which was
compatible with Maemo, MeeGo, Sailfish, Fedora Linux. This family could be probably extended more less easily with Nemo.
[Pure-maps](https://github.com/rinigus/pure-maps) is also QML based application which supports also different QtQuick
bases and good candidate to be part of Nemo.

There are a lot of other applications which would be great to package. Some of them is already in Manjaro. For example Midori web browser, which cannot be used because keyboard isn’t shown when needed. Support of Anbox and Flatpak would open large scale of applications. It is definitely something to be discovered yet.
