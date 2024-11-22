import 'package:flutter/material.dart';
import 'package:jarvis/view/home/widget/home_drawer.dart';

class MyScaffold extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget body;
  final bool isLargeScreen;
  final bool resizeToAvoidBottomInset;

  const MyScaffold({
    super.key,
    required this.appBar,
    required this.body,
    required this.isLargeScreen,
    required this.resizeToAvoidBottomInset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isLargeScreen) HomeDrawer(isLargeScreen: isLargeScreen),
        Expanded(
          child: Scaffold(
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            appBar: appBar,
            drawer: isLargeScreen ? null : HomeDrawer(isLargeScreen: isLargeScreen),
            body: body,
          ),
        ),
      ],
    );
  }
}
