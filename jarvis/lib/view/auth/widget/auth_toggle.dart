import 'package:flutter/material.dart';

import '../auth_screen.dart';

class AuthToggle extends StatelessWidget {
  final AuthTab currentTab;
  final Function(AuthTab) onToggle;

  const AuthToggle({
    super.key,
    required this.currentTab,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    const selectedColor = Color(0xFF4b85e9);
    final unselectedColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF014493)
        : const Color(0xffbcc6e8);

    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: unselectedColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onToggle(AuthTab.signIn),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: currentTab == AuthTab.signIn ? selectedColor : unselectedColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Sign in",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: GestureDetector(
                  onTap: () => onToggle(AuthTab.register),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: currentTab == AuthTab.register ? selectedColor : unselectedColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Register",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
