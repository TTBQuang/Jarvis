import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/view_model/email_view_model.dart';
import 'package:provider/provider.dart';

class QuickReplyChips extends StatelessWidget {
  const QuickReplyChips({super.key});

  @override
  Widget build(BuildContext context) {
    final emailViewModel = Provider.of<EmailViewModel>(context);

    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0, // gap between lines
      children: <Widget>[
        GestureDetector(
            onTap: () {
              emailViewModel.sendMessage(message: "Thanks");
            },
            child: Chip(
              avatar: FIcon(FAssets.icons.heartHandshake),
              label: const Text('Thanks'),
            )),
        GestureDetector(
            onTap: () {
              emailViewModel.sendMessage(message: "Sorry");
            },
            child: Chip(
              label: const Text('Sorry'),
              avatar: FIcon(FAssets.icons.frown),
            )),
        GestureDetector(
            onTap: () {
              emailViewModel.sendMessage(message: "Yes");
            },
            child: Chip(label: const Text('Yes'))),
        GestureDetector(
            onTap: () {
              emailViewModel.sendMessage(message: "No");
            },
            child: Chip(label: const Text('No'))),
        GestureDetector(
            onTap: () {
              emailViewModel.sendMessage(message: "Follow up");
            },
            child: Chip(
              avatar: FIcon(FAssets.icons.calendar),
              label: const Text('Follow up'),
            )),
        GestureDetector(
            onTap: () {
              emailViewModel.sendMessage(
                  message: "Request for more infomation");
            },
            child: Chip(
              avatar: FIcon(FAssets.icons.sparkle),
              label: const Text('Request for more infomation'),
            )),
      ],
    );
  }
}
