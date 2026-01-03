import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // <--- REQUIRED for Firebase
import 'screens/home_screen.dart';

void main() async {
  // 1. We must wait for Flutter to wake up before asking for Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Turn on the Firebase Engine
  // Note: If this crashes, you might need to generate 'firebase_options.dart'
  await Firebase.initializeApp();

  // 3. Start the App
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IronHome',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
