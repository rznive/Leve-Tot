import 'package:flutter/material.dart';
import 'package:quranconnect/components/Login.dart';

void main() {
  runApp(const QuranApp());
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const LoginScreen(),
    );
  }
}
