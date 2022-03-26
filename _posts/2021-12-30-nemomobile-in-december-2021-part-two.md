---
layout: post
title: NemoMobile in December/2021 part two
excerpt:
modified: 2021-12-30
author: jmlich
tags: ["Keyboard", "Calendar", "Alarm clock", "Translations"]
image:
  feature: ./2021-12-30-nemomobile-in-december-2021-part-two/image20211230_191547043.jpg
  teaser: ./2021-12-30-nemomobile-in-december-2021-part-two/image20211230_191547043.jpg
  thumb: ./2021-12-30-nemomobile-in-december-2021-part-two/image20211230_191547043.jpg

---

2022 will bring many changes to NemoMobile. Recent development brings T9 like predictive keyboard prototype.
The controls improves user experience with Pulley menu and back gesture. Some new applications such
as calendar and alarm clock are being created. The Nemo web site has new templates for devices. The Halium
based version is also progressing fast. We are looking forward to using the OS as a daily driver, but it is
still long journey. Many of the shown demos are still prototypes and still not merged into master branch.

## Development under the hood

Sergey made an prototype of [keyboard with T9 like prediction](https://github.com/nemomobile-ux/maliit-nemo-keyboard/pull/7) based
on [presage](https://presage.sourceforge.io/) project. It is using hunspell dictionary to propose right
words according to your language settings:

```
/usr/share/hunspell/" + m_language + ".dic"
```

![](/images/2021-12-30-nemomobile-in-december-2021-part-two/t9-in-browser.jpg){: height="500"}

There is ongoing work on [calendar](https://github.com/nemomobile-ux/glacier-calendar/) application
and the preliminary results looks really promising.

![](/images/2021-12-30-nemomobile-in-december-2021-part-two/calendar.jpg){: height="400"}
![](/images/2021-12-30-nemomobile-in-december-2021-part-two/calendar2.jpg){: height="400"}
![](/images/2021-12-30-nemomobile-in-december-2021-part-two/calendar3.jpg){: height="400"}

Similar, there is a prototype of the [clock application](https://github.com/jmlich/glacier-alarmclock/).

![](/images/2021-12-30-nemomobile-in-december-2021-part-two/alarms1.png){: height="500"}
![](/images/2021-12-30-nemomobile-in-december-2021-part-two/alarms2.png){: height="500"}

## Translations

Last month added Slovak, Spanish, Ukrainian, Romanian, Moldavian, and Vietnamese languages.
Source strings from the prototypes applications such as glacier-calendar and glacier-mail were
added into transifex. Currently, we have almost 800 strings to translate. Many languages reached
enough translated strings to be enabled in the settings application.

The transifex hooks were reconfigured to commit directly into repositories instead of pull
requests, hence the translations goes faster to the OS with less work.

Transifex doesn’t contain entries from desktop files. Previously, translation was possible
only via pull requests on github. The `*.ts` files contains corresponding strings, so they
can be extracted and pushed into repo semi-automatically using [bash script](https://gist.github.com/jmlich/80fe6f324d45d9826881b77106e38665).

It turned out, that many translators are confused by translation of plurals. The
string "Imported %n contact(s)" have singular form "Imported %n contact" and plural
form "Imported %n contacts". Both forms must be translated to be able to save the translation.
Some languages have more forms for example: "1 kontakt byl importován", "2 kontakty byly importovány",
and "5 kontaktů bylo importováno". Please click to `1`, `few`, `many`, and `other` button to translate it. Then you can save it.

![](/images/2021-12-30-nemomobile-in-december-2021-part-two/Transifex.png){: height="500"}


## Improving user experience

Scaling – user can [set font](https://github.com/nemomobile-ux/glacier-settings/commit/f0205c1cdd0ba0cc5bc077f8b201782a97d20183) size
settings and [qtquickcontrols-nemo](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/e89641b7c90cd9d61916cb235abaf8f367f8f36e) uses the settings in applications.

<iframe width="560" height="315" src="https://www.youtube.com/embed/50kPmWN0ucs" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Theme tuning – default font size and spaces in theme was improved. The left picture shows sizes after the change and right picture shows sizes before the change

![](/images/2021-12-30-nemomobile-in-december-2021-part-two/font-sizes-and-spacing.jpg){: height="500"}

The settings hidden in Page drawers could be shown using gesture. This behaviour is similar to SailfishOS
[Puley Menu](https://github.com/nemomobile-ux/qtquickcontrols-nemo/pull/22).

<iframe width="560" height="315" src="https://www.youtube.com/embed/D43_KpDdXaE" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The back action can now be triggered also by [swipe gesture](https://github.com/nemomobile-ux/qtquickcontrols-nemo/pull/23).
This is also big step forward in user experience. However, it doesn’t work always as expected. It may need some additional tuning yet.

<iframe width="560" height="315" src="https://www.youtube.com/embed/38EjwmZh2G0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
<iframe width="560" height="315" src="https://www.youtube.com/embed/B4L4Olg4fp4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Other changes

The spaces and fonts on the about page in the settings was fine tuned. Now it looks much better! Additionally, IMEI is shown now.

![](/images/2021-12-30-nemomobile-in-december-2021-part-two/about-page-look-and-feel.jpg){: height="500"}

Manjaro is changing. The distribution moved from megi kernel to vanilla. The libicu was updated, which leads to recompiling big number of packages.

Manjaro-halium also moves forward which means the installation procedure is a little different.
Fresh images are generated by [CI](https://github.com/manjaro-libhybris/image-ci/releases). Please
note, that this is using own patches in manjaro-arm-tools. Some users reported troubles with
permissions of home folder which breaks ofono and audio.

LEDs are working with latest update of [mce settings](https://github.com/neochapay/nemo-device-dont_be_evil/commit/f4b0ad02e9365c52f98a83ca487ec6f80110204c).
The package for [vibrator was added](https://github.com/nemomobile-ux/nemo-packaging/commit/795b0022afb0ec4a6c3debc61a25acc78250c7cd).

<iframe width="560" height="315" src="https://www.youtube.com/embed/ZktfWGE2gZs" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Libglacierapp allows loading of [QMLs from resource file](https://github.com/nemomobile-ux/libglacierapp/commit/908f70d69536a9bab36c698a6df5d0c3d310b15f),
which allows use of qtquickcompiler. This can be seen in [glacier-weather app](https://github.com/nemomobile-ux/glacier-weather/pull/12/files).
This improves also detection of qml files inside of qmake based projects in Qt Creator. In combination with
right settings is debugging in virtual machine much easier:

```
export "QT_LOGGING_RULES=*=true
qt.*=false"

export QT_ASSUME_STDERR_HAS_CONSOLE=1
```

[Time zone selection](https://github.com/nemomobile-ux/glacier-settings/pull/108) was improved. Filter is not case sensitive anymore,
hence user can search for “prague” not “Prague”. The `ListViewItemWithActions` was used and the code as a little simpler now.

## Website improvements

It is necessary to give accurate information about project status to newcomers and/or returning contributors,
hence we have prepared a [template with device overview](https://github.com/nemomobile-ux/nemomobile-ux.github.io/tree/master/_devices).
Now, the devices could be easily [compared](https://nemomobile.net/devices/) with each other.
[Detailed information](https://nemomobile.net/devices/pinephone/index.html) is available as well. Testers are welcome!

![](/images/2021-12-30-nemomobile-in-december-2021-part-two/Screenshot-Devices.png){: height="500"}

## Happy New Year!