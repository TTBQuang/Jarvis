import 'package:flutter/material.dart';
import 'package:jarvis/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';

class ChatBottomBar extends StatefulWidget {
  final void Function(BuildContext context) onAddIconBtnClicked;

  const ChatBottomBar({required this.onAddIconBtnClicked, super.key});

  @override
  State<StatefulWidget> createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends State<ChatBottomBar> {
  final TextEditingController _textController = TextEditingController();
  bool _isTextEmpty = true;

  @override
  void initState() {
    super.initState();

    // Listen to TextField changes
    _textController.addListener(() {
      setState(() {
        _isTextEmpty = _textController.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void sendMessage(String message) {
    final chatViewModel = Provider.of<ChatViewModel>(context, listen: false);

    if (chatViewModel.conversationId == null) {
      chatViewModel.createConversation(
          content: message, assistantId: chatViewModel.assistantId);
    } else {
      chatViewModel.sendMessage(
          message: message, assistantId: chatViewModel.assistantId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]
                : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: IconButton(
            iconSize: 20,
            icon: const Icon(Icons.add),
            onPressed: () => widget.onAddIconBtnClicked(context),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Type a message',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: _isTextEmpty
              ? null
              : () {
                  sendMessage(_textController.text);
                  _textController.clear();
                },
          color: _isTextEmpty ? Colors.grey : Colors.blue,
        ),
      ],
    );
  }
}
