---
layout: post
title: Nemomobile in August 2023
excerpt: 
modified: 2023-08-27
author: jmlich
tags: ["Qt6"]
image: 
  feature: null
  teaser: null
  thumb: null

---
Our transition to Qt6 is currently underway. As of now, 24 out of the 43 tasks have been completed, and there is a growing number of pending tasks.
Certain changes have already been integrated into the upstream codebase, such as timed or sensorfw. Notably, our lipstick’s building process now
utilizes CMake. While we have successfully removed the qt6-systems dependency, it’s important to highlight that glacier-home remains incompatible
with qt6 and cannot be built. On another note, the count of Nemo packages, based on OpenSuSE, has seen an increase of 28 packages, bringing the
total to 49 packages hosted on OBS. Further details of all changes can be viewed in the Git repository.