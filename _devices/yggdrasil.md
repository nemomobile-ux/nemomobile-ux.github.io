---
image:
  feature: ./2021-12-07-nemomobile-on-volla-phone/20211119_004-1-1024x577.jpg
  teaser: ./2021-12-07-nemomobile-on-volla-phone/20211119_004-1-1024x577.jpg
  thumb: ./2021-12-07-nemomobile-on-volla-phone/20211119_004-1-1024x577.jpg
name: "Volla Phone"
deviceType: "phone"
portType: "Halium 9.0"
deviceReleased: 2020
linuxKernel: 4.4
nemoVersion: nightly-2021-11-28
buyLink: "https://volla.online/de/shop/"
installLink: "https://nemomobile.net/pages/nemomobile-on-volla-phone/"
description: "Volla Phone, A startup focused on simplicity and privacy for the average user. It’s a solid mid-range device with eight-core, produced by Gigaset. This device falls nicely in the hands, and it has an outstanding screen/body ratio. On the other hand, it has slight incompatibility with the UT navigation bar. But, overall, it is working very smoothly and relatively responsive."
tag: "promoted"
subforum: "90/vollaphone"
portStatus:
  - categoryName: "Actors"
    features:
      - id: "manualBrightness"
        value: "Y"
      - id: "torchlight"
        value: "N"
      - id: "vibration"
        value: "N"
  - categoryName: "Camera"
    features:
      - id: "flashlight"
        value: "N"
      - id: "photo"
        value: "N"
      - id: "video"
        value: "N"
      - id: "switchCamera"
        value: "N"
  - categoryName: "Cellular"
    features:
      - id: "carrierInfo"
        value: "Y"
      - id: "dataConnection"
        value: "?"
      - id: "dualSim"
        value: "N"
      - id: "calls"
        value: "N"
      - id: "mms"
        value: "N"
      - id: "pinUnlock"
        value: "?"
      - id: "sms"
        value: "N"
      - id: "audioRoutings"
        value: "N"
      - id: "voiceCall"
        value: "N"
      - id: "volumeControl"
        value: "?"
  - categoryName: "Endurance"
    features:
      - id: "batteryLifetimeTest"
        value: "?"
      - id: "noRebootTest"
        value: "?"
  - categoryName: "GPU"
    features:
      - id: "uiBoot"
        value: "Y"
      - id: "videoAcceleration"
        value: "Y"
  - categoryName: "Misc"
    features:
      - id: "anboxPatches"
        value: "?"
      - id: "batteryPercentage"
        value: "Y"
      - id: "onlineCharging"
        value: "Y"
      - id: "factoryReset"
        value: "?"
      - id: "rtcTime"
        value: "?"
      - id: "sdCard"
        value: "?"
      - id: "shutdown"
        value: "?"
  - categoryName: "Network"
    features:
      - id: "bluetooth"
        value: "N"
      - id: "flightMode"
        value: "?"
      - id: "hotspot"
        value: "?"
        overrideGlobal: true
      - id: "nfc"
        value: "?"
      - id: "wifi"
        value: "Y"
  - categoryName: "Sensors"
    features:
      - id: "autoBrightness"
        value: "N"
      - id: "fingerprint"
        value: "N"
      - id: "gps"
        value: "N"
      - id: "proximity"
        value: "N"
      - id: "rotation"
        value: "N"
      - id: "touchscreen"
        value: "Y"
  - categoryName: "Sound"
    features:
      - id: "earphones"
        value: "?"
      - id: "loudspeaker"
        value: "Y"
      - id: "microphone"
        value: "Y"
      - id: "volumeControl"
        value: "Y"
  - categoryName: "USB"
    features:
      - id: "mtp"
        value: "N"
      - id: "rndis"
        value: "P"
deviceInfo:
  - id: "cpu"
    value: "Octa-core ARM Cortex-A53 (4x 2.0 GHz + 4x 1.5 GHz cores)"
  - id: "chipset"
    value: "MediaTek Helio P23, MT6763V"
  - id: "gpu"
    value: "ARM Mali-G71 MP2 @ 770 MHz, 2 cores"
  - id: "rom"
    value: "64 GB, eMMC"
  - id: "ram"
    value: "4 GB, DDR3"
  - id: "android"
    value: "9.0 (Pie)"
  - id: "battery"
    value: "4700 mAh, 18.1 Wh, Li-Polymer"
  - id: "display"
    value: '6.3" IPS, 1080 x 2340 (409 PPI), V-notch, Rounded corners'
  - id: "rearCamera"
    value: "16MP (f/2.0, 1080p30 video) + 2MP (for bokeh/depth), PDAF, LED flash"
  - id: "frontCamera"
    value: "16MP"
  - id: "arch"
    value: "arm64"
  - id: "dimensions"
    value: "157 mm x 75.1 mm x 9.65 mm"
  - id: "weight"
    value: "190 g"
contributors:
  - id: erik_inkinen
externalLinks:
  - name: "Device source"
    link: "https://github.com/manjaro-libhybris/volla-yggdrasil-post-install"
    icon: "github"
  - name: "Kernel source"
    link: "https://github.com/HelloVolla/android_kernel_volla_mt6763/tree/halium-9.0"
    icon: "github"
---