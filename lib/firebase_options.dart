import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return _web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _android;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return _iosMacOS;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Windows. '
          'Please configure by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Linux. '
          'Please configure by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // Web configuration
  static const FirebaseOptions _web = FirebaseOptions(
    apiKey: 'AIzaSyAshYp09BjLjy_B2dc5V78hLTOyQyvJBtQ',
    appId: '1:619586853114:web:71f17187f24cf1b9a41143',
    messagingSenderId: '619586853114',
    projectId: 'loginform-a96f9',
    authDomain: 'loginform-a96f9.firebaseapp.com',
    storageBucket: 'loginform-a96f9.firebasestorage.app',
    measurementId: 'G-CEJRNC4V9R',
  );

  // Android configuration
  static const FirebaseOptions _android = FirebaseOptions(
    apiKey: 'AIzaSyBr47QBfF_-_NulX2CO-ZZ-MT7e66f4j0E',
    appId: '1:619586853114:android:ec5b67e27fe34d8ba41143',
    messagingSenderId: '619586853114',
    projectId: 'loginform-a96f9',
    storageBucket: 'loginform-a96f9.firebasestorage.app',
  );

  // iOS and macOS configuration (merged to avoid duplication)
  static const FirebaseOptions _iosMacOS = FirebaseOptions(
    apiKey: 'AIzaSyBcpszPZLIF0ifOpwjaRt6TaO-JzQ_wLKo',
    appId: '1:619586853114:ios:5b3a9433b268bba0a41143',
    messagingSenderId: '619586853114',
    projectId: 'loginform-a96f9',
    storageBucket: 'loginform-a96f9.firebasestorage.app',
    iosBundleId: 'com.example.loginForm',
  );
}
