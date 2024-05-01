// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDsfaJ_ly6Pds7GQBd_5NgE4L32LevYhxQ',
    appId: '1:842753310658:web:4f6d9db2d1bffa9483e05b',
    messagingSenderId: '842753310658',
    projectId: 'mastering-firebase-25daa',
    authDomain: 'mastering-firebase-25daa.firebaseapp.com',
    storageBucket: 'mastering-firebase-25daa.appspot.com',
    measurementId: 'G-DZ5BEFHX8G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMJdgbN1qy1iZd9JwN6mRfjjfXNjU1soQ',
    appId: '1:842753310658:android:04c3555307a4b6e983e05b',
    messagingSenderId: '842753310658',
    projectId: 'mastering-firebase-25daa',
    storageBucket: 'mastering-firebase-25daa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDKGMV7uIL_QV0gK0wgVtEAhsqJT9Vdd8',
    appId: '1:842753310658:ios:0d6a56f6b9ddc16c83e05b',
    messagingSenderId: '842753310658',
    projectId: 'mastering-firebase-25daa',
    storageBucket: 'mastering-firebase-25daa.appspot.com',
    iosBundleId: 'com.example.masteringFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDDKGMV7uIL_QV0gK0wgVtEAhsqJT9Vdd8',
    appId: '1:842753310658:ios:0d6a56f6b9ddc16c83e05b',
    messagingSenderId: '842753310658',
    projectId: 'mastering-firebase-25daa',
    storageBucket: 'mastering-firebase-25daa.appspot.com',
    iosBundleId: 'com.example.masteringFirebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDsfaJ_ly6Pds7GQBd_5NgE4L32LevYhxQ',
    appId: '1:842753310658:web:798f2c80c2beb78583e05b',
    messagingSenderId: '842753310658',
    projectId: 'mastering-firebase-25daa',
    authDomain: 'mastering-firebase-25daa.firebaseapp.com',
    storageBucket: 'mastering-firebase-25daa.appspot.com',
    measurementId: 'G-3KJPV6Q0E3',
  );
}
