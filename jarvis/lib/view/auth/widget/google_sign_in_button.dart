import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/auth_view_model.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        final authViewModel = context.read<AuthViewModel>();
        authViewModel.signInWithGoogle();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/google_logo.png',
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 12),
          const Text(
            'Sign in with Google',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
