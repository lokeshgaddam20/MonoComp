import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geminiai/auth/auth_gate.dart';
import 'package:geminiai/firebase_options.dart';
import 'package:geminiai/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemini AI',
      theme: lightMode,
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
  }
}
