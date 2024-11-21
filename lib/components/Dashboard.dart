import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lorem Ipsum')),
      body: Container(
        child: Center(
          child: Text(
            'Lorem ipsum dolor sit amet!',
            style: TextStyle(
              fontSize: 21,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
