import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'features/app/splash_screen/splash.dart'; // Adjusted the import path
import 'package:firebase_core/firebase_core.dart';
//import 'package:GoogleSignIn/SignInScreen.dart';

const SAVE_KEY_NAME = '_userLoggedIn'; // Consider moving to a constants file

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAJ6IlMqLidoV8dzprFtRPJt4wfXW1k7Y8",
            appId: "1:814761519101:web:8f645ef7a1dc03528f9b94",
            messagingSenderId: "814761519101",
            projectId: "choreo-flutter"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChoreoScope....',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySplash(),
    );
  }
}
