import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jarvis/view_model/auth_view_model.dart';

import '../../../view_model/chat_view_model.dart';
import '../../forgot_password/forgot_password_screen.dart';

class SignInTab extends StatelessWidget {
  final Function onTabToggle;

  const SignInTab({super.key, required this.onTabToggle});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ForgotPasswordScreen(),
                ),
              );
            },
            child: const Text('Forgot Password?'),
          ),
        ),
        const SizedBox(height: 8),
        Selector<AuthViewModel, bool>(
          selector: (context, viewModel) => viewModel.isSigningIn,
          builder: (context, isLoading, child) {
            return isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Selector<AuthViewModel, String>(
                    selector: (context, viewModel) =>
                        viewModel.errorMessageSignIn,
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
              await authViewModel.signInWithEmailAndPassword(email, password);

              if (context.mounted) {
                final chatViewModel = context.read<ChatViewModel>();
                chatViewModel.getUsage();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4b85e9),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: const Text(
              'Login',
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
            const Text("Don't have an account?"),
            TextButton(
              onPressed: () {
                onTabToggle();
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ],
    );
  }
}
