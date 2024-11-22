import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/auth_view_model.dart';

class RegisterTab extends StatelessWidget {
  final Function onTabToggle;

  const RegisterTab({super.key, required this.onTabToggle});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Username',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: usernameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            hintText: 'Enter your username',
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Email',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            hintText: 'Enter your email',
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            hintText: 'Enter your password',
          ),
        ),
        const SizedBox(height: 15),
        Selector<AuthViewModel, bool>(
          selector: (context, viewModel) => viewModel.isSigningUp,
          builder: (context, isLoading, child) {
            return isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Selector<AuthViewModel, String>(
                    selector: (context, viewModel) =>
                        viewModel.errorMessageSignUp,
                    builder: (context, errorMessage, child) {
                      return errorMessage.isNotEmpty
                          ? Center(
                              child: Text(
                                errorMessage,
                                style: const TextStyle(color: Colors.red),
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  );
          },
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final authViewModel = context.read<AuthViewModel>();
              String email = emailController.text.trim();
              String password = passwordController.text.trim();
              String username = usernameController.text.trim();

              bool success = await authViewModel.signUpWithEmailAndPassword(
                  email, password, username);
              if (success) {
                onTabToggle();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4b85e9),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: const Text(
              'Register',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account?"),
            TextButton(
              onPressed: () {
                onTabToggle();
              },
              child: const Text('Sign in'),
            ),
          ],
        ),
      ],
    );
  }
}
