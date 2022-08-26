// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:ax_dapp/app/config/app_config.dart';
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
      FirebaseOptions firebaseConfigs;
      try {
        firebaseConfigs =
            (buildConfig == BuildConfig.release) ? webRelease : webStaging;
      } catch (e) {
        print('Error occurred fetching firebase configs: $e;\n defaulting to staging');
        firebaseConfigs = webStaging;
      }
      return firebaseConfigs;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
      // ignore: no_default_cases
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions webStaging = FirebaseOptions(
    apiKey: 'AIzaSyAXLczaG5purYtDjbDRbV_llu4H6M8Ghr0',
    authDomain: 'athlete-x-e6490.firebaseapp.com',
    projectId: 'athlete-x-e6490',
    storageBucket: 'athlete-x-e6490.appspot.com',
    messagingSenderId: '153040185513',
    appId: '1:153040185513:web:5802a6f61dc7c7601b21b8',
    measurementId: 'G-DQXRN83F4G',
  );

  static const FirebaseOptions webRelease = FirebaseOptions(
    apiKey: 'AIzaSyBybCxOPZ5t3ZFuif-GvSClsW5bg4HT3Mk',
    authDomain: 'athletex-web-production.firebaseapp.com',
    projectId: 'athletex-web-production',
    storageBucket: 'athletex-web-production.appspot.com',
    messagingSenderId: '439639532274',
    appId: '1:439639532274:web:44b258b37204910b39266b',
    measurementId: 'G-MK53MBP9DP',
  );
}
