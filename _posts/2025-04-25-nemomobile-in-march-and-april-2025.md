---
layout: post
title: Nemomobile in March and April 2025
excerpt: This update covers recent progress in the Nemo Mobile project on Manjaro. Key highlights
    include fixes for pulseaudio-modules-nemo, advances in the Kremium library, the removal
    of outdated Telepathy components, and new GitHub-based CI. Several packages were updated
    or fixed, and Nemo successfully booted on the Orange Pi 3B v2.
modified: 2025-04-25
author: jmlich
tags: ["Kremium", "Device lock", "Maliit"]
image: 
  feature: 2025-04-25-nemomobile-in-march-and-april-2025/5213158676444082200.jpg
  teaser: 2025-04-25-nemomobile-in-march-and-april-2025/5213158676444082200.jpg
  thumb: 2025-04-25-nemomobile-in-march-and-april-2025/5213158676444082200.jpg
comments:
  host: mastodon.social
  username: nemomobile
  id: 114405366648025682
---

This update covers recent progress in the Nemo Mobile project on Manjaro.
Key highlights include fixes for pulseaudio-modules-nemo, advances in the
Kremium library, the removal of outdated Telepathy components, and new
GitHub-based CI. Several packages were updated or fixed, and Nemo
successfully booted on the Orange Pi 3B v2.

`pulseaudio-modules-nemo` wasn’t compiling because Manjaro has moved to PipeWire.
However, there’s a compatibility package called manjaro-pulse that
[allows the module to be compiled](https://github.com/nemomobile-ux/nemo-packaging/commit/a06f4c9bf8b3cccd6de781614e42a4ebbbf1a614).
Since Lipstick depends on `pulseaudio-modules-nemo`, it wasn’t possible to recompile
it until this workaround was used.

In a previous blog post, the Kremium package was introduced. It is an open-source, drop-in
replacement for the SailfishOS Silica library. Kremium has a strong dependency on the
Qt Quick Controls Nemo component, and it aims to make recompiling SailfishOS packages
for Nemo possible. To support Kremium, some changes were made to Qt Quick Controls Nemo
to simplify its usage. However, these changes broke compatibility with some Glacier apps,
which now require fixes. Specifically, the `Theme` object has been moved to `import Nemo`,
which is not included everywhere by default. Additionally, the syntax for accessing sizes
has changed from `size.dp(5)` to `Theme.size(5)`. The glacier-settings package has already
been updated to reflect these changes.

Phone calls and messaging were handled through the Telepathy framework. It is complex and
difficult to understand, and porting it to Qt6 would require a significant amount of work.
Additionally, it currently doesn’t work well with Nemo. As a result, 
[all related components have been dropped](https://github.com/nemomobile-ux/nemo-packaging/commit/e3a85bc9724500732375cb9aea8d270d6f8ff028)
in Nemo. This was somewhat expected and has been suggested for quite some time, so it
shouldn’t come as a big surprise.

[GitHub Actions](https://github.com/neochapay/manjaro-ci-test/releases/tag/unstable-1.2.8-1) are
used for continuous integration. A new repository group has been created at
[https://github.com/NemoOnManjaro/](https://github.com/NemoOnManjaro/). Commits to this group
should immediately trigger package builds, which are then published to the
[https://img.nemomobile.net/manjaro/](https://img.nemomobile.net/manjaro/) package repository
for each branch. This setup is intended to accelerate package updates.

Nemo boot and initial setup were demonstrated on the Orange Pi 3B v2.

<iframe width="560" height="315" src="https://www.youtube.com/embed/SAlY0U5XIj4?si=UCsM4MbOSvMbC_oO" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

A number of packages were updated, including `sensorfw`, `mlite`, `libngf-qt`, and `libphonenumber-nemo`.
Colors and icons in glacier-settings were fixed, and the Glacier Web Browser was rebuilt
[using the new WebEngine](https://github.com/nemomobile-ux/glacier-browser/commit/11f1e67a4cc932ed62207436f541080ab55ac690).
[Content rotation handling](https://github.com/nemomobile-ux/glacier-home/commit/72cbd52ade310fd7e1e3ce7c45078479394b0279)
in `glacier-home` was reworked, and `glacier-device-lock` [was fixed](https://github.com/nemomobile-ux/glacier-devicelock-plugin/commit/49b7acc1d24c5e791f66f0724f8ed5dc4ce65b03)—the
issue was partly due to the path where files were installed. The `glacier-packagemanager` build was previously broken
[but should now work](https://github.com/nemomobile-ux/glacier-packagemanager/commit/3ebd3d6a92dec8493a76218ac11502b38bef5283);
it is one of the packages required for image rebuilding. The Maliit on-screen keyboard was [also fixed](https://github.com/nemomobile-ux/maliit-nemo-keyboard/commit/fc7073840be9109baff799149c8fcd4f60b56121).

<iframe width="560" height="315" src="https://www.youtube.com/embed/1OFwqrlXKrw?si=QuULGvKNceYDfocm" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
