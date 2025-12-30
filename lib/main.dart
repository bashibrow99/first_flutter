import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Import the file we just made

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the ugly "Debug" sash
      title: 'IronHome',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(), // Use our new screen here
    );
  }
}
