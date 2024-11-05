import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  static const route = 'detail';
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Detail Screen'),
      ),
    );
  }
}
