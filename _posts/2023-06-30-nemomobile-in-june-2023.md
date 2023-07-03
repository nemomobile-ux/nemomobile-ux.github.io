---
layout: post
title: Nemomobile in June 2023
excerpt: 
modified: 2023-06-30
author: jmlich
tags: ["Conference", "GPS", "Automotive", "openSuSE"]
image:
  feature: ./2023-06-30-nemomobile-in-june-2023/devconf.jpg
  teaser:  ./2023-06-30-nemomobile-in-june-2023/devconf.jpg
  thumb:   ./2023-06-30-nemomobile-in-june-2023/devconf.jpg

---

During June, NemoMobile made significant strides in its development and community engagement.
A talk about NemoMobile was presented at DevConf, allowing attendees to interact with
the platform at the mobile Linux stand. A demo showcased the integration of GPS and
Bluetooth OBD2. In addition, Michal took the initiative to work on repackaging NemoMobile
for openSUSE. Lastly, the community celebrated its 10-year anniversary, marking a decade
of progress and collaboration. Exciting times lie ahead for NemoMobile as it continues
to grow and evolve.

## NemoMobile talk at DevConf

The DevConf conference, held in Brno, Czech Republic from 16th to 18th June, featured
a talk on NemoMobile. Organized primarily by Red Hat, the conference encompassed a wide
range of topics, ranging from Kubernetes and containers to Kernel development. Within
the track titled “Edge, Mobile, and Automotive,” there was a [dedicated session](https://devconfcz2023.sched.com/event/1MYj7/is-nemomobile-suitable-for-automotive) discussing
NemoMobile.

<iframe width="560" height="315" src="https://www.youtube.com/embed/tfBFaEXsRck?start=13765" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

(starting at 3:49:27)

The selection of this topic aimed to attract automotive developers, despite NemoMobile itself not specifically targeting that domain.

As part of the talk, a proof of concept was developed based on
the [QtDigitalInstrumentCluster](https://github.com/jmlich/QtDigitalInstrumentCluster) project.
This involved three essential steps:

* Determining the device’s position.
* Establishing a connection between the car and NemoMobile.
* Adapting the user interface to seamlessly integrate with NemoMobile.

While detailed information regarding the first two steps is provided below, work on the third step has not yet commenced.

## Position of the device

The primary objective was to demonstrate the utilization of the Nemo software stack in a car. To achieve this,
obtaining location data was the first step. Currently, the Nemo pipeline for acquiring location data operates as follows:

`[device]` → `/dev/EG25.NMEA` → `gpsd` → `geoclue1` → `qt-positioning` → `application`

The GPS device is accessible through the device file system. The gpsd component reads NMEA messages from the serial port
and forwards them to the file system via a socket. Its functionality can be verified using cgps, a command-line interface
that displays position and satellite details. The Qt application can retrieve information from the Qt Positioning API,
which employs providers to obtain location data. By default, the geoclue2 provider is selected, but this can be addressed
by removing the `/usr/lib/qt/plugins/position/libqtposition_geoclue2.so` file. This action enables the use of geoclue1
instead. Geoclue1 also offers providers, and their list can be found in /usr/share/geoclue-providers. Among these providers,
one is the gpsd provider, which allows for acquiring position from the GPS device. Another provider, mlsdb, leverages Mozilla
Location Services to obtain position data based on cell tower signal strength. Additionally, there are supplemental services
that facilitate downloading GPS almanac data, which expedites position fixing.

The addition of gpsd as an extra module and the decision to compile with the parameter `--with-gpsd=no`, as well as
the non-utilization of geoclue2, have raised questions. While there were specific requirements that led to these choices,
we anticipate being able to migrate to geoclue2 in the near future.

## Car instruments

Ideally, a direct connection to the CAN BUS and the use of a robust stack like Qt IVI would be the recommended approach.
However, for the purpose of this demonstration, the OBD2 (specifically ELM 327) was employed, connected via Bluetooth.
The bluetoothctl utility was utilized to pair and establish a trusted connection with the device. The Digital Instrument
Cluster (DIC) expects to be connected via a serial line, which can be established using the command `rfcomm bind 0 de:ad:be:ef:00:00`.
Unfortunately, for unknown reasons, the device failed to establish a successful connection, resulting
in the inability of minicom to send commands and receive responses.

![](/images/2023-06-30-nemomobile-in-june-2023/automotive.jpg){: height="350"}

## DevConf mobile linux booth

The NemoMobile project was showcased at the mobile Linux stand during Friday and Sunday. Visitors had the opportunity to experience
NemoMobile firsthand on the PinePhone and compare it with a slightly outdated version of NemoMobile running on the development
device Nokia N950. Alongside NemoMobile, the stand also featured demonstrations of Phosh on the Librem 5, PinePhone, and OnePlus 6.
The Librem 5 showcased its ability to transform into a computer by connecting it to a screen. The UBPorts project demonstrated
its capabilities on the Volla Phone. Last but not least, Maemo leste was presented on the PinePhone.

![](/images/2023-06-30-nemomobile-in-june-2023/booth1.jpg){: height="300"}
![](/images/2023-06-30-nemomobile-in-june-2023/booth2.jpg){: height="300"}
![](/images/2023-06-30-nemomobile-in-june-2023/booth3.jpg){: height="300"}
![](/images/2023-06-30-nemomobile-in-june-2023/booth4.jpg){: height="180"}
![](/images/2023-06-30-nemomobile-in-june-2023/booth5.jpg){: height="180"}
![](/images/2023-06-30-nemomobile-in-june-2023/booth6.jpg){: height="180"}

Other interesting devices were also showcased, such as the Blackberry Q10, Xilinx Zynq based CTU Devboard, and TI Sitara board,
despite not running a mobile phone distribution. These devices added to the overall diversity and interest of the exhibition.

## 10 years aniversary

The NemoMobile community has been active for at least 10 years, and throughout this time, it has gathered numerous incredible
individuals. Despite working on other projects, these amazing people have made significant contributions to the NemoMobile
community. Their dedication and hard work are greatly appreciated, and their efforts have been instrumental in shaping
the success of NemoMobile. Thank you for your exceptional work and commitment!

![](/images/2023-06-30-nemomobile-in-june-2023/meetup-2013.jpg)

## Rebuilding packages for openSuSE

Michał has taken the initiative to repackage Nemo for openSuSE. He recognized that the OBS (Open Build Service)
and the development environment it provides are comfortable for him, and he believes that this approach will lower
the barrier for his contributions. Currently, the repository consists of 20 packages out of a total of 150. You can 
find the repository at [https://build.opensuse.org/project/show/devel:NemoMobile](https://build.opensuse.org/project/show/devel:NemoMobile).
You are welcome to join this initiative and contribute to the effort. Feel free to participate and support
the rebuilding of Nemo for openSuSE.