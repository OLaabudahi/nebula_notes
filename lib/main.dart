import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const GlassNotesApp());
}

class GlassNotesApp extends StatelessWidget {
  const GlassNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Glass Notes',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HomeScreen(),
    );
  }
}