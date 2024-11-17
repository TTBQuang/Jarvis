import 'package:flutter/material.dart';
import 'package:jarvis/model/chat.dart';
import 'package:jarvis/view/home/widget/chat_bottom_bar.dart';
import 'package:jarvis/view/home/widget/home_top_app_bar.dart';
import 'package:jarvis/view/home/widget/messages_list.dart';
import 'package:jarvis/view/home/widget/options_bottom_sheet.dart';
import 'package:jarvis/view/shared/my_scaffold.dart';
import 'package:jarvis/view_model/auth_view_model.dart';
import 'package:jarvis/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ChatViewModel(authViewModel: context.read<AuthViewModel>());
      },
      child: Builder(builder: (context) {
        final chatViewModel = context.read<ChatViewModel>();
        chatViewModel.getConversations(assistantId: AssistantId.gpt_4o_mini);

        return LayoutBuilder(
          builder: (context, constraints) {
            bool isLargeScreen =
                constraints.maxWidth > drawerDisplayWidthThreshold;
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
      }),
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
