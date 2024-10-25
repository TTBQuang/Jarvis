import 'package:flutter/material.dart';

class TokenDisplay extends StatelessWidget{
  const TokenDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF303f52)
            : const Color(0xFFdce3f3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            '50',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF6297ee)
                  : const Color(0xFF285baf),
            ),
          ),
          const SizedBox(width: 5),
          const Image(
            image: AssetImage("assets/token.png"),
            width: 24.0,
            height: 24.0,
          ),
        ],
      ),
    );
  }
}