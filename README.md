# whatsapp_clone

A new Flutter project.

## Flutter Logs Framework

```dart
import 'package:flutter/material.dart';

void main() {
  debugPrint('HELLOOO !!');
  debugPrint('Berasal dari debugPrint - import from material.dart'); 
}
```

```txt
PS E:\Flutter_Sukses\whatsapp_clone> flutter logs
Showing Android SDK built for x86 logs:
I/flutter (24593): HELLOOO !!
I/flutter (24593): Berasal dari debugPrint - import from material.dart
```

## Firebase Configuration for both platform using Flutter CLI

```txt
Firebase configuration file lib\firebase_options.dart generated successfully with the following Firebase apps:

Platform  Firebase App Id
android   1:398918307760:android:b594661c43a253d93d9075
ios       1:398918307760:ios:00696766ea46cd5d3d9075
```

### Android SHA-1 fingerprint for Firebase Configuration

<https://stackoverflow.com/questions/15727912/sha-1-fingerprint-of-keystore-certificate>

```txt
PS E:\Flutter_Sukses\whatsapp_clone\android> ./gradlew signingReport

> Task :app:signingReport
Variant: debug
Config: debug
Store: C:\Users\User\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 58:E1:67:23:3F:57:CD:22:BE:CE:AB:50:46:90:7D:31
SHA1: 35:0D:6A:38:A7:53:AE:77:EC:D0:61:32:47:32:FD:ED:2F:CA:0C:AA
SHA-256: 9A:CA:D2:1A:12:7A:CD:1A:01:52:F4:E2:DA:EC:B0:E1:35:F8:73:11:27:C8:84:A9:F4:D2:98:EA:D8:1C:D4:43
Valid until: Friday, February 7, 2053
----------
Variant: release
Config: debug
Store: C:\Users\User\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 58:E1:67:23:3F:57:CD:22:BE:CE:AB:50:46:90:7D:31
SHA1: 35:0D:6A:38:A7:53:AE:77:EC:D0:61:32:47:32:FD:ED:2F:CA:0C:AA
SHA-256: 9A:CA:D2:1A:12:7A:CD:1A:01:52:F4:E2:DA:EC:B0:E1:35:F8:73:11:27:C8:84:A9:F4:D2:98:EA:D8:1C:D4:43
Valid until: Friday, February 7, 2053
----------
Variant: profile
Config: debug
Store: C:\Users\User\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 58:E1:67:23:3F:57:CD:22:BE:CE:AB:50:46:90:7D:31
SHA1: 35:0D:6A:38:A7:53:AE:77:EC:D0:61:32:47:32:FD:ED:2F:CA:0C:AA
SHA-256: 9A:CA:D2:1A:12:7A:CD:1A:01:52:F4:E2:DA:EC:B0:E1:35:F8:73:11:27:C8:84:A9:F4:D2:98:EA:D8:1C:D4:43
Valid until: Friday, February 7, 2053
----------
Variant: debugAndroidTest
Config: debug
Store: C:\Users\User\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 58:E1:67:23:3F:57:CD:22:BE:CE:AB:50:46:90:7D:31
SHA1: 35:0D:6A:38:A7:53:AE:77:EC:D0:61:32:47:32:FD:ED:2F:CA:0C:AA
SHA-256: 9A:CA:D2:1A:12:7A:CD:1A:01:52:F4:E2:DA:EC:B0:E1:35:F8:73:11:27:C8:84:A9:F4:D2:98:EA:D8:1C:D4:43
Valid until: Friday, February 7, 2053
----------

> Task :cloud_firestore:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\User\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 58:E1:67:23:3F:57:CD:22:BE:CE:AB:50:46:90:7D:31
SHA1: 35:0D:6A:38:A7:53:AE:77:EC:D0:61:32:47:32:FD:ED:2F:CA:0C:AA
SHA-256: 9A:CA:D2:1A:12:7A:CD:1A:01:52:F4:E2:DA:EC:B0:E1:35:F8:73:11:27:C8:84:A9:F4:D2:98:EA:D8:1C:D4:43
Valid until: Friday, February 7, 2053
----------

> Task :firebase_auth:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\User\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 58:E1:67:23:3F:57:CD:22:BE:CE:AB:50:46:90:7D:31
SHA1: 35:0D:6A:38:A7:53:AE:77:EC:D0:61:32:47:32:FD:ED:2F:CA:0C:AA
SHA-256: 9A:CA:D2:1A:12:7A:CD:1A:01:52:F4:E2:DA:EC:B0:E1:35:F8:73:11:27:C8:84:A9:F4:D2:98:EA:D8:1C:D4:43
Valid until: Friday, February 7, 2053
----------

> Task :firebase_core:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\User\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 58:E1:67:23:3F:57:CD:22:BE:CE:AB:50:46:90:7D:31
SHA1: 35:0D:6A:38:A7:53:AE:77:EC:D0:61:32:47:32:FD:ED:2F:CA:0C:AA
SHA-256: 9A:CA:D2:1A:12:7A:CD:1A:01:52:F4:E2:DA:EC:B0:E1:35:F8:73:11:27:C8:84:A9:F4:D2:98:EA:D8:1C:D4:43
Valid until: Friday, February 7, 2053
----------

> Task :firebase_storage:signingReport
Variant: debugAndroidTest
Config: debug
Store: C:\Users\User\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 58:E1:67:23:3F:57:CD:22:BE:CE:AB:50:46:90:7D:31
SHA1: 35:0D:6A:38:A7:53:AE:77:EC:D0:61:32:47:32:FD:ED:2F:CA:0C:AA
SHA-256: 9A:CA:D2:1A:12:7A:CD:1A:01:52:F4:E2:DA:EC:B0:E1:35:F8:73:11:27:C8:84:A9:F4:D2:98:EA:D8:1C:D4:43
Valid until: Friday, February 7, 2053
----------

Deprecated Gradle features were used in this build, making it incompatible with Gradle 8.0.

You can use '--warning-mode all' to show the individual deprecation warnings and determine if they come from your own scripts or plugins.

See https://docs.gradle.org/7.5/userguide/command_line_interface.html#sec:command_line_warnings

BUILD SUCCESSFUL in 2s
5 actionable tasks: 5 executed
```
