import 'package:flutter/material.dart';
import 'package:jarvis/view/auth/widget/auth_toggle.dart';
import 'package:jarvis/view/auth/widget/google_sign_in_button.dart';
import 'package:jarvis/view/auth/widget/or_divider.dart';
import 'package:jarvis/view/auth/widget/register_tab.dart';
import 'package:jarvis/view/auth/widget/sign_in_tab.dart';
import 'package:jarvis/view/shared/top_app_bar_with_drawer_icon.dart';
import 'package:jarvis/view/shared/my_scaffold.dart';

import '../../constant.dart';

enum AuthTab { signIn, register }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthTab currentTab = AuthTab.signIn;

  void toggleTab(AuthTab tab) {
    setState(() {
      currentTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > drawerDisplayWidthThreshold;
        return MyScaffold(
          resizeToAvoidBottomInset: false,
          appBar: TopAppBarWithDrawerIcon(isLargeScreen: isLargeScreen),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: drawerDisplayWidthThreshold,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const GoogleSignInButton(),
                    const SizedBox(height: 15),
                    const OrDivider(),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AuthToggle(
                        currentTab: currentTab,
                        onToggle: toggleTab,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildTabContent(currentTab),
                    ),
                  ],
                ),
              ),
            ),
          ),
          isLargeScreen: isLargeScreen,
        );
      },
    );
  }

  Widget _buildTabContent(AuthTab tab) {
    switch (tab) {
      case AuthTab.signIn:
        return SignInTab(onTabToggle: () => toggleTab(AuthTab.register));
      case AuthTab.register:
        return RegisterTab(onTabToggle: () => toggleTab(AuthTab.signIn));
      default:
        return SignInTab(onTabToggle: () => toggleTab(AuthTab.register));
    }
  }
}
