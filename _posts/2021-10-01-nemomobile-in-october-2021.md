---
layout: post
title: Nemomobile in October/2021
modified: 2021-10-01
author: jmlich
tags: ["Translations", "Waydroid", "Contacts"]
image:
  feature: ./2021-10-01-nemomobile-in-october-2021/nemo-pinephone-n950-980.jpg
  teaser: ./2021-10-01-nemomobile-in-october-2021/nemo-pinephone-n950-620.jpg
  thumb: ./2021-10-01-nemomobile-in-october-2021/nemo-pinephone-n950.jpg
---



Highlights for last month are translations, waydroid, update of lipstick, bugfixes and more.

## Translations

The publishing of translations via [transifex](https://www.transifex.com/nemomobile/public/) has drawn some
attention. We now have a Polish (pl) translation thanks to knuxify and Finnish (fi) translation thanks to
Erik. Their brave work showed some typos and bugs in translation sources.

The glacier-settings is a little bit tricky to translate due to its plugins architecture. The plugin may come
with any third party package. Currently, the filename of translations is defined as a separate item in the
json definition of plugin. The name of plugin must be the same as title in headerTools in the main page of
the plugin. The [categories translations](https://github.com/nemomobile-ux/glacier-settings/commit/69c054994fcd428551198be4d1f9aa679f977d99) expect
to fit into one of predefined categories.

![](/images/2021-10-01-nemomobile-in-october-2021/glacier-settings-i18n-1.png){: height="250"}
![](/images/2021-10-01-nemomobile-in-october-2021/glacier-settings-i18n-2.png){: height="250"}


Some sources are still not included in transifex. I have seen some messages comming from nemo-qml-plugins-*. The titles of applications are translated in *.desktop files.

Now we have English, Russian, Czech, Polish, and Finnish translations.

## Fresh code with fresh blood

Erik Inkinen did Finnish translations and also started to contribute code. He improved the [gesture behavior](https://github.com/nemomobile-ux/glacier-home/pull/160)
on home screen. He proposed also a [set of patches](https://github.com/nemomobile-ux/qtquickcontrols-nemo/pull/8) to
reach similar graphical effect with background as SailfishOS have. There is still [some discussion](https://github.com/nemomobile-ux/qtquickcontrols-nemo/pull/12)
what is the right way to add this to nemo with respect to windowed mode.

I didn’t inspect code much, but the result looks beautiful. So thanks Erik, welcome to us and keep working on nemo!

![](/images/2021-10-01-nemomobile-in-october-2021/blurred-wallpaper.jpg){: height="350"}

## Update of lipstick

There were many updates to lipstick (~140 commits) which brings the work of upstream (SailfishOS) for the last five years
to nemo. Main changes are related to notifications, screen lock, performance and responsiveness.

## Resizing

The default resolution was changed to 1440 x 720 pixels which corresponds to PinePhone resolution. All font sizes
padding and others are computed based on it. The screenshots show the difference between before and after. 
The font size is too small and some artifacts can be seen. Sergey is still working on [better sizing](https://github.com/nemomobile-ux/qtquickcontrols-nemo/pull/13).

![](/images/2021-10-01-nemomobile-in-october-2021/20210916142459-sizing1.png){: width="350"}
![](/images/2021-10-01-nemomobile-in-october-2021/20210916155756-sizing2.png){: width="350"}
![](/images/2021-10-01-nemomobile-in-october-2021/20210930_161526-sizing3.jpg){: width="350"}
![](/images/2021-10-01-nemomobile-in-october-2021/20210930_164045-sizing4.jpg){: width="350"}



## Waydroid

I tried to run waydroid after @DanctNIX [announced its manjaro packaging](https://twitter.com/DanctNIX/status/1438538945147510790)
on twitter. It was necessary to switch to [unstable branch](https://wiki.manjaro.org/index.php/Switching_Branches) to install it.

```
sudo pacman -Syu
sudo pacman -S waydroid-image
sudo waydroid init -f
sudo systemctl enable waydroid-container --now
```

and it wasn’t running. I tried it again and again after every update. After some time it suddenly started to work. Android icons appeared on the home screen.

![](/images/2021-10-01-nemomobile-in-october-2021/20210930_161246-waydroid.jpg){: width="350"}
![](/images/2021-10-01-nemomobile-in-october-2021/20210930_161308-waydroid2.jpg){: width="350"}


As can be seen in the picture, waydroid started two windows, one with “Waydroid is starting” and other one with “Settings app”. Only one android app concurrently was running.

## Some bug fixes

After some changes the sounds section in glacier-settings wasn’t working due to paths. It started to work
with [full path](https://github.com/nemomobile-ux/glacier-settings/pull/60) instead of file name only.
Its inspection showed an bug in [folder list model](https://github.com/nemomobile-ux/nemo-qml-plugin-folderlistmodel/pull/1).

The filemuncher was improved while testing the folder list model. The images [thumbnails aren’t colorized](https://github.com/nemomobile-ux/glacier-filemuncher/pull/12)
same as icons anymore. The file manager should provide [access to whole filesystem](https://github.com/nemomobile-ux/glacier-filemuncher/pull/13)
not only to the home directory.

Non graphical feedback suddenly stopped working. It turned out that upstream introduced a wider set of haptical effects. On
the pinephone it doesn’t fit into memory for vibra motor device and makes the whole service crash. In the end, 
I suggested [reverting it](https://github.com/sailfishos/ngfd/pull/3).

Last month, we had a fix for the ohm-plugin-misc generating of the pkg-config configuration. The [proposed fix](https://github.com/sailfishos/ohm-plugins-misc/pull/2)
has been merged to upstream now.

The (nightly) images are compiling again. There were some [conflicts](https://github.com/nemomobile-ux/arm-profiles/pull/6)
with pinephone-manjaro-tweak package in pulseaudio configuration.

Pressing the power key once was triggering poweroff. We have added the [systemd configuration](https://github.com/nemomobile-ux/arm-profiles/pull/7)
into overlay files.

## Contacts

The contacts app is one of central application for phone. Previously, it
showed [just the first phone number](https://github.com/nemomobile-ux/glacier-contacts/pull/29) associated to the contact.

The application already had an import dialog implemented, but it was abandoned some time ago. It was necessary to
add some button to be able to reach it and [rework it](https://github.com/nemomobile-ux/glacier-contacts/pull/31)
because it was using ancient qtquickcontrols.

![](/images/2021-10-01-nemomobile-in-october-2021/glacier-contacts-import.png){: width="350"}
![](/images/2021-10-01-nemomobile-in-october-2021/glacier-contacts-multiple-phone-numbers.png){: width="350"}


Finally, it is now possible to import contacts from *.vcf file. It seems it import contacts in most cases.
Unfortunately, I probably had an [incorrectly formed](https://github.com/sailfishos/nemo-qml-plugin-contacts/pull/1) file
with two `REV=` records, which caused failure of import. The error is not detected in UI and nothing was imported.

The `vcardconverter contacts.vcf` was able to point to incorrect contacts, skip them, and import the rest of contacts. Additionally, the `vcardconverter` also imports correctly contact avatars.

As you can see on the screenshots, there is [selection in ListView](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/406fd246ab4b994a8b75fe3f30d6d3112f3225b3#diff-25a6634263c1b1f6fc4697a04e2b9904ea4b042a89af59dc93ec1f5d44848a26) which was added because of import dialog.

If you are curious about overall state: [Editing contacts](https://github.com/nemomobile-ux/glacier-contacts/issues/35) and phone calls still dont’t work for me. Ofono says simply denied when trying to connect to network.

## Manjaro /nemo-ux update

The `PKGBUILD` files in [nemo-ux](https://gitlab.manjaro.org/manjaro-arm/packages/community/nemo-ux) was
updated after three months. About 80 packages were updated. Mostly version changes, but not the method of packaging.

Eleven new packages (repos) were created:

*    glacier-testtool-git
*    hybris/libhybris
*    nemo-qml-plugin-signon-git
*    nemo-theme-openmoko-git
*    ngfd-git
*    profiled-settings-nemo-git   
*    pulseaudio-policy-enforcement
*    qt-mobility-haptics-ffmemless-git
*    qt5-sensors-sensorfw
*    swi-prolog7
*    tzdata-timed-git

All the repositories are accessible as submodules via [jmlich/nemo-ux](https://github.com/jmlich/nemo-ux)
so you can work with them just as with the nemo-packaging repo. Some day we may merge those two repositories together.

The main issue with Manjaro repositories is that the built packages [aren’t pushed automatically](https://forum.manjaro.org/t/automation-of-package-updates/71308/2) to unstable/testing. We (Sergey and I) don’t have permission to do it manually. Spikerguy does have permission, but it takes quite some time to rebuild and update all packages one by one. We will continue ‘wild’ development outside of Manjaro probably for some time yet. The packaging itself (i.e. files in git repositories) could be probably done in their gitlab.

## Known issues

If you have troubles with pacman, installing packages, and gpg signatures. You can try to recreate keyring.

```
pacman-key --init
pacman-key --populate archlinuxarm manjaro manjaro-arm
pacman-mirrors -f5
```

You can turn it off if it doesn't help. This is very very bad and goes against fundamentals of security, but it may help you to workaround this issue:

```
sed 's/SigLevel.*/SigLevel = Optional TrustAll/' -i /etc/pacman.conf; pacman-key --init
```

## Bug to start with

Sergey fixed the [issue with Folder View](https://github.com/nemomobile-ux/glacier-home/issues/147) 
n Application Launcher. He reworked that part from scratch. I described that issue in the July blog
post as a good thing to start with. So I can cross it of my list.

![](/images/2021-10-01-nemomobile-in-october-2021/20210912105757-folder-view.png){: width="350"}

Next, I also described the [reboot issue](https://github.com/nemomobile-ux/main/issues/16) in the
same blog post. Sergey [proposed the fix](https://github.com/sailfishos/dsme/pull/2) and submited
it to upstream. The SailfishOS permission model is simply a little bit different than Manjaro one.

In one of the previous blog posts I described an issue with [updating of contacts](https://github.com/nemomobile-ux/glacier-contacts/issues/35).
I think this could be also a good starter issue. For me personally, it is a little bit harder, because
debugging across multiple components is needed. The communication is handled via dbus so it is more
tricky to find the exact place where the problem is. However, the contacts application is crucial
for a smartphone OS, so everyone will see your code when you provide a fix.

