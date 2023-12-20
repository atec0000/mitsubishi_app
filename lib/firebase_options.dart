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
    apiKey: 'AIzaSyAODg6SVah_jIKksffXiZTbh8iDLQvPs_g',
    appId: '1:713162264634:web:caf0dc8baa72603d386503',
    messagingSenderId: '713162264634',
    projectId: 'upyoung-bb219',
    authDomain: 'upyoung-bb219.firebaseapp.com',
    storageBucket: 'upyoung-bb219.appspot.com',
    measurementId: 'G-1MMT1JPLVF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDvhKIwgj3cRwt4b4FDZfFR-Wb1oPXQpWg',
    appId: '1:713162264634:android:5d829446ccd0297a386503',
    messagingSenderId: '713162264634',
    projectId: 'upyoung-bb219',
    storageBucket: 'upyoung-bb219.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBf0kLqz_HJO5iSF_ZzNgax-Hbe8npnDUY',
    appId: '1:713162264634:ios:f1748e8cdfe399dd386503',
    messagingSenderId: '713162264634',
    projectId: 'upyoung-bb219',
    storageBucket: 'upyoung-bb219.appspot.com',
    iosClientId: '713162264634-2dt25aphfq0hd8j48dtvocsrrrt43s8g.apps.googleusercontent.com',
    iosBundleId: 'com.example.upyongTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBf0kLqz_HJO5iSF_ZzNgax-Hbe8npnDUY',
    appId: '1:713162264634:ios:84d79442b3d3f413386503',
    messagingSenderId: '713162264634',
    projectId: 'upyoung-bb219',
    storageBucket: 'upyoung-bb219.appspot.com',
    iosClientId: '713162264634-84lnereit3m9eov597pd4umikfqv8fq4.apps.googleusercontent.com',
    iosBundleId: 'com.example.upyongTest.RunnerTests',
  );
}
