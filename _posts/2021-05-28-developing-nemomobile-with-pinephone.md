---
layout: post
title: Developing Nemomobile with PinePhone
modified: 2021-05-28
author: jmlich
tags: [main]
image:
  teaser: 2021-05-28-developing-nemomobile-with-pinephone/20210527_163419-1024x577.jpg
  thumb: 2021-05-28-developing-nemomobile-with-pinephone/20210527_163419-1024x577.jpg
---
    

In previous post, I was writting about my development environment in KVM, but my target is to run nemomobile
on my PinePhone. I have Brave Heart edition which should be good enough for development. Here are few notes
which may help you with your first steps.

I have made an video to show what you can expect before you start with debugging and creating tickets.

<iframe width="560" height="315" src="https://www.youtube.com/embed/uH50ODeRMdY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

First of all you should download the image and copy it into you SD card.

```
# sudo -i
# wget https://img.nemomobile.net/2021.05/Manjaro-ARM-nemomobile-pinephone-0.3.img.xz
# xz -dc "Manjaro-ARM-nemomobile-pinephone-0.3.img.xz" | dd if=/dev/stdin of="/dev/mmcblk0" status=progress conv=fsync bs=4M
# sync; sync; sync
```

Nemomobile is really in early development stage and the [serial console cable](https://pine64.com/product/pinebook-pinephone-pinetab-serial-console/) seems to be necessary equipment.
I am used to work with [minicom](https://bloggerbust.ca/post/how-to-configure-minicom-to-connect-over-usb-serial-uart/)	 since I had dial-up connection, but you can use any other tool. Don’t forget
to turn off hardware flow control and flip dip switch under cover to serial console mode.

```
sudo minicom -D /dev/ttyUSB0
```

The serial port could be also name as other block devices up to `/dev/ttyUSB3`. I didn’t spend much time with
it so I don’t know how is the name chosen (I actually don’t care much).

After connecting to terminal you probably want to log in and connect to internet. Default credentials are
`manjaro`/`123456`. There is a [connman](https://wiki.archlinux.org/title/ConnMan#Error_/net/connman/technology/wifi:_No_carrier) daemon to manage network connections. You can get the network name
after `services` command.

```
# systemctl start connman
# connmanctl
connmanctl> enable wifi
connmanctl> scan wifi
connmanctl> services
connmanctl> agent on
connmanctl> connect wifi_02ba002237f5_4d6c69636837302d496e7472616e6574_managed_ps
```

After connection to the Wifi you should probably update OS. You can maybe install some additional packages:

```
pacman-mirrors -f 5
pacman -Syyu
```

Nemomobile grown from Mer Project and SailfishOS. It was long journey together. [SailfishOS Documentation](https://sailfishos.org/wiki/Sailfish_OS_Cheat_Sheet)
may still give you hint how to start with various issues. For example, you can find there `vcardconverter`
to import your contacts.

# Debugging apps

There are many bugs in nemo. There are some common ways how to debug graphical Qt applications. First, you probably
want to start application from terminal to see some debug messages produced by [qDebug()](https://doc.qt.io/qt-5/qdebug.html), QWarning() and others:

```
export QT_IM_MODULE=qtvirtualkeyboard
export XDG_RUNTIME_DIR=/run/user/1000
glacier-messages --platform wayland
```

When the application crashes you probably want to see back trace. For that purpose you should use `coredumpctl`.

```
$ coredumpctl dump
$ coredumpctl debug
```

# Current state, issues, and progress..

I have tried to fix some bugs. I have seen some of them more then once.

* `org.nemomobile.something` interface was changed to `Nemo.Something`, but some application didn’t noticed yet. There is an workaround
for that in nemo-qml-plugin-* packages. The glacier-dialer with nemo-qml-plugin-dbus had also [this issue](https://gitlab.manjaro.org/manjaro-arm/packages/community/plamo-gear/nemo-qml-plugin-dbus/-/issues/1),
but it is already fixed in git repository.

* Invoker doesn’t start glacier-dialer and glacier-messages application. The trick is to start application
in advance and just popup already running instance after clicking on the icon. This should be done via
dbus interface, but it doesn’t work now. As workaround you can remove those two lines from `/usr/share/applications/glacier-dialer.desktop` (and similar for glacier-messages):
```
X-Maemo-Service=org.glacier.voicecall.ui
X-Maemo-Method=org.glacier.voicecall.ui.show
```
![glacier-dialer screenshot](/images/2021-05-28-developing-nemomobile-with-pinephone/20210527_163419-1024x577.jpg  "Glacier-dialer started, but window doesn’t fit on the screen again.")


* The voicecall library refactoring in sailfishos repository wasn’t probably finished. There
are missing [some methods](https://git.sailfishos.org/mer-core/voicecall/issues/1). It ends up
with `undefined symbol` error message. For now I have added an empty implementation so it doesn’t
crash but doesn’t work either. The C++ method names are encoded with that ugly notation which
could be translated by `c++filt`.
```
$ c++filt _ZNK16VoiceCallHandler7isReadyEv
VoiceCallHandler::isReady() const
```
![glacier-dialer screenshot](/images/2021-05-28-developing-nemomobile-with-pinephone/Screenshot_manjaro_2021-05-25_173420-1024x576.png  "Glacier-dialer looks like its working, but only in KVM. On PinePhone you can see just black screen")

* The glacier-gallery is depending on [legacy qtdocgallery](https://github.com/nemomobile-ux/glacier-gallery/issues/6). I have compiled qtdocgallery without tracker
support, because manjaro is using tracker3 and qtdocgallery requires tracker-sparql-2.0. The main issue
is that tracker-sparql-3.0 changed the schema of database, hence the mechanism of building of the SPARQL
queries must be fixed. Additionally, tracker3 library it self must be updated to master (released 3.1.1
is not enough), because [it doesn’t export required functions](https://gitlab.gnome.org/GNOME/tracker/-/commit/a11eb47ee19cc9849e790aa6331f242f9fa480a9)  into C++.
Some parts was already done in [sailfishos repo](https://git.sailfishos.org/mer-core/qtdocgallery/tree/migrate_to_tracker3).

* I didn’t bought an serial cable together with a phone, but few months later. It turned out, that application
like fingerterm can provide interface to fix issues manually. I have added the package to nemo-packaging repo
and it works like a charm.
```
pacman -S fingerterm
```
![glacier-dialer screenshot](/images/2021-05-28-developing-nemomobile-with-pinephone/20210527_135650-1024x577.jpg "Fingerterm application from SailfishOS.")

* The project needs CI for packages and images. I was trying to fork an repository for [automated building](https://github.com/jmlich/nemo-images/) of images using github actions. I was also trying to rebuild packages using docker and makepkg. I was able to build x86_64 packages, but build of aarch64 packages in this way had some issues. Maybe this will be solved itself, because some people from manjaro are adopting those packages.

* In the glacier-music is currently minor issue with iconColorized property. The missing property could be [removed](https://github.com/nemomobile-ux/glacier-music/pull/3/commits/069ec82aba7ef3db4f2bd1bf5795eacd67976b8e) or better
the underlying [qtquickcontrols-nemo](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/7c0e090e846e888c036b4d983cc273424048742d) could add
the property.

# Thats all folks, for now..

The Nemomobile continues with small steps forward and all hands to help are welcome. I am considering organizing
some online workshop or hackathon. What should be its target? First, to pass hardly obtained knowledge to other people.
Second, to gain some knowledge from people smarter than me. Third, to accelerate development of nemo it self. Fourth,
to discuss current issues and their possible solutions and to identify issues where can I help.

P.S. Sergey Chupligin will have an talk about nemo on [Volla Community Days](https://volla.online/en/blog/files/community-days-2021.html) this Sunday.