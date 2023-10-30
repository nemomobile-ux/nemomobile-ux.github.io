---
layout: post
title: Nemomobile in September 2023
excerpt: 
modified: 2023-09-29
author: jmlich
tags: ["Qt6", "openSuSE"]
image: 
  feature: ./2023-09-29-nemomobile-in-september-2023/photo1695508858.jpeg
  teaser: ./2023-09-29-nemomobile-in-september-2023/photo1695508858.jpeg
  thumb: ./2023-09-29-nemomobile-in-september-2023/photo1695508858.jpeg

---
In September, only a few commits were made. Work on porting to Qt6 is still in progress, and efforts to enable builds with OpenSuSE are also advancing. We invite you to participate in our project during Hacktoberfest.

## Qt6

The work on porting to Qt6 is progressing at a slow pace. Currently, there are 113 passing packages and 35 failing ones. The lipstick compositor is operational, allowing the creation of basic user interface images. However, the maliit virtual keyboard remains unavailable, making it impossible to enter WiFi passwords in the settings app.

Here is the current to-do list:

* Port maliit to Qt6.
* Address the absence of telepathy-qt and telepathy-mission-control for telepathy-ofono.
* Investigate the uncommitted version of qtdocgallery, which is encountering a QMetaType-related error.
* Resolve issues in libcommhistory, where the GCC generates extensive error messages about templates.
  `error: invalid use of incomplete type ‘class CommHistory::Group`
* Address the complexity of qmf-qt5, which already has 37 patches.
* Consider rewriting glacier-camera due to changes in the Qt Multimedia API, and explore compatibility with the Pinephone camera and Qt Multimedia API.
* Assess the status of glacier-music, which already has a patch but is undergoing ongoing refactoring that must be completed and merged or discarded.
* Decide whether to continue development of archived projects and projects based on them, such as nemo-qml-plugin-signon.

## OpenSuse

The number of packages in the Open Build Service has grown to 60. It is now possible to run lipstick.

## Hacktoberfest

We’re in search of individuals who can help us, just as we’ve always done. Hacktoberfest offers a chance to earn a tangible reward for your contributions. While in other months, our way of saying thanks suffices, October brings an exciting opportunity. If your 3 patches get merged into the repository with the #hacktoberfest tag, Digital Ocean will send you a t-shirt. All that’s required is your registration on the Hacktoberfest page. If this tag is missing, please add a note to your pull request.