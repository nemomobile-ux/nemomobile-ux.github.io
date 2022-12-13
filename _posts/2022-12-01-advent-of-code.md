---
layout: post
title: Advent of code
excerpt: 
modified: 2022-12-14
author: jmlich
tags: ["Bugs"]
image:
  feature: ./2022-12-01-advent-of-code/day1.jpg
  teaser:  ./2022-12-01-advent-of-code/day1.jpg
  thumb:   ./2022-12-01-advent-of-code/day1.jpg

---

Christmas is around the corner. On the 1st of December, we usually get a new [advent calendar](https://en.wikipedia.org/wiki/Advent_calendar).
It means that kids may get every day before Christmas some sweets. For programers brings the [advent calendar](https://en.wikipedia.org/wiki/Advent_of_Code)
each day new challenge. If we solve those challenges we will get a working mobile operating system under the Christmas tree.

The tasks will be published here:

## 1 – hello world

As a starter task, you should prepare your [developer environment](https://nemomobile.net/installation/). Install Manjaro Linux into the Virtual machine and install the nemomobile packages on it.
Install the image on an SD card and try it. Let us know if you managed to do that. Share your experience [with us](https://telegram.me/nemomobile). Make some photos as proof.

## 2 – letter for Santa Claus

Santa Claus and his elves have already received some of your letters. Elves are doing everything to keep the position of Santa’s
place secret. They avoid google or apple cloud services, but they’ve managed to get your letters into the phone.

![](/images/2022-12-01-advent-of-code/day2-letter-to-santa.jpg){: width="100%"}

Santa Claus is an elderly person and his sight is not what it used to be. Unfortunately,
the [Pinch to zoom](https://github.com/nemomobile-ux/glacier-gallery/issues/20) function
in the Gallery application doesn’t work smoothly and seamlessly as expected. Your task is to fix zoom problem and
save Christmas, otherwise some children may not get their presents.

## 3 - how many days are left until Christmas?

Elves haven't managed to finish the calendar application before the start of December. Now they are running around Santa's village,
confused and afraid that they won't have time to wrap all the presents for the children. Santa cannot check if have been nice for
the whole year. Some mighty hackers with skills in user interface design and programming may help. The day, month, and agenda view
are already implemented in the [glacier-calendar](https://github.com/nemomobile-ux/glacier-calendar/) application. Same, the adding,
removing, and updating of events is already possible. The part with the week and year overview is missing, and this is exactly your task.


[![calendar](/images/apps/calendar-180.png)](/images/apps/calendar.png)
[![calendar](/images/apps/calendar2-180.png)](/images/apps/calendar2.png)
[![calendar](/images/apps/calendar3-180.png)](/images/apps/calendar3.png)


## 4 – light up the candle

It is the second advent Sunday! It means that two candles on the [Advent wreath](https://en.wikipedia.org/wiki/Advent_wreath) should be shining.

![](/images/2022-12-01-advent-of-code/day4-advent-wreath.jpg){: width="100%"}

The PinePhone kernel provides the sys interface to control the flashlight. However, it requires root privileges and it is device specific.

```
echo 1 > /sys/class/leds/white:flash/brightness
```

Nemomobile uses [MCE](https://github.com/sailfishos/mce). The abbreviation stands for Mode Control Entity and
it was originally for Nokia computers. Next, there is [NGFD](https://github.com/sailfishos/mce) which stands
for Non-graphical feedback daemon. Those two are probably good interfaces to control flashlight LEDs from
the end-user apps or [glacier home](https://github.com/nemomobile-ux/glacier-home).


## 5 - packaging presents from 9 to 5

Elves have to package a few [quetta-](https://en.wiktionary.org/wiki/quetta-)packages until Christmas. It seems that improvement in automation may help with testing and may accelerate whole process.

![](/images/2022-12-01-advent-of-code/day5-packages.jpg){: width="100%"}

While [elves in Shenzhen](https://cutiepi.io/) are preparing packages with hardware inside, the programmers
are working on PKGBUILDs. Every change in component requires a rebuild of a package. This takes elves a lot
of time.  There is already some package rebuild automation in [Manjaro Linux GitLab](https://gitlab.manjaro.org/manjaro-arm/packages/community/nemo-ux/lipstick-glacier-home/-/blob/master/.gitlab-ci.yml)
and image rebuilds in [github actions](https://github.com/nemomobile-ux/nemo-images). 

To makes task more difficult we are have three places to start with: [Manjaro Gitlab](https://gitlab.manjaro.org/manjaro-arm/packages/community/nemo-ux)
(or as [submodules](https://github.com/jmlich/nemo-ux)), [github/nemo-packaging](https://github.com/nemomobile-ux/nemo-packaging/), and/or
[Arch Linux](https://github.com/archlinux/svntogit-community/tree/master/qt5-quickcontrols-nemo).

Automation with GitHub Actions which produces images with package recompilation would be a big help for elves.  Where to start unraveling this puzzle? This is task for Monday.

## 6 - no more letters for Santa?

It is maybe too late to send a letter by postal service. Many children may not write anything
on the phone because the on-screen keyboard in Nemomobile is not showing for some reason.
Our wish is to have such smooth experience as with Bluetooth keyboard.

<iframe width="560" height="315" src="https://www.youtube.com/embed/zua1C56Ykyc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Currently, we are using [maliit-framework](https://github.com/maliit/framework)
with [maliit-nemo-keyboard](https://github.com/nemomobile-ux/maliit-nemo-keyboard)
and [maliit-gtk-input-context](https://github.com/maliit/inputcontext-gtk). The
nemo-keyboard package provides qml based keyboard adjusted for Nemo. It is based on
[Qt Quick Controls Nemo](http://github.com/nemomobile-ux/qtquickcontrols-nemo) so it
can keep nemo color scheme and font settings.

The keyboard it self is rendered as independent application over other applications.
Application detects dimensions of keyboard and render its content according to that.

## 7 - Santa's naughty or nice list

Santa is using the Glacier Contacts application to keep an eye on all the nice kids. Christmas magic
allows him to manage all 8 billion people on the planet on his phone. Unfortunately, he
[cannot store photos directly in the contact](https://github.com/nemomobile-ux/glacier-contacts/issues/64),
but only as a link to a file. He needs to clean up his gallery in order to be able to find all the presents,
but he needs to keep faces in his contact list.

![](/images/2022-12-01-advent-of-code/day7-the-list.jpg){: width="100%"}

## 8 - Present for GTK Friends

Santa's reindeer Comet thinks that GTK users should also be able to write their letters in GTK4-based applications.
Nowadays, Phosh-based user interfaces are using [Squeakboard](https://gitlab.gnome.org/World/Phosh/squeekboard),
but Nemo is using [Maliit](https://github.com/maliit/framework). And the Maliit keyboard also supports GTK apps.
Unfortunately, it [doesn't work with GTK4](https://github.com/maliit/inputcontext-gtk/issues/4).

The current code is based on objects such as `GdkWindow`, which is now `GdkSurface`. Also, `GdkEventKey` is
not accessible in GTK4. Other hints to solve that challenge are in
the [GTK migration guide](https://docs.gtk.org/gtk4/migrating-3to4.html).

![](/images/2022-12-01-advent-of-code/day8-gtk-widgets.jpg){: width="100%"}

## 9 – Nemo, go home, you are drunk

Some people tend to over-celebrate during the Christmas period. The current home screen is not in the best shape,
but it wasn't made by people who were drunk. It does have some technical debt, as it is hard to verify that all
use cases are working properly. Non-native applications don't react to orientation at all, or they appear upside
down, while native applications do not distinguish between portrait and landscape mode properly. Furthermore, the
window thumbnails do not fit in the placeholders when rendered. Therefore, it is clear that
[orientation-related features need some care](https://github.com/nemomobile-ux/main/issues/39).

<iframe width="560" height="315" src="https://www.youtube.com/embed/x1oJUZbNSNw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>.

## 10 – Unlock Santa’s SIM Card to save Christmas

Santa Claus lost his SIM card, and the new one is locked by a PIN. He is not able to connect to the network due
to a bug in glacier-pinquery. Santa wouldn’t be able to contact his elves and organize his Christmas Eve deliveries.
Will some smart hacker find a fix?


![](/images/2022-12-01-advent-of-code/day10-new-simcard.jpg){: width="100%"}

The [glacier-pinquery](https://github.com/nemomobile-ux/glacier-pinquery) is using
[libqofono-qt5](https://github.com/sailfishos/libqofono) and [ofono](https://github.com/neochapay/ofono-new).
It seems that the `ofono/tests/list-modems` script returns all properties correctly, and the property `PinRequired`
contents is ‘pin’ as expected. The `QOfonoSimmanager`, however, doesn’t show the property. The `dbus-monitor` shows
that `QOfonoSimmanager` doesn’t send a dbus query with `GetProperties` at all. Further exploration shown that the
modem is not valid in that class for some reason.

## 11 - well played, Grinch

The Evil Elf Grinch is trying to disrupt Christmas by adding the string `/usr` to random file URLs in the Glacier
Settings application. It is absurd that even the Glacier logo on the About page isn't visible. The sabotage was
carried out ingeniously. The cause of this is still a mystery. This began roughly when Glacier Settings
[amended the plug-in architecture](https://github.com/nemomobile-ux/glacier-settings/pull/125). Initially,
plugins were defined by JSONs and the entry QML file, but after the redesign, plugins are defined by shared
objects. Now the main page of the application is loaded from the QRC resource, while plugins are loaded from
the file system. Using QRC itself does not appear to be having any effect.

![](/images/2022-12-01-advent-of-code/day11-usr.jpg){: width="100%"}

## 12 – Sync your calendars

Time is running and everything needs to be planned precisely and carefully. All tasks for the elves are in the
Glacier Calendar application. However, Santa’s wife is using Google Calendar, which cannot be easily synchronized
to NemoMobile right now. Being out of sync with Mrs. Claus may end up in a disaster.

![](/images/2022-12-01-advent-of-code/day12-calendar.jpg){: width="100%"}

The calendar application is based on [nemo-qml-plugin-calendar](https://github.com/sailfishos/nemo-qml-plugin-calendar),
which uses [libaccount](https://gitlab.com/accounts-sso), [mkcal](https://github.com/sailfishos/mkcal/), and
[kcalendarcore](https://invent.kde.org/frameworks/kcalendarcore). [Buteo-sync-plugins-social](https://github.com/sailfishos/buteo-sync-plugins-social)
should allow synchronization with the Google account. The configuration dialog could possibly be implemented into
[glacier-settings-accounts](https://github.com/nemomobile-ux/glacier-settings-accounts), which uses
[nemo-qml-plugins-accounts](https://github.com/sailfishos/nemo-qml-plugin-accounts), [nemo-qml-plugins-signon](https://github.com/sailfishos/nemo-qml-plugin-signon),
and [signon-ui](https://github.com/sailfishos/nemo-qml-plugin-signon)

## 13 – Join to Nemomobile, we have cookies.

Some people think that voice calls and SMS messages are essential features of the smartphone operating system. Receiving SMS messages works,
but sending SMS or MMS does not. It is already 30 years since the first SMS was sent. It is probably stable enough to implement in Nemo.

![](/images/2022-12-01-advent-of-code/day13-cookies-for-Santa.jpg){: width="100%"}

>    Dear Santa,
>
>    I have been a good boy this year and I would like to ask for a special gift. Can you please help me fix all the NemoMobile issues that I have been having? I have left some cookies and milk out for you, and I hope you enjoy them when you come to visit.
>
>    Thank you for all that you do, and I can’t wait to see what you bring me this year.
>
>    Sincerely, Jozef

Where should we start with the investigation? Nemo is using [glacier-messages](https://github.com/nemomobile-ux/glacier-messages),
which is based on [telepathy-ofono](https://github.com/TelepathyIM/telepathy-ofono). It also uses [libofono-qt](https://github.com/Kaffeine/libofono-qt),
which is a different project than [libqofono](https://github.com/sailfishos/libqofono). In the end, it uses [onofo](https://github.com/neochapay/ofono-new)
to control the modem.

## 14 - Jammed WiFi at the North Pole: Where is my wire?

Christmas is coming, and the North Pole is a busy place. Santa's workshop is
filled with the sounds of elves building toys and packing presents, but there's
one problem - the WiFi network is down. It seems that Santa's storage, where
hundreds of ESP8266 devices are stored, is causing radio interference and breaking
the WiFi.

Santa needs a reliable connection to Nemo to be able to debug all the issues and make
sure everything is running smoothly. Fortunately, fixing the USB networking may be the
solution. Nemo is using [usb-moded](https://github.com/sailfishos/usb-moded), which should
provide the option to reconfigure the USB connection. There is a
[pinephone-setup-usb-network.sh](https://gitlab.manjaro.org/manjaro-arm/packages/community/pinephone/pinephone-manjaro-tweaks/-/blob/master/pinephone-setup-usb-network.sh)
script that may help us understand what is missing and get the USB connection working again.
