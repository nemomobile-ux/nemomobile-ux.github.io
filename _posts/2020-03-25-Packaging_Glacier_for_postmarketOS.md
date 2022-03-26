---
layout: post
title: Packaging Glacier for postmarketOS
modified: 2020-03-25
author: bart_ribbers
tags: ["postmarketOS"]
image:
  teaser: postmarketos-logo.svg
  thumb: postmarketos-logo.svg
---

About 3 years ago, before I started working on postmarketOS, I learned of the existence of Glacier.
Back then I still used my Jolla Phone and the promise of a completely FOSS UI instead of the proprietary one that came with SailfishOS was very exciting to me.
However, it was still very much a work in progress system back then, and I kind of forgot about it.
Last year I came by it again, and since I started working on postmarketOS, it seemed only right to package it.
But, it still depending on the EOL Qt 5.6 prevented me from doing anything interesting with it.
We were on Qt 5.12 after all and there was no chance we'd separately package an older Qt version just for this UI.

Since Nemo Mobile [has come "back to live" recently]({% post_url /main/2020-03-24-Wake_up_nemo %}), and it talks about porting to Qt 5.12, I decided to take another shot at packaging Mer and eventually Glacier.
Now, first to temper any excitements anyone may have, no it doesn't work, _yet_.
The first problem is that while working on Qt 5.12 is nice, postmarketOS is actually on Qt 5.14.
It should however be a relatively small upgrade from 5.12, rather than coming from 5.6.

# Problems encountered

While packaging Mer components, you'll notice it isn't made to run on a non-glibc, non-systemd system.
Because of this you encounter some, relatively small, problems.
Luckily they were quite easy to resolve, and I've tried to upstream the fixes wherever possible.
Some of these merge requests have even been merged already!

* [nemo-qml-plugin-devicelock uses an outdated way of finding systemd](https://git.sailfishos.org/mer-core/nemo-qml-plugin-devicelock/merge_requests/46). This caused issues with our elogind
* [timed uses an outdated way of finding systemd](https://git.sailfishos.org/mer-core/timed/merge_requests/19#note_43061)
* [lipstick uses an outdated way of finding systemd](https://git.sailfishos.org/mer-core/lipstick/merge_requests/135#note_43056)
* [libresource pkconf version detection breaks when compilation is done within a Git repo, but that repo is not from libresource itself](https://git.sailfishos.org/mer-core/libresource/merge_requests/5). On postmarketOS and Alpine Linux, a build is done within an aports Git tree. A script to determine what package version is being compiled breaks because of this and causes an invalid pkconf version
* [usb-moded depends on glibc's TEMP_FAILURE_RETRY](https://git.sailfishos.org/mer-core/usb-moded/merge_requests/57). This is not available on Musl and will thus break
* [profiled depends on glibc's TEMP_FAILURE_RETRY](https://git.sailfishos.org/mer-core/profiled/merge_requests/5)
* [mce-dev uses Busybox incompatible install statements in the Makefile](https://git.sailfishos.org/mer-core/mce-dev/merge_requests/13). We could of course just install GNU Coreutils, but of course it's better to fix it upstream rather than using a workaround
* [nemo-qml-plugin-systemsettings doesn't include types.h](https://git.sailfishos.org/mer-core/nemo-qml-plugin-systemsettings/merge_requests/136). On Musl this means `uid_t` will be undefined and breaks compilation
* [libiodata doesn't include unistd.h](https://git.sailfishos.org/mer-core/libiodata/merge_requests/4#note_43052). This means that `getopt` is undeclared and breaks compilation
* [libmlocale uses deprecated Qt functions and -Werror is set](https://git.sailfishos.org/mer-core/libmlocale/merge_requests/10#note_43043). I found it easier to just replace the deprecated functions for std equivalents than finding out how to fix the configure script to actually abide to `--no-werror`

Of course there is also some stuff that isn't fit for upstreaming.
For example, to make `nemo-qml-plugin-systemsettings` compile, I had to completely remove the developer mode settings page.
Luckily this page doesn't make sense anyway on postmarketOS as it's very tied to SailfishOS, so it can't hurt to remove it.

# Work left to do still

Besides having to wait till at least `lipstick` (the Wayland compositor used by Glacier) works on Qt 5.14 (without patches to Qt!), there is more to package.
So far only the base Mer components have been packaged, and even then not everything yet. Now the base work is done however, I can start working on packaging Glacier components.

Hopefully I'll soon have something for you all to test!

You can see the packages so far in [the `feature/sailfish` branch of `pmaports`](https://gitlab.com/postmarketOS/pmaports/-/tree/feature/sailfish/sailfish).

By the way, there is also work being done to package Glacier for Arch Linux! Check it out [here](https://github.com/nemo-packaging).
