import 'package:flutter/material.dart';
import 'screens/signup_screen.dart'; // 1. Import this

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IronHome',
      theme: ThemeData.dark(),

      // 2. CHANGE THIS: Start with Sign Up instead of MainWrapper
      home: const SignUpScreen(),
    );
  }
}
