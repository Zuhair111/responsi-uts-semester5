import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(SocialHomePage());
}

class SocialHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Color(0xFFFFF7F3),
      ),
    );
  }
}