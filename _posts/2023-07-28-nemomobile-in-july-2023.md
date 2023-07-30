---
layout: post
title: Nemomobile in July 2023
excerpt: 
modified: 2023-07-28
author: jmlich
tags: ["Qt6"]
image:
  feature: ./2023-07-28-nemomobile-in-july-2023/photo1690289233.jpeg
  teaser:  ./2023-07-28-nemomobile-in-july-2023/photo1690289233.jpeg
  thumb:   ./2023-07-28-nemomobile-in-july-2023/photo1690289233.jpeg

---



The progress of nemomobile has been focused on porting to Qt6, and significant advancements have been made in that area.

The current status is summarized in the [Move to Qt6](https://github.com/nemomobile-ux/main/issues/48) ticket on GitHub.
The PKGBUILDs are built based on the Qt6 branch of the [nemo-packaging](https://github.com/nemomobile-ux/nemo-packaging/pull/279) repository.

In terms of numbers, for Manjaro on x86_64 there are 66 failing packages and 75 passing packages. Pull requests for packages from
the mer stack (or SailfishOS stack) are being made, with the patch always attached to the nemo-packaging repository instead
of pointing to downstream repositories during the build. Additionally, the packages from the nemomobile-ux repositories are
being developed in separate branches and merged into the master branch after review.

Currently, [qt-quickcontrols-nemo](https://github.com/nemomobile-ux/qtquickcontrols-nemo/pull/41) is functioning correctly.
Despite other changes, Nemo Controls have a different name. 

Previously, the imports in the code looked like this:

```
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0
```

And now they have been updated to:

```
import Nemo.Controls
```

Some of the glacier apps have already been ported to the new controls, namely calc, filemuncher, web browser,
weather, and settings. In the case of the mer stack, the changes are compatible with Qt5. However, the glacier
apps are dropping Qt5 support.

![](/images/2023-07-28-nemomobile-in-july-2023/photo1690294062.jpeg){: height="220"}
![](/images/2023-07-28-nemomobile-in-july-2023/Screenshot_2023-07-28_10-54-36.png){: height="220"}
![](/images/2023-07-28-nemomobile-in-july-2023/Screenshot_2023-07-28_11-18-58.png){: height="220"}
![](/images/2023-07-28-nemomobile-in-july-2023/Screenshot_2023-07-28_11-28-47.png){: height="220"}
![](/images/2023-07-28-nemomobile-in-july-2023/Screenshot_2023-07-28_11-32-02.png){: height="220"}


Not all functions were tested; the applications can only be started and do not crash immediately. Any discovered bugs will be continuously fixed.

The most significant milestone achieved is that [lipstick](https://github.com/nemomobile-ux/lipstick/pull/70) can now be started,
indicating that all builds will be based on Qt6 soon. Our next objective is to address all middleware issues to restore telephony,
calendars, hardware and other functionality.

We encounter some common problems, and at times, we are unsure how to resolve them. Below are a few examples:

*  Missing function in the library, even though it exists, as seen in the case of [libqofono-qt](https://github.com/Kaffeine/libofono-qt/pull/3):

```
g++ -c -pipe -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -fexceptions -Wp,-D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security -fstack-clash-protection -fcf-protection -Wp,-D_GLIBCXX_ASSERTIONS -g -ffile-prefix-map=/nemo-packaging/libofono-qt/src=/usr/src/debug/libofono-qt -Wall -Wextra -mno-direct-extern-access -D_REENTRANT -DQT_NO_DEBUG -DQT_TESTLIB_LIB -DQT_DBUS_LIB -DQT_CORE_LIB -DQT_TESTCASE_BUILDDIR='"/nemo-packaging/libofono-qt/src/libofono-qt-1d3fa9d7523a07fc117f96c89b5f66bb03e0acd4/tests"' -I. -I../lib -I.. -I/usr/include/qt6 -I/usr/include/qt6/QtTest -I/usr/include/qt6/QtDBus -I/usr/include/qt6/QtCore -I. -I/usr/lib/qt6/mkspecs/linux-g++ -o test_ofononetworkregistration.o test_ofononetworkregistration.cpp
g++ -Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -Wl,-rpath,/usr/lib -o test_ofononetworkoperator  test_ofononetworkoperator.o   -L ../lib -lofono-qt /usr/lib/libQt6Test.so /usr/lib/libQt6DBus.so /usr/lib/libQt6Core.so -lpthread   
/usr/sbin/ld: test_ofononetworkoperator.o: in function `void QtPrivate::q_relocate_overlap_n_left_move<OfonoNetworkOperator*, long long>(OfonoNetworkOperator*, long long, OfonoNetworkOperator*)':
/usr/include/qt6/QtCore/qcontainertools_impl.h:176: undefined reference to `OfonoNetworkOperator::operator=(OfonoNetworkOperator const&)'
/usr/sbin/ld: test_ofononetworkoperator.o: in function `void QtPrivate::q_relocate_overlap_n_left_move<std::reverse_iterator<OfonoNetworkOperator*>, long long>(std::reverse_iterator<OfonoNetworkOperator*>, long long, std::reverse_iterator<OfonoNetworkOperator*>)':
/usr/include/qt6/QtCore/qcontainertools_impl.h:176: undefined reference to `OfonoNetworkOperator::operator=(OfonoNetworkOperator const&)'
/usr/sbin/ld: test_ofononetworkoperator.o: in function `QtPrivate::QGenericArrayOps<OfonoNetworkOperator>::Inserter::insertOne(long long, OfonoNetworkOperator&&)':
/usr/include/qt6/QtCore/qarraydataops.h:483: undefined reference to `OfonoNetworkOperator::operator=(OfonoNetworkOperator const&)'
/usr/sbin/ld: /usr/include/qt6/QtCore/qarraydataops.h:486: undefined reference to `OfonoNetworkOperator::operator=(OfonoNetworkOperator const&)'
collect2: error: ld returned 1 exit status
```

* Some packages rely on qmake functions that are not available in Qt6. For instance, [qtdocgallery](https://github.com/nemomobile-ux/nemo-packaging/tree/qt6/qtdocgallery) encounters the following issue:

```
qtdocgallery.pro:1: Cannot find feature qt_parts
```

* Qt6 removes certain APIs, necessitating a rewrite even if the core5compat module is present. An example is observed in [libmlocale](https://github.com/sailfishos/libmlocale/pull/3):

```
/nemo-packaging/libmlocale/src/libmlocale-0.7.6/src/mcharsetdetector.cpp:33:10: fatal error: QTextCodec: No such file or directory
   33 | #include <QTextCodec>
      |          ^~~~~~~~~~~~
compilation terminated.
```

*    Occasionally, we encounter perplexing linker errors, such as [this one](https://github.com/nemomobile-ux/nemo-packaging/tree/qt6/nemo-qml-plugin-notifications):

```
/usr/sbin/ld: plugin.o: warning: relocation against `_ZN12Notification16staticMetaObjectE' in read-only section `.text._ZZN9QtPrivate16QMetaTypeForTypeIP12NotificationE17getLegacyRegisterEvENUlvE_4_FUNEv[_ZZN9QtPrivate16QMetaTypeForTypeIP12NotificationE17getLegacyRegisterEvENUlvE_4_FUNEv]'
```

We would greatly appreciate any assistance or guidance you can offer.