import 'package:flutter/material.dart';
import 'package:jarvis/model/user_token.dart';
import 'package:provider/provider.dart';

import '../../view_model/auth_view_model.dart';
import '../auth/auth_screen.dart';
import '../profile/profile_screen.dart';

class AuthRedirect extends StatelessWidget {
  const AuthRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    final userToken = context
        .select<AuthViewModel, UserToken?>((authViewModel) => authViewModel.user?.userToken);

    if (userToken != null) {
      return const ProfileScreen();
    } else {
      return const AuthScreen();
    }
  }
}
