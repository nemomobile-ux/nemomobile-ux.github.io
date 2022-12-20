---
layout: post
title: Advent of code
excerpt: 
modified: 2022-12-20
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

## 15 - Buddy’s surprise in jeopardy

As Christmas approaches, the elves at the North Pole are busy preparing for the holiday
season. One group of elves has a special project in mind: creating a calendar featuring
Buddy, the lovable and mischievous elf from the movie “Elf”.

The elves have already prepared the costumes and props for each month of the calendar,
and have planned out the poses for each picture. They are excited to capture the fun
and playful spirit of Buddy, and to share the calendar with other elves and with Santa.

![](/images/2022-12-01-advent-of-code/day15-camera.jpg){: width="100%"}

However, they are encountering a problem: the camera on their Pinephone is not working
properly. They have tried using the [Mexapixels](https://git.sr.ht/~martijnbraam/megapixels)
application, but it is not well-suited to Nemo’s user experience. They have also attempted
to use the QtMultimedia library and GStreamer pipeline to take pictures, but they are
having difficulty configuring the pipeline.

Desperate for a solution, the elves turn to YOU, skilled hackers, for help. They know that
the Pinephone’s camera requires a newer kernel, which is available in Manjaro Linux, and
that the [libcamera](https://gitlab.com/tui/libcamera) library may need to be patched in
order to work properly with the QtMultimedia library. With your help, the elves hope to
be able to configure the [GStreamer pipeline](https://gitlab.com/tui/tui/-/tree/master/cam)
and capture high-quality pictures for their calendar.

The 15th day of the advent of code challenge is all about helping the elves to configure
the GStreamer pipeline and capture Full HD video using the Pinephone and Nemo. Can you
rise to the challenge and save Christmas for the elves?

## 16 – Swipe in the loop to cheer Rudolph the reindeer

Rudolph the reindeer has always been passionate about improving the user experience,
and he spends his free time tinkering with the Nemomobile operating system, trying
to find ways to make it more intuitive and user-friendly. One of his favorite features
was the ability to swipe on the home screen in both directions, but recently this feature
stopped working and Rudolph is devastated. He refuses to light up his nose, which is
a crucial part of his navigation system, until the issue is fixed.

The other reindeer are concerned about Rudolph and try to cheer him up, but nothing seems
to work. They decide to brainstorm and come up with a solution to fix the issue with
the swiping feature on the home screen. They believe that if they can get this feature
working again, it will help Rudolph feel better and be able to focus on his navigation
duties. You can help with fixing the issue. There were already [some drafts](https://github.com/nemomobile-ux/main/issues/27)
of the fix, but it wasn’t working correctly on the phone.


## 17 - North pole calling?

Someone from the North Pole was calling us, but unfortunately we don't know
what they wanted because we couldn't hear them. Please help us fix the issue.
The [phone calls](https://github.com/nemomobile-ux/main/issues/34) feature
seems to be both close and far away at the same time. Right now, the phone
calls work but don't transmit sound. It's only possible with an unlocked SIM card.

The voice is not transmitted because the pulse audio profile is not switched. It
can be manually switched with the command `pactl set-card-profile 0 "Voice Call"`.

The ofono is controlled via dbus. The `OFONO_DEBUG=-d` in `/var/lib/environment/ofono/debug.conf` may help to find the issue. There were some permissions in the settings to check:

In `/etc/dbus-1/system.d/ofono.conf`, the `<policy user="radio">` should probably be `<policy user="network">`, and `/etc/ofono/dbusaccess.conf` should allow use for the 'wheel' group:

```
* = deny;
group(network) | group(wheel) = allow;
```

## 18 – Helping Santa Deliver on Time

With only one week left until Christmas, the elves are working at full speed to prepare for the holiday.
However, they are running into a problem with their delivery tracking system. When they receive a notification
from a delivery company via SMS, the [lipstick](https://github.com/nemomobile-ux/lipstick/tree/master/src/notifications)
compositor, which is responsible for processing notifications, is not opening the [glacier-messages](https://github.com/jmlich/glacier-messages)
app as it should when the elf clicks on the notification. As a result, they are unable to open the message directly
and view the tracking details. This is slowing down the work of the elves and could potentially cause serious issues
with preparing all the presents in time. Is there a hacker out there who can help us track the related D-Bus messages
and identify which part of the system is broken in order to fix it? We need your help to ensure a smooth Christmas
for Santa and the elves!

## 19 - Fixing the Broken Vibration on Silent Night

It's the week before Christmas and Santa Claus is having trouble with the vibration feature on his Nemomobile phone.
He needs to be able to catch calls from the elves at the North Pole, but the phone isn't vibrating when he receives them.

![](/images/2022-12-01-advent-of-code/day19-silent-night.jpg){: width="100%"}

Rudolph the red-nosed reindeer, who has been working on the Nemomobile operating system, is trying to reproduce the issue using
the [glacier-testtool](https://github.com/nemomobile-ux/glacier-testtool). He has narrowed the problem down to one of the
following packages: [ngfd](https://github.com/sailfishos/ngfd), [ngfd-plugin-native-vibrator](https://github.com/mer-hybris/ngfd-plugin-droid-vibrator),
[qt5-feedback-haptics-native-vibrator](https://github.com/mer-hybris/qt5-feedback-haptics-droid-vibrator), and qt5-feedback.
The Issue with [loading of ngfd vibra plugin](https://github.com/sailfishos/ngfd/pull/3) may help to understand where is a problem.

Despite Rudolph's efforts, the vibration feature is still not working and Santa is at a loss for what to do. That's where you come in.

Your task is to investigate the issue and come up with a solution that will get the vibration feature working again in time for Santa's journey on Christmas Eve. You'll need to dig into the code and see if you can find the root cause of the problem. Good luck!

## 20 - Stuck with Unwanted Gifts

As Christmas approaches, the elves at the North Pole have been using their Nemo mobile devices to prepare for the holiday season.

However, they have run into a problem: they are unable to uninstall unwanted software packages, or “gifts”, from their devices.

The elves typically tried to uninstall gifts by pressing and holding on the gift’s icon on the home screen and choosing the option

to uninstall on their previous devices. However, this method is not possible on Nemo mobile devices. The elves have also tried using
the package manager to uninstall the gifts, but this is not working either.

As a result, the elves’ devices are becoming cluttered with gifts that they do not want or need, and they are running out of storage
space. Santa and the elves also have a need to remove tracking apps to keep the exact location of the North Pole a secret. Can you
help the elves fix this problem by implementing a way to uninstall unwanted gifts from the user interface of their Nemo mobile devices?

To solve this problem, the elves need a way to uninstall gifts from the user interface of their Nemo mobile devices. This could be done
by implementing a user interface in the [glacier-packagemanager](https://github.com/nemomobile-ux/glacier-home/tree/master/src/qml/applauncher)
application that allows the elves to uninstall gifts, or by implementing an interface between glacier-packagemanager
and [glacier-home](https://github.com/nemomobile-ux/glacier-home/tree/master/src/qml/applauncher) to allow the elves to
uninstall gifts in a familiar way.

The goal of the task is to help the elves find a solution to easily and quickly uninstall unwanted gifts from their Nemo mobile devices using the user interface.