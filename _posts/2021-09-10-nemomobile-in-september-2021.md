---
layout: post
title: Nemomobile in September/2021
modified: 2021-09-10
author: jmlich
tags: ["Web browser", "Test tool", "Translations"]
image:
  feature: ./2021-09-10-nemomobile-in-september-2021/nemo-landscape-keyboard-980.jpg
  teaser: ./2021-09-10-nemomobile-in-september-2021/nemo-landscape-keyboard-620.jpg
  thumb: ./2021-09-10-nemomobile-in-september-2021/nemo-landscape-keyboard.jpg
---

Nemomobile moves forward also in September. Sergey made video which summarizes current status. Most notable changes was in sensors, volume control, and translations.

<iframe width="560" height="315" src="https://www.youtube.com/embed/wU8WFIHEFcM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Cannot update contacts

Glacier-contacts didn’t showed phone number in edit dialog and email because
[it used incorrect field from model](https://github.com/nemomobile-ux/glacier-contacts/commit/f282bd4277f97ca508045f51a9664f6f55abc9da). 
Right now, it shows the phone number, new contacts can be created, but its update doesn’t work properly for some reason:

```
qml: [saveContact] Saved contact
"Error: contacts from aggregate collection specified in batch save!"
Contact request 4 error: 11
```

## Web site improvements

We have added [contributing and troubleshooting section](https://github.com/nemomobile-ux/nemomobile-ux.github.io/commit/9fecaee00f75d4c87b3ee7103813528b2e0d6889).
It shows many areas where you can improve the project and it shows
the right place to start with. I am finally happy with [style sheets](https://github.com/nemomobile-ux/nemomobile-ux.github.io/commit/b13f0fed61bb0824256649a82ad6abcc6f8724b0).
Thanks goes to Patrick who wrote the draft of it and pointed to right
css selector.

There is a plenty work to do and if there is no one else to do it then try do it
yourself. Every single contribution, even small one, counts. If you aren’t able
to write the code, then you can translate, write documentation, fix grammar (thanks Mark!) and so on.

## Rotating screen

In last blog post, I described basic pipeline of the sensors from hardware to application. It turned out that qt-sensors backend wasn’t
[compiled with sensorfw](https://github.com/nemomobile-ux/nemo-packaging/commit/e5b4f8a0b1306e17cdf0323fa977df77f865ae47#diff-96a83296515ee26f7fec3934a38923d0db92c151de69f7abfee74ab35ffbeb43)
support. It was necessary to [fix pkg-config](https://github.com/sailfishos/sensorfw/commit/34de1db23b73f5282ad8fd24b47afb5d178f067c) of sensorfw to be able compile it.

![](/images/2021-09-10-nemomobile-in-september-2021/home-screen-rotate.gif)

After that sensors started to be visible for applications. It turned out that many things actually don’t work as well as they should. For example the position of keyboard needs some love (-;

![](/images/2021-09-10-nemomobile-in-september-2021/20210823213824.png){: height="350"}
![](/images/2021-09-10-nemomobile-in-september-2021/20210823214052.png){: height="350"}


Fingerterm also shows keyboard up side down. This may point to the place where the issue is.

The libglacierapp enables only portrait mode by default, hence the most of application works
in portrait mode only. I have enabled landscape mode for the [glacier-browser](https://github.com/nemomobile-ux/glacier-browser/commit/861dccd34fc3ee11bcdc5b9943b73dae31fae548).
It doesn’t make much sense to change all apps until the keyboard position is fixed.

At least Sergey fixed the [hiding keyboard](https://github.com/nemomobile-ux/lipstick/commit/2ca85696a7ad88b78ac9ad49268759a37dffb763) problem which was there when the application was minimized.

## Glacier-testtool

I made a simple app to check what data are provided by `QAccelerometer`
from Qt Sensors framework. Other types of sensors needed similar test,
so the [glacier-testtool](https://github.com/nemomobile-ux/glacier-testtool) was created.

<iframe width="560" height="315" src="https://www.youtube.com/embed/FpmPPcXvPHc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The orientation sensor worked just fine, but It is most likely just computed from accelerometers.
Gyroscope also shows some reasonable values.

Next, I was looking on output of compass, which appears to be somehow misconfigured, because output
looks more like random number generator. The magnetometers sensor doesn’t return any values.

The proximity sensor works as expected.

The ambient light sensor probably needs some calibration, or my office is really dark place during
the day, or my PinePhone have dirty sensor. I am not sure where the sensor exactly is, but I don’t
care much.

Next, I was about to test vibrations, but I incorrectly guessed the component. I was trying to
test NGFD which stands for Non Graphical Feedback daemon. There were libngf and qt bindings,
but the daemon it self wasn’t [packaged](https://github.com/nemomobile-ux/nemo-packaging/commit/fe0989d12ceeab5d0e08cd00b2b5f566400da00a).

After that I found that I need `HapticsEffect` to do vibration. After packaging and installing
of [qt-mobility-haptics-ffmemless](https://github.com/nemomobile-ux/nemo-packaging/commit/79e46bd067a93e7b0a27242a460d92b5bd820389) it started to work.

The tool was extended also with touch screen test.

## Volume control

I have seen many changes in [OHM rule engine](https://github.com/nemomobile-ux/nemo-packaging/commit/91f582190b0eca0fd6eb042af7eb44dbe72ea555)
(which stands for Open Hardware Manager), [pulse audio](https://github.com/nemomobile-ux/nemo-packaging/commit/5bdef0188080433d9631039a41d439060b8d8f65),
and [glacier-wayland-session](https://github.com/nemomobile-ux/glacier-wayland-session/commit/95641c0d26f5b3b7028edc3a6b0e6b7a15aed29c) related changes.
The OHM is for me right now a blackbox which does some magic, but I don’t understand what it is doing and where to start.
Some brief explanation would be appreciated. After those changes the volume control buttons started to work.

<video width="300" style="width: 300px !important" controls>
  <source src="/images/2021-09-10-nemomobile-in-september-2021/volume.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

# Translations

I have configured projects on [Transifex](https://transifex.com/nemomobile/public/) and its
github integration. Although, the Transifex is not fully open solution, it provides good
user experience for free for open source porjects. You can still create pull request directly
on the repository if you don’t like it.

If you ever need to setup github-transifex integration, then make sure the synchronization
is working correctly as follows:

* Go to integration settings.
* Wait until ‘no files synced’ changes to “Last sync status: <date> more…”.
* Click on the “more…” and then you can see if it succeed or error message.

Make sure, that you set same language in the translation source file as is set in Transifex
project source language field. The import of plurals may otherwise fail on xml parsing error.

Currently we have **468 strings to translate**. Some strings are not included to Transifex
yet. Only three languages (Czech, Russian, and Danish) have more then 30 strings done. We
have about 100 packages built above Manjaro, but only 14 project in Transifex. Other
projects will be added later when needed. Some strings are even not set as a translatable,
because they are not wrapped into `qsTr()` function. This could be seen for example in glacier-settings.

During the testing of translations I have found that glacier-messages didn’t compile translations
from `*.ts` to `*.qm` using `lrelease` tool during the build and/or the packaging process.
I decided to rewrite it to cmake also because there is a macro for translations.

Finally, I have added locale settings into `/etc/xprofile` settings into [arm-profiles](https://github.com/nemomobile-ux/arm-profiles/pull/5), 
to allow switching of the locale via UI. However, you still need to reboot Nemo manually after choosing the language in UI.

## FolderIconStack

The folder icon was [reworked](https://github.com/nemomobile-ux/glacier-home/commit/8c5b782161ef816b1787b82316a5e451ffddc82c).
Beside of positioning and sizing of icons, the default icon is used now when other icon is unavailable.

![](/images/2021-09-10-nemomobile-in-september-2021/folder-after.jpg){: width="350"}
![](/images/2021-09-10-nemomobile-in-september-2021/folder-before.jpg){: width="350"}

## Conferences

I have proposed an talk about Nemomobile to [OpenAlt](https://www.openalt.cz) conference and it was accepted. The conference
will be online at November 2021, however it will be in Czech. Next, I have submited CfP to [DevConf.cz](https://www.devconf.info/cz/).
It will be held at January 2022 in Virtual or at Brno (for sure with live streaming). The second talk will be in English if accepted.

## Bug to start with

As always, I am trying to find some good starting point for new comers. It is usually something well
visible, not very complicated, but not urgent to fix in the same time. Previously, I have mentioned
the sensor back end issue, which is so far the only issue from those blog posts which was already fixed.

There are few bugs related to glacier-gallery. If you run your OS from SD card, all directories are
handled as removable device. It means reindexing must be done when os is not sure about removal of
device e.g. after reboot.

The photos could be taken using `megapixels` application. The screenshot could be taken using
`screenshottool` from command line.

Most notable issue when you browse pictures using glacier-gallery on the device is broken pinch zoom.
It just does nothing. Zoom is usually handled by `PinchArea` element, which is included, but it doesn’t work anyway.


