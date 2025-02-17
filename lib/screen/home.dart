import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ChoreoScope',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: const Color.fromARGB(255, 153, 1, 1),
      ),
      body: Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
