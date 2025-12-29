import 'package:flutter/material.dart';
import 'package:module_13_assignment/calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BMI(), debugShowCheckedModeBanner: false);
  }
}
