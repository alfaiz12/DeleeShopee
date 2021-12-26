import 'package:flutter/material.dart';
class front_pg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Delee shopee',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Delee shopee'),
        ),
        body: const Center(
          child: Text('Welcome to Delee shopee'),
        ),
      ),
    );
  }
}