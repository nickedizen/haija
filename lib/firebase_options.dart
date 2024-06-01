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
    apiKey: 'AIzaSyC9TWlnbOQ0zWEk4t-wSPCedN9foOejeYY',
    appId: '1:492124147947:web:1c429dbeca9aef8b05eeae',
    messagingSenderId: '492124147947',
    projectId: 'haija-library',
    authDomain: 'haija-library.firebaseapp.com',
    storageBucket: 'haija-library.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2OI9LdHQBpj4kQ8vw4icjmq3Ny3HYjZ0',
    appId: '1:492124147947:android:95ffc58fa331ca2c05eeae',
    messagingSenderId: '492124147947',
    projectId: 'haija-library',
    storageBucket: 'haija-library.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdFQfMahYzc_gG1z-HXw6aKUAzGOe5ros',
    appId: '1:492124147947:ios:beb9a50ed8a811cd05eeae',
    messagingSenderId: '492124147947',
    projectId: 'haija-library',
    storageBucket: 'haija-library.appspot.com',
    iosBundleId: 'com.example.finalProjectHaijo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdFQfMahYzc_gG1z-HXw6aKUAzGOe5ros',
    appId: '1:492124147947:ios:10c07f536fcb73f705eeae',
    messagingSenderId: '492124147947',
    projectId: 'haija-library',
    storageBucket: 'haija-library.appspot.com',
    iosBundleId: 'com.example.finalProjectHaijo.RunnerTests',
  );
}
