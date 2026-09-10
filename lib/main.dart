import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery App',

      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xff53B175),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff53B175),
        ),
        useMaterial3: true,
      ),

      // بداية التطبيق من Login
      home: const LoginScreen(),
    );
  }
}