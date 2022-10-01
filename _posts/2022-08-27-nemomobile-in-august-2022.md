---
layout: post
title: Nemomobile in August 2022
excerpt: 
modified: 2022-08-27
author: jmlich
tags: ["Manjaro", "Pin Query", "Keyboard"]
image:
  feature: ./2022-08-27-nemomobile-in-august-2022/featured.jpg
  teaser: ./2022-08-27-nemomobile-in-august-2022/featured.jpg
  thumb: ./2022-08-27-nemomobile-in-august-2022/featured.jpg

---

The speed of development is slowing down a little. In August the Manjaro packaging, the pin query application, and the on-screen keyboard were improved.

## Manjaro packaging

The Manjaro packaging was updated in git and in package repositories. Nemomobile can now built without extra repositories.

[![twitter](/images/2022-08-27-nemomobile-in-august-2022/twitter-image-build.png)](https://twitter.com/neochapay/status/1558178715179286529)

```
buildarmimg -d pinephone -e nemomobile -v 0.99 -b unstable
```

## glacier-pinquery

The Pin Query application got some improvement. First, it was migrated to [qt quick compiler](https://github.com/nemomobile-ux/glacier-pinquery/commit/46e25b57a4c39f0269b7c1f08d4de936adfd945d)
like other applications. Tests showed that the application actually doesn’t work at all. It is not possible to enter the PIN code. It doesn’t use the glacier theme. The colors don’t fit the light theme or the dark one.

![](/images/2022-08-27-nemomobile-in-august-2022/pinquery-old.png){: height="400"}
![](/images/2022-08-27-nemomobile-in-august-2022/pinquery-update1.png){: height="400"}
![](/images/2022-08-27-nemomobile-in-august-2022/pinquery-update2.png){: height="400"}

It is likely that the whole dialog will be redesigned in the future.

## Keyboard

The keyboard got a lot of improvements. Qt-quickcontrols-nemo now contains a [showcase](https://github.com/nemomobile-ux/qtquickcontrols-nemo/commit/58ade7c031752947e1695794a82ee840e8e807d0)
for various input method hints. The keyboard itself now reacts to them. This means that
it now changes [layout when numbers](https://github.com/nemomobile-ux/maliit-nemo-keyboard/commit/0ddaf28c396357e5df0d1248414ae6ee4d201c69),
email addresses, dates, times, etc. are expected.

<video controls autoplay loop> <source src="/images/2022-08-27-nemomobile-in-august-2022/simplescreenrecorder-2022-08-24_15.58.44.mp4" /></video>

The [layout support](https://github.com/nemomobile-ux/maliit-nemo-keyboard/commit/c3568b4c7d396e63e4c1adfa5af29413fbd0d1ce) was reworked. They are now stored in JSON files. The structure was originally designed to support accented characters. Now, they are finally implemented.

![](/images/2022-08-27-nemomobile-in-august-2022/keyboard.jpg){: max-width="100%" width="800"}

The prototype of [predictive input](https://github.com/nemomobile-ux/maliit-nemo-keyboard/commit/a7de3b052dc885699eb843fcc11c7ab57e0c0b3d) was also improved and was finally merged into the master branch.

<video controls autoplay loop> <source  src="/images/2022-08-27-nemomobile-in-august-2022/simplescreenrecorder-2022-08-26_14.21.15.mp4" /></video>
