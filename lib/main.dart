import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geminiai/auth/login_register.dart';
import 'package:geminiai/firebase_options.dart';
import 'package:geminiai/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightMode,
      home: LoginOrRegister(),
      debugShowCheckedModeBanner: false,
    );
  }
}
