import 'package:flutter/material.dart';
import 'splash_screen_ui.dart';

void main() {
  runApp(const FlutterTaxiFareApp());
}

class FlutterTaxiFareApp extends StatelessWidget {
  const FlutterTaxiFareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxi Fare Calculator',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashScreenUi(),
    );
  }
}