import 'package:flutter/material.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/hello.png", width: 50, height: 50),
        const Text(
          'Hello everyone',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "I am Jarvis, your personal assistant. How can I help you today?",
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
