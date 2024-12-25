import 'package:flutter/material.dart';
import 'package:jarvis/view_model/bot_view_model.dart';
import 'package:provider/provider.dart';

class ChatBottomBar extends StatefulWidget {
  const ChatBottomBar({super.key});

  @override
  State<StatefulWidget> createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends State<ChatBottomBar> {
  final TextEditingController _textController = TextEditingController();
  bool _isTextEmpty = true;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    final botViewModel = Provider.of<BotViewModel>(context);
    final isSending = botViewModel.isSending;

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
            onPressed: () => {
              botViewModel.createNewThread(),
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Type a message...',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        isSending
            ? const SizedBox(
                height: 50.0,
                width: 50.0,
                child: Center(child: CircularProgressIndicator()),
              )
            : IconButton(
                icon: const Icon(Icons.send),
                onPressed: _isTextEmpty
                    ? null
                    : () async {
                        await botViewModel.sendThreadMessage(
                            message: _textController.text);
                        _textController.clear();
                      },
                color: _isTextEmpty ? Colors.grey : Colors.blue,
              ),
      ],
    );
  }
}
