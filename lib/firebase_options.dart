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
    apiKey: 'AIzaSyDbLQSI07IRokQsSnrXf3tVs9LOadoFzoA',
    appId: '1:635252309089:web:d8c0a20b022bc433513e20',
    messagingSenderId: '635252309089',
    projectId: 'athar-14346',
    authDomain: 'athar-14346.firebaseapp.com',
    storageBucket: 'athar-14346.appspot.com',
    measurementId: 'G-S6KYEV88H5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNBc9xREZzxF7X5NsMArLUhuG16whFJHk',
    appId: '1:635252309089:android:0f653bc00359eefc513e20',
    messagingSenderId: '635252309089',
    projectId: 'athar-14346',
    storageBucket: 'athar-14346.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-pX3vhQo3wjCViqPG2-UIi2uJlQq0sF8',
    appId: '1:635252309089:ios:7b7c499161ceca2f513e20',
    messagingSenderId: '635252309089',
    projectId: 'athar-14346',
    storageBucket: 'athar-14346.appspot.com',
    iosBundleId: 'com.example.flutterApplicationAtharProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC-pX3vhQo3wjCViqPG2-UIi2uJlQq0sF8',
    appId: '1:635252309089:ios:7b7c499161ceca2f513e20',
    messagingSenderId: '635252309089',
    projectId: 'athar-14346',
    storageBucket: 'athar-14346.appspot.com',
    iosBundleId: 'com.example.flutterApplicationAtharProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDbLQSI07IRokQsSnrXf3tVs9LOadoFzoA',
    appId: '1:635252309089:web:0419ed8aa1a647ed513e20',
    messagingSenderId: '635252309089',
    projectId: 'athar-14346',
    authDomain: 'athar-14346.firebaseapp.com',
    storageBucket: 'athar-14346.appspot.com',
    measurementId: 'G-G0TBWBDZ1M',
  );

}