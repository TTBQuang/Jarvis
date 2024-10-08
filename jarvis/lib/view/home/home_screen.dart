import 'package:flutter/material.dart';
import 'package:jarvis/view/home/widget/chat_bottom_bar.dart';
import 'package:jarvis/view/home/widget/home_drawer.dart';
import 'package:jarvis/view/home/widget/home_top_app_bar.dart';
import 'package:jarvis/view/home/widget/messages_list.dart';
import 'package:jarvis/view/home/widget/options_bottom_sheet.dart';

import '../../constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > drawerDisplayWidthThreshold;
        return Row(
          children: [
            if (isLargeScreen) HomeDrawer(isLargeScreen: isLargeScreen),
            Expanded(
              child: Scaffold(
                appBar: HomeTopAppBar(isLargeScreen: isLargeScreen),
                drawer: isLargeScreen
                    ? null
                    : HomeDrawer(isLargeScreen: isLargeScreen),
                body: Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: isLargeScreen ? drawerDisplayWidthThreshold : double.infinity,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: MessagesList(isLargeScreen: isLargeScreen),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ChatBottomBar(
                              onAddIconBtnClicked: (context) =>
                                  _showOptionsBottomSheet(context)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const OptionsBottomSheet();
      },
    );
  }
}
