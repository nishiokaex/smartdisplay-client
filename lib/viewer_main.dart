import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_strategy/url_strategy.dart';
import 'containers/viewer_root.dart';
import 'redux/viewer_store.dart';

// (参照) https://firebase.flutter.dev/docs/auth/start/#optional-prototype-and-test-with-firebase-local-emulator-suite
bool shouldUseFirebaseEmulator = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: String.fromEnvironment("apiKey"),
        appId: String.fromEnvironment("appId"),
        messagingSenderId: String.fromEnvironment("messagingSenderId"),
        projectId: String.fromEnvironment("projectId"),
        authDomain: String.fromEnvironment("authDomain"),
        databaseURL: String.fromEnvironment("databaseURL"),
      ),
    );
  }

  if (shouldUseFirebaseEmulator) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = kIsWeb ? "Smart Display for Web" : "Smart Display";

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ViewerStoreProvider(
        child: ViewerRoot(),
      ),
    );
  }
}
