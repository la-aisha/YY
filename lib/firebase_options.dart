// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAONdusxnKX82qD1pybAZRUacZcxquK1Hw',
    appId: '1:237101192116:web:d0039950db3806fb26d8e1',
    messagingSenderId: '237101192116',
    projectId: 'yoyo-f9775',
    authDomain: 'yoyo-f9775.firebaseapp.com',
    storageBucket: 'yoyo-f9775.appspot.com',
    measurementId: 'G-GX68CSE11C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCyQ3HH4EtUSvkw3NsmT6pb0tYbqqv6Iog',
    appId: '1:237101192116:android:dc291816243f2f9426d8e1',
    messagingSenderId: '237101192116',
    projectId: 'yoyo-f9775',
    storageBucket: 'yoyo-f9775.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJU1LZq9SmmftuiJKaEf2LTMtggX0xz-M',
    appId: '1:237101192116:ios:635c3d500f8f92bc26d8e1',
    messagingSenderId: '237101192116',
    projectId: 'yoyo-f9775',
    storageBucket: 'yoyo-f9775.appspot.com',
    iosBundleId: 'com.rh.yy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJU1LZq9SmmftuiJKaEf2LTMtggX0xz-M',
    appId: '1:237101192116:ios:dff301fed70f402926d8e1',
    messagingSenderId: '237101192116',
    projectId: 'yoyo-f9775',
    storageBucket: 'yoyo-f9775.appspot.com',
    iosBundleId: 'com.rh.yy.RunnerTests',
  );
}
