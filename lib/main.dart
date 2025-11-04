import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(const SozietyApp());
}

class SozietyApp extends StatelessWidget {
  const SozietyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
