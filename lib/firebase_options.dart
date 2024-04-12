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
    apiKey: 'AIzaSyANi9pJbbosUHrf3gz7Nd0gJy6sstsXZ-g',
    appId: '1:668992767253:web:2c1235817156250f0f151c',
    messagingSenderId: '668992767253',
    projectId: 'knack---the-learning-platform',
    authDomain: 'knack---the-learning-platform.firebaseapp.com',
    storageBucket: 'knack---the-learning-platform.appspot.com',
    measurementId: 'G-YZZDEJ7RBJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnz9E5KFOMHLJoTcIta8bEIS4YN-Q-f1s',
    appId: '1:668992767253:android:388c530adbd3742b0f151c',
    messagingSenderId: '668992767253',
    projectId: 'knack---the-learning-platform',
    storageBucket: 'knack---the-learning-platform.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhojeWO2BXMAZmE_GddX0h1Y9WDmJ-ra4',
    appId: '1:668992767253:ios:5374f1c0de69e2fe0f151c',
    messagingSenderId: '668992767253',
    projectId: 'knack---the-learning-platform',
    storageBucket: 'knack---the-learning-platform.appspot.com',
    androidClientId: '668992767253-jugmmq1gpe94j1k9k77jmv0gdgrm6eoq.apps.googleusercontent.com',
    iosClientId: '668992767253-tbvqvksifsisutg74cqbahv99vdipht9.apps.googleusercontent.com',
    iosBundleId: 'com.example.knackAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBhojeWO2BXMAZmE_GddX0h1Y9WDmJ-ra4',
    appId: '1:668992767253:ios:5374f1c0de69e2fe0f151c',
    messagingSenderId: '668992767253',
    projectId: 'knack---the-learning-platform',
    storageBucket: 'knack---the-learning-platform.appspot.com',
    androidClientId: '668992767253-jugmmq1gpe94j1k9k77jmv0gdgrm6eoq.apps.googleusercontent.com',
    iosClientId: '668992767253-tbvqvksifsisutg74cqbahv99vdipht9.apps.googleusercontent.com',
    iosBundleId: 'com.example.knackAdmin',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyANi9pJbbosUHrf3gz7Nd0gJy6sstsXZ-g',
    appId: '1:668992767253:web:2e01bf7a718ec0770f151c',
    messagingSenderId: '668992767253',
    projectId: 'knack---the-learning-platform',
    authDomain: 'knack---the-learning-platform.firebaseapp.com',
    storageBucket: 'knack---the-learning-platform.appspot.com',
    measurementId: 'G-T75K2BXHVM',
  );
}
