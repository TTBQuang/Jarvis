import 'package:flutter/material.dart';
import 'package:jarvis/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

class MessagesList extends StatelessWidget {
  final bool isLargeScreen;

  MessagesList({super.key, required this.isLargeScreen});

  @override
  Widget build(BuildContext context) {
    final double paddingSize = isLargeScreen
        ? drawerDisplayWidthThreshold * 0.15
        : MediaQuery.of(context).size.width * 0.15;

    final chatViewModel = Provider.of<ChatViewModel>(context);
    final messages = chatViewModel.conversationMessages ?? [];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.only(left: paddingSize, bottom: 15),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      message.query,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    message.answer,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
