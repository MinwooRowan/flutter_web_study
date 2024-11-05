import 'package:flutter/material.dart';

class RootScreen extends StatelessWidget {
  static const route = 'root';
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('root'),
      ),
    );
  }
}
