// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/index.dart'; // Import the chatbot screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mews Chatbot Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const IndexPage(), // Load the chatbot
    );
  }
}
