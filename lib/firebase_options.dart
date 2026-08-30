import 'package:app_config/app_config.dart';
import 'package:darkoff/core/config/env_keys.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kDebugMode, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  const DefaultFirebaseOptions(this._config);

  final AppConfig _config;

  FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return kDebugMode ? androidDebug : android;
      case TargetPlatform.iOS:
        return ios;
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  String _require(String key) {
    final value = _config.maybeGetString(key);
    if (value == null || value.isEmpty) {
      throw StateError('Missing $key in .env');
    }
    return value;
  }

  FirebaseOptions get android => FirebaseOptions(
        apiKey: _require(EnvKeys.firebaseAndroidApiKey),
        appId: _require(EnvKeys.firebaseAndroidAppId),
        messagingSenderId: _require(EnvKeys.firebaseMessagingSenderId),
        projectId: _require(EnvKeys.firebaseProjectId),
        storageBucket: _require(EnvKeys.firebaseStorageBucket),
      );

  FirebaseOptions get androidDebug => FirebaseOptions(
        apiKey: _require(EnvKeys.firebaseAndroidApiKey),
        appId: _require(EnvKeys.firebaseAndroidDebugAppId),
        messagingSenderId: _require(EnvKeys.firebaseMessagingSenderId),
        projectId: _require(EnvKeys.firebaseProjectId),
        storageBucket: _require(EnvKeys.firebaseStorageBucket),
      );

  FirebaseOptions get ios => FirebaseOptions(
        apiKey: _require(EnvKeys.firebaseIosApiKey),
        appId: _require(EnvKeys.firebaseIosAppId),
        messagingSenderId: _require(EnvKeys.firebaseMessagingSenderId),
        projectId: _require(EnvKeys.firebaseProjectId),
        storageBucket: _require(EnvKeys.firebaseStorageBucket),
        iosBundleId: _require(EnvKeys.firebaseIosBundleId),
      );
}
