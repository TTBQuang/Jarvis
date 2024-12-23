import 'package:flutter/material.dart';
import 'package:jarvis/view/email/widget/chat_bottom_bar.dart';
import 'package:jarvis/view/email/widget/home_top_app_bar.dart';
import 'package:jarvis/view/email/widget/messages_list.dart';
import 'package:jarvis/view/email/widget/options_bottom_sheet.dart';
import 'package:jarvis/view/email/widget/quick_reply_chips.dart';
import 'package:jarvis/view/shared/my_scaffold.dart';

import '../../constant.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > drawerDisplayWidthThreshold;
        return MyScaffold(
          resizeToAvoidBottomInset: true,
          appBar: HomeTopAppBar(isLargeScreen: isLargeScreen),
          body: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isLargeScreen
                    ? drawerDisplayWidthThreshold
                    : double.infinity,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: MessagesList(isLargeScreen: isLargeScreen),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const QuickReplyChips(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChatBottomBar(
                      onAddIconBtnClicked: (context) =>
                          _showOptionsBottomSheet(context),
                    ),
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

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const OptionsBottomSheet();
      },
    );
  }
}
