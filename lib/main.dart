import 'package:flutter/material.dart';
import 'package:daiet/screens/home_page.dart';
import 'env/env.dart';
import 'package:dart_openai/dart_openai.dart';

void main() {
  OpenAI.apiKey = Env.apiKey; // Initializes the package with your API key
  runApp(dAIet());
}

class dAIet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF0A0E21),
          // secondary: Colors.greenAccent,
          // onSecondary: Color(0xFF0A0E21),
        ),
      ),
      home: HomePage(),
    );
  }
}
