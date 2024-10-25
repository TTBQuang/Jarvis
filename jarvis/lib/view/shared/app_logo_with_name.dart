import 'package:flutter/material.dart';

class AppLogoWithName extends StatelessWidget {
  const AppLogoWithName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          width: 48,
          height: 48,
        ),
        const Text(
          'Jarvis',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
