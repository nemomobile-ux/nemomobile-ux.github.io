---
layout: post
title: Status matrix July/2021
modified: 2021-07-30
author: jmlich
tags: ["Test", "PinePhone"]
image:
  feature: Manjaro_Pinephone_twitter_draft1b.jpg
  teaser: Manjaro_Pinephone_twitter_draft1b-620.jpg
  thumb: Manjaro_Pinephone_twitter_draft1b.jpg
---

This is review of current status. The features was tested on PinePhone BraveHeart with image made using [Github Actions](https://github.com/jmlich/nemo-images/releases). What works and what doesn’t work?

<iframe width="560" height="315" src="https://www.youtube.com/embed/IV1uIGQxENY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

&nbsp;

| feature  | status  | comment  |
|----------|---------|----------|
| boots into graphics	|	✓	|	takes 3 minutes (mce daemon)                                                |
| glacier-dialer/phone calls	|	×	|	ofonoctl list says denied                                           |
| settings: 3G/4G connection	|	×	|	ofonoctl list says denied                                           |
| glacier-contacts	|	~	|	can create/edit/delete/import contacts                                          |
| glacier-messages / SMS	|	×	|	seems to be dead without modem  other telepathy messaging is not accessible  |
| glaceir-camera	|	×	|	black screen only                                                               |
| megapixels	|	✓	|	no video, pictures only, “poor quality” (but it probably issue of the sensor)       |
| settings: wifi	|	✓	|	don’t show anything in saved connections                                        |
| settings: bluetooth	|	✓	|	discovery worked (didn’t try to connect)                                    |
| glacier-email	|	~	|	proof of concept                                                                    |
| glacier-gallery	|	✓	|	tracker sometimes doesn’t show any picture                                      |
| glacier-music	|	✓	|	plays music, don’t know if headphones/phone calls will switch profile               |
| fingerterm	|	✓	|	works great                                                                         |
| settings: usb networking	|	✓	|	`manjaro@192.168.2.15` + `123456`                                           |
| settings: usb MTP	|	×	|	doesn’t work for me                                                             |
| settings: languages	|	×	|	proposed solution with `~/.xprofile`                                          |
| glacier-browser	|	✓	|	qtwebengine, not very fast, not always “mobile”                                 |
| settings: wallpaper	|	✓	|	same as glacier-gallery, cannot set default wallpaper easily                |
| glacier-calc	|	✓	|	works like a charm                                                                  |
| notifications	|	✓	|	works, needs applications                                                           |
| glacier-alarm	|	×	|	no application for that, should wakeup device                                       |
| glacier-calendar	|	×	|	no application for that                                                         |
| NFC	|	~	|	didn’t tried                                                                                |
| positioning (GPS)	|	~	|	it showed position from geoclu, not sure if works                               |
| glacier-maps	|	×	|	missing, could be done with modRana or pure-maps?                                   |
| power saving / wakeup 	|	~	|	Some issue which turns of screen. Cannot test with Brave Heart edition. Battery life should be measured. |
| volume control	|	×	|	Doens’t work                                                                    |
| power key	|	×	|	dsme/priviledged user issue, overlay                                                    |
| maliit keyboard	|	~	|	mostly works, incorrect minimizing, doens’t work with gtk apps                  |
| package management	|	~	|	pacman -S package, broken pacman gpg keys, UI application is not available  |
| gtk apps	|	×	|	keyboard doesn’t show, theme is not mobile                                              |
| anbox/waydroid	|	×	|	megi kernel doesn’t have necessary modules                                      |
| flatpak	|	✓	|	desktop icon isn’t created, keyboard not working                                        |
| glacier-weather	|	×	|	some app with OS integration should be done yet |
| flashlight/torch	|	×	|	To be done yet. |

You can compare state of nemomobile with [ubuntu touch](https://devices.ubuntu-touch.io/device/pinephone/) or with [postmarketOS](https://wiki.postmarketos.org/wiki/PINE64_PinePhone_(pine64-pinephone)).
