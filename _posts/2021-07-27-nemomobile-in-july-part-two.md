---
layout: post
title: Nemomobile in July/2021 part two
modified: 2021-07-27
author: jmlich
tags: ["GPS", "Dialer"]
image:
  teaser: 2021-07-27-nemomobile-in-july-part-two/20210716_185953-577x1024r-620.jpg
  thumb: 2021-07-27-nemomobile-in-july-part-two/20210716_185953-577x1024r.jpg
---


What’s changed in the last month? Many issues have been fixed. Many hidden
bugs have become visible as the user interface became reachable.
Most important, crashing of UI and on screen keyboard were fixed.

The frequent restarts of UI were caused probably by incorrect systemd unit.

The biggest issue with on screen keyboard, maliit, was fixed. Its behavior
is not perfect, but current status improved current usability by 10 000 percent.
The keyboard sometimes stays open even when an application is minimized. Also,
it doesn’t work for GTK applications.

That and the working usb-moded makes device the ready for further development
with credentials `manjaro@192.168.2.15` and `123456`. Sometimes it is necessary
to unplug and plug the USB cable before its use. I am not sure why.


![](/images/2021-07-27-nemomobile-in-july-part-two/20210716_185953-577x1024.jpg){: width="300"}
![](/images/2021-07-27-nemomobile-in-july-part-two/20210714_124143-scaled.jpg){: width="300"}


In general, I consider refactoring and simplification of the code base as very beneficial.
The libuser, mapplauncherd aka boosters and invokers, and SSU were removed. Horray!
The `invoker` was handling launching of single instance of application. This must be
reworked in libglacierapp yet.

SailfishOS moved from own git.sailfishos.org to github.com/sailfishos. We finally
adjusted all `PKGBUILD` files accordingly.

The first phone call were made. I consider this as a big success even if it was without sound. 
lso a few text messages were received and sent.

![](/images/2021-07-27-nemomobile-in-july-part-two/1-1-768x1024.jpg){: width="300"}
![](/images/2021-07-27-nemomobile-in-july-part-two/2-1-768x1024.jpg){: width="300"}
![](/images/2021-07-27-nemomobile-in-july-part-two/sms1-768x1024.jpg){: width="300"}
![](/images/2021-07-27-nemomobile-in-july-part-two/sms2-768x1024.jpg){: height="400"}
![](/images/2021-07-27-nemomobile-in-july-part-two/removed-ssu-576x1024.jpg){: height="400"}


Notifications were fixed. The application which triggered notifications wasn’t starting.

<iframe width="560" height="315" src="https://www.youtube.com/embed/8P4wmU7k1C4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The theme switching was fixed. First, it was necessary to propagate Theme settings to other
running application in run time. Second, It was necessary to fix startup of applications.
Third, there were many glitches to fix where the `Theme.fontColor` wasn’t used, but
`color:"black"` was used instead.

<iframe width="560" height="315" src="https://www.youtube.com/embed/zb07b8HrS2Q" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

![](/images/2021-07-27-nemomobile-in-july-part-two/20210718142053.png){: width="300"}
![](/images/2021-07-27-nemomobile-in-july-part-two/20210718152634.png){: width="300"}

One of those issues was visible in maliit keyboard on the screenshot below. This was
fixed using [Theme.color](https://github.com/nemomobile-ux/maliit-nemo-keyboard/commit/545a187ebaf23a4e3cdad9505fd55187b8eb9504), but I am not sure about removal of BorderImage. I didn’t
notice any significant change of its UI.

Some smaller changes are still in progress. The polishing of glacier-settings could
be seen. The glacier-mail prototype was added. The glacier-messages is using a library
called telepathy which unifies many instant messaging protocols. It can receive instant
messages from jabber. The telepathy-haze allows support for pidgin based instant messaging
such as facebook. A Telegram protocol could be also directly integrated into glacier-messages
and glacier-contacts.

![](/images/2021-07-27-nemomobile-in-july-part-two/index-2-1024x576.jpg){: width="100%"}

![](/images/2021-07-27-nemomobile-in-july-part-two/20210716_185034-577x1024.jpg){: height="500"}
![](/images/2021-07-27-nemomobile-in-july-part-two/20210715_164257-577x1024.jpg){: height="500"}
![](/images/2021-07-27-nemomobile-in-july-part-two/app-switcher-columns.jpg){: height="500"}


I have started with [glacier-settings-account](https://github.com/jmlich/glacier-settings-accounts) which currently really doesn’t work.
Part of the code base was taken from [qmlsettings](https://github.com/nemomobile/qmlsettings/) project. I am not sure how to
create settings plugins. This could perhaps be the way to go. Right now I am
stacked with DBUS permissions. Additionally, I need to inspect translations options.
It seems that plugin doesn’t support translations right now.

![](/images/2021-07-27-nemomobile-in-july-part-two/1626757798.avi.gif){: width="70%"}


Speaking of translations: it started to work after fix of QTranslator use in [libglacierapp](https://github.com/nemomobile-ux/libglacierapp/pull/6),
storing [locale.conf](https://github.com/nemomobile-ux/nemo-packaging/commit/5c9cd8514e356ecebed4ac783bc8d41784c634af#diff-fa0066694e09d8feac1e3adf48c06331fee69fbb1dd9a24e02283726a7c834e7) into different folder, and loading of locale from configuration file.
In time of writing of blog post was last requirement solved by manually created
`~/.xprofile` with following content:

```
test -f $HOME/.config/locale.conf && source $HOME/.config/locale.conf
```

After that you will find out how many strings are not translated and how many are not wrapped into qsTr() calls.

![](/images/2021-07-27-nemomobile-in-july-part-two/nemo-russian.jpg){: width="70%"}

Previously, I always connected to WiFi via `connmanctl` command in terminal. In the
glacier-settings it wasn’t working. I have added a one line [patch](https://github.com/nemomobile-ux/glacier-settings/pull/29) which sends
passphrase to connman agent. I am not sure how that will work for other scenarios.
It will probably not work for connection with PIN. The WPA2 Enterprise will be
definitely not working, because the dialog doesn’t support required fields anyway.
I am not sure about its behavior when an incorrect password is entered.
Nevertheless, it all worked in the tested case.

# Bug to start with:

The Nemomobile large number of bugs and and its solving requires different knowledge.
I would like to point to somehow well localized issues which moves project forward
and could be seen by every future user. First in the row was rendering of [folder](https://github.com/nemomobile-ux/glacier-home/issues/147),
which still doesn’t work.

This one is about power off and reboot of the device. It just doesn’t work.

The UI triggers reboot via dbus. The pipeline goes to [dsme](https://github.com/sailfishos/dsme) daemon namely [utility.c](https://github.com/sailfishos/dsme/blob/master/dsme/utility.c#L71).
The guess is based on following messages in log:

```
$ journalctl -f
Jul 27 14:55:21 manjaro-arm DSME[3747]: Received introspect request: com.nokia.dsme /com/nokia/dsme/request
Jul 27 14:55:22 manjaro-arm DSME[3747]: privileged user not found
```

It may be caused by some missing configuration. For example some user group should
be added to manjaro user (or maybe wheel group could be used instead). It could be
caused by dropping of dependency on sailfish-user-manager. This means that dsme
should be adjusted to manjaro somehow. Current solution most probably works correctly
for the upstream (sailfishos). Hence, the proposed patch should go to nemo-packaging
first. It will be similar to [dsme server](https://github.com/nemomobile-ux/nemo-packaging/blob/master/dsme-git/fix-dsme_server_path.patch) path change. The change should be designed
to be compatible with sailfishos to allow its upstreaming.




