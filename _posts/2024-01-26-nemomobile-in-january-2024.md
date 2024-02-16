---
layout: post
title: Nemomobile in January 2024
excerpt: 
modified: 2024-01-26
author: jmlich
tags: ["Qt6"]
image: 
  feature: 2024-01-26-nemomobile-in-january-2024/fosdem.jpg
  teaser: 2024-01-26-nemomobile-in-january-2024/fosdem.jpg
  thumb: 2024-01-26-nemomobile-in-january-2024/fosdem.jpg

---


Nemo in January: Qt6 experimental images available! OBS builds transitioning to Qt6, featuring the updated Lipstick package. Catch us at FOSDEM for more!

After the holiday break, work on Nemo’s development resumed. Our goal remains upgrading everything to Qt6 and preparing a functional image.

We’ve made updates to the Lipstick compositor, incorporating the latest changes from the SailfishOS tree. The new version has been tagged as 1.2.

Additionally, the [glacier-home settings plugin](https://github.com/nemomobile-ux/glacier-home/pull/228) have been modified to utilize the new Qt Quick Controls Nemo. Furthermore, numerous packages have been tagged in Git, ensuring they are ready for building with Qt6.

The first highly experimental images, built with Qt6, can be found here: [https://img.nemomobile.net/2025.05/](https://img.nemomobile.net/2025.05/) and [https://nemo.mlich.cz/images/Manjaro-ARM-nemomobile-git-pinephone-23.12.img.xz](https://nemo.mlich.cz/images/Manjaro-ARM-nemomobile-git-pinephone-23.12.img.xz)

For those interested in experiencing Nemo on Qt6, a YouTube video has been provided to offer insights into its functionality. You can watch the video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/MiTs5SGAMLE?si=aOo4oY6-fV1vPlEk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

OpenSuSE based builds are also transitioning to Qt6, with the qt6-based Lipstick available in the [Open Build Service](https://build.opensuse.org/project/show/devel:NemoMobile).

Nemomobile will be part of the [Linux on Mobile stand](https://www.linuxonmobile.net/) at FOSDEM.
