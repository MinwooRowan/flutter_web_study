import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const route = 'splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('splash Screen'),
      ),
    );
  }
}
