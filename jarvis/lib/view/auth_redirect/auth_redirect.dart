import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';
import '../../view_model/auth_view_model.dart';
import '../auth/auth_screen.dart';
import '../profile/profile_screen.dart';

class AuthRedirect extends StatelessWidget {
  const AuthRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context
        .select<AuthViewModel, User?>((authViewModel) => authViewModel.user);

    if (user != null) {
      return const ProfileScreen();
    } else {
      return const AuthScreen();
    }
  }
}
