---
layout: post
title: Glacier on postmarketOS
modified: 2021-04-21
author: bart_ribbers
tags: ["postmarketOS"]
image:
  teaser: qemu-nemomobile-postmarketos-620.png
  thumb: qemu-nemomobile-postmarketos.png
---

On the 25th of March last year, I [blogged about packaging Glacier for postmarketOS]({% post_url 2020-03-25-Packaging_Glacier_for_postmarketOS %}).
Since then, a lot has changed for Nemo Mobile.
Where they previously were based on the outdated SailfishOS stack, they now moved to the more up-to-date Manjaro.
This encouraged me to try Glacier on postmarketOS again and low and behold, this time I actually got it running!

Various Mer components had to be updated and needed some new fixes, but this time Glacier is running on a fully updated Mer stack on top of postmarketOS (and in a sense, Alpine Linux).
It will not make it's way into postmarketOS stable anytime soon, but you can as of now try it out on the edge branch yourself.
It should run on any device we support, but we made a pre-built image for the PinePhone to ease installation.
You can get it from [the postmarketOS images page](https://images.postmarketos.org/pinephone/pine64-pinephone-20210421-glacier.img.xz).
You can [install it to an SDcard](https://wiki.postmarketos.org/wiki/PINE64_PinePhone_(pine64-pinephone)#Flash_to_microSD_card) or [to the internal eMMC](https://wiki.postmarketos.org/wiki/PINE64_PinePhone_(pine64-pinephone)#Flash_to_eMMC_.28advanced.29), the latter will give you a smoother user experience.
