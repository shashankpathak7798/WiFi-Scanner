import 'package:flutter/material.dart';

import './home_screen.dart';
import './custom_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const customTheme = CustomTheme();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: customTheme.toThemeData(),
      home: HomeScreen(),
    );
  }
}