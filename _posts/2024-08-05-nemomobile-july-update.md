---
layout: post
title:  Nemomobile July Update
excerpt: "Nemo Mobile updates 🚀📱 in June and July 2024: Glacier Home's search bar now uses a plugin-based interface, Qt Quick Controls Nemo got enhancements and fixes, and Glacier Weather's API was modularized for easier integration."
modified: 2024-08-05
author: jmlich
tags: ["Controls", "Home", "Weather"]
image:

---

In June and July 2024, Nemo Mobile saw various improvements: Glacier Home’s search bar was reworked into a plugin-based interface,
Qt Quick Controls Nemo received enhancements and fixes, and the Glacier Weather application was modularized for easier integration.

## Glacier Home

The home screen now features a reworked search bar, transitioning from a hardcoded system to a plugin-based interface. This
change reduces dependencies by removing the hardcoded contact list search, which previously required nemo-qml-contacts-plugin
and other libraries. As a result, Glacier Home now has fewer mandatory dependencies. Additionally, the interface for controlling
music players was transitioned from Qt MPRIS to Amber MPRIS. The calculation of home screen icon sizes was also fixed.

## Qt Quick Controls Nemo

Qt Quick Controls Nemo, the set of UI components designed specifically for Nemo Mobile, was also improved. Fragment shader
issues in the Nemo Icon, which had affected color adaptability since the migration to Qt6, were resolved. The computation
of component sizes in Qt Quick Controls Nemo now relies on settings values, enhancing customization and ease of use.

## Glacier Weather

The Glacier Weather application underwent rework as well. The OpenWeather API was moved into a module, allowing for easier
use in other projects. This modularization simplifies integration and makes the API more accessible for developers.
