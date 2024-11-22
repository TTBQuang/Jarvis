import 'package:flutter/material.dart';
import 'package:jarvis/view/pricing/pricing_screen.dart';
import 'package:jarvis/view/shared/token_display.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../model/user.dart';
import '../../view_model/auth_view_model.dart';
import '../shared/app_logo_with_name.dart';
import '../shared/my_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > drawerDisplayWidthThreshold;
        return MyScaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            forceMaterialTransparency: true,
            leading: isLargeScreen
                ? null
                : Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AppLogoWithName(),
                ),
                TokenDisplay(),
              ],
            ),
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: drawerDisplayWidthThreshold,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Selector<AuthViewModel, User?>(
                    selector: (context, viewModel) => viewModel.user,
                    builder: (context, user, child) {
                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                        ),
                        title: Text(
                          user?.userInfo?.username ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          user?.userInfo?.email ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.upgrade,
                        color: Colors.blue,
                      ),
                    ),
                    title: const Text(
                      'Upgrade account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const PricingScreen()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.logout,
                        color: Colors.blue,
                      ),
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      final authViewModel = context.read<AuthViewModel>();
                      authViewModel.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
          isLargeScreen: isLargeScreen,
        );
      },
    );
  }
}
