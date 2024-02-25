import 'package:flutter/material.dart';
import 'package:geminiai/pages/login.dart';
import 'package:geminiai/themes/light-mode.dart';
// import 'package:geminiai/bot.dart';
// import 'package:geminiai/start.dart';

void main() {
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
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
