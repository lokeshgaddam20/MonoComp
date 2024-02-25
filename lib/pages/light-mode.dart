import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
  background: Colors.grey.shade300,
  primary: Colors.grey.shade500,
  secondary: Colors.grey.shade200,
  tertiary: Colors.white,
  inversePrimary: Colors.grey.shade900,
));

ThemeData darkMode = ThemeData(
    colorScheme: ColorScheme.dark(
  background: Colors.grey.shade900,
  primary: Colors.grey.shade700,
  secondary: Colors.grey.shade800,
  tertiary: Colors.black,
  inversePrimary: Colors.grey.shade500,
));
