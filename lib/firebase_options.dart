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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpI9XIztJzzKLkpRXeEX-YYLLpieBttBY',
    appId: '1:591505583024:android:7d073ec7588dc1799a0475',
    messagingSenderId: '591505583024',
    projectId: 'fatum-8a6f0',
    storageBucket: 'fatum-8a6f0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqrsL63ZJ3_19t5jCZr785020ySnf3BU4',
    appId: '1:591505583024:ios:5dddb87fbb8707b89a0475',
    messagingSenderId: '591505583024',
    projectId: 'fatum-8a6f0',
    storageBucket: 'fatum-8a6f0.firebasestorage.app',
    iosBundleId: 'com.example.fatum',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA2G_ItUuNdHzTzFh0mkfHqpAt7gvi56x0',
    appId: '1:591505583024:web:00c020a983cf9f0e9a0475',
    messagingSenderId: '591505583024',
    projectId: 'fatum-8a6f0',
    authDomain: 'fatum-8a6f0.firebaseapp.com',
    storageBucket: 'fatum-8a6f0.firebasestorage.app',
    measurementId: 'G-RDJ9E472Q7',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqrsL63ZJ3_19t5jCZr785020ySnf3BU4',
    appId: '1:591505583024:ios:5dddb87fbb8707b89a0475',
    messagingSenderId: '591505583024',
    projectId: 'fatum-8a6f0',
    storageBucket: 'fatum-8a6f0.firebasestorage.app',
    iosBundleId: 'com.example.fatum',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA2G_ItUuNdHzTzFh0mkfHqpAt7gvi56x0',
    appId: '1:591505583024:web:0f19ef6e0e0abd3c9a0475',
    messagingSenderId: '591505583024',
    projectId: 'fatum-8a6f0',
    authDomain: 'fatum-8a6f0.firebaseapp.com',
    storageBucket: 'fatum-8a6f0.firebasestorage.app',
    measurementId: 'G-RZSN8Y50T1',
  );

}