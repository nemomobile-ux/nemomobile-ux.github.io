---
layout: post
title: Begining with Nemomobile
modified: 2021-04-30
author: jmlich
tags: [main]
image:
  teaser: 2021-04-30-begining-with-nemomobile/Screenshot_manjaro.png 
  thumb: 2021-04-30-begining-with-nemomobile/Screenshot_manjaro.png 
---

There is an effort to build friendly, mobile, and open Qt based user interface since Meego Harmatan and Nokia N9 was widely
used. The Jolla Ltd. did pretty nice job with Sailfish OS in the past. I am still using Jolla 1, which now reached its EOL.
Its time to look on new options. My hacker’s heart belongs to open source. I am lucky that there is a nemomobile project for me.

The system was originally based on mer-project which was derivative of Intel’s MeeGo and Nokia MeeGo. At the time of
introduction, it had very advanced features such as wayland or systemd. Currently, it is sticking with old version packages
especially old Qt. Therefore nemo decided to move somewhere else.

First step was leading to Fedora. It showed up that Fedora have too new packages and to fast development. For instance
the package [tut](http://mrzechonek.github.io/tut-framework/) is relying on python based builder called waf, which is
not working with python 3.7. I was considering preparing COPR repository, but my progress was rather slow to reach dream goal.
Second step was going to [Manjaro Linux](https://www.manjaro.org/) which is derivative of Arch Linux.

Sergey has prepared [packages](https://www.manjaro.org/) for x86_64 and aarch64 and [rootfs image](https://img.nemomobile.net/devel/Manjaro-ARM-nemomobile-pinephone-0.2.img.xz)
for PinePhone. Its status is between alpha version and something before alpha version. It just boots into UI and shows the desktop. Even image gallery doesn’t work.

PureTryOut is working on [postmarketOS port](http://nemomobile.net/pages/Hello-postmarketOS/). His changes are currently in master branch so anyone can try it. The images for
PinePhone are available as well. The postmarketOS already have [some apps for phones](https://www.youtube.com/watch?v=Gxin52CVq24), but there will be definitely a lot of
work with adaption both glacier and underlying operating system.

# Packaging

The Arch Linux way of software packaging looks very soft and clean for me. It consist of bash functions and variables. Very straightforward and efficient. It looks like this:

```
pkgname=tut-git
_srcname=tut
pkgver=0.0.5.r0.ge9ee8f0
pkgrel=1
pkgdesc="Sailfish C++ unit test framework"
arch=('x86_64' 'aarch64')
url="https://git.sailfishos.org/mer-core/tut"
license=('BSD')
depends=()
makedepends=('git' 'python2')
optdepends=()
provides=("${pkgname%-git}")
conflicts=("${pkgname%-git}")
source=(
  "${pkgname}::git+${url}.git"
)
sha256sums=('SKIP')

pkgver() {
  cd "${srcdir}/${pkgname}"
  ( set -o pipefail
    git describe --long --tags | sed 's/\([^-]*-g\)/r\1/;s/-/./g' ||
    printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
  ) 2>/dev/null
}

build() {
  cd "${srcdir}/${pkgname}"
  python2 ./waf configure --prefix=/usr --version="0.0.4"
  python2 ./waf build
}

package() {
  cd "${srcdir}/${pkgname}"
  python2 ./waf install --destdir="${pkgdir}"
}
```


The version is defined such as a variable, but it could be modified by pkgver function which is rather
strange for me.

In contrary to redhat or debian based systems Manjaro and Arch Linux are using `pacman` to install
packages. It syntax looks rather obfuscative to me and I need to Google almost every command.

All `PKGBUILD` scripts for nemo are placed in [single repository](https://github.com/nemomobile-ux/nemo-packaging). The makepkg command triggers
build in current directory. It downloads repository from git, applies patches, does the build
it self and creates Arch Linux package. For some reason Arch Linux removes debug information
by default. [It must be added manually](https://wiki.archlinux.org/title/Debug_-_Getting_Traces). It doesn’t have -debuginfo sub-packages unlike Fedora
or CentOS. Instead of [ABRT](https://abrt.readthedocs.io/en/latest/) is used `systemd-coredump`. Without debug info it doesn’t say much
about crash anyway. There is `buildpkg` tool which make chroot for build, but I am not sure how
to use it properly.

# Installing

You can install prepared image or install standard Manjaro and add nemo packages into it. The packages built by `makepkg` or
`buildpkg` or its ARM version could be installed using pacman. It could be used directly on file or via repo created using
`repo-add` command. Newly created repo should be added into `/etc/pacman.conf` by adding following snippet:

```
[nemomobile]
SigLevel = Optional
Server = http://img.nemomobile.net/manjaro/05.2020/stable/$arch/
```

Then you can install packages which you want. In my case all packages in repository:

```
pacman -S --noconfirm $(pacman -Slq nemomobile)
```

# Running

If you are lucky, then you can reach all required packages and run nemo, glacier, or whatever it is called.
The prepared image is hard wired to start Glacier UI and have preset configuration suitable for PinePhone.

For debugging of the User Interface is virtual machine sufficient. It is easier to recover system when it
stops booting. I was starting UI manually from terminal with `lipstick` command. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/NVxvZwRNzgk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

# Contributing

The project needs a lot of love right now. I am trying to look around and get familiar with it. The people
on [telegram group](https://telegram.me/NemoMobile) are very kind. I did a few very raw changes and
nevertheless all my merge request was accepted.

# Going to device

It seems there is good tutorial to prepare image for Pine Phone or other device with manjaro-arm-tools.