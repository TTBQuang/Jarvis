import 'package:flutter/material.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/view/prompt_library/widget/send_prompt_bottom_sheet.dart';
import 'package:jarvis/view_model/email_view_model.dart';
import 'package:jarvis/view_model/prompt_view_model.dart';
import 'package:popover/popover.dart';
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

        if (_textController.text.endsWith('/')) {
          _showPromptsOverlay();
        }
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showPromptsOverlay() {
    showPopover(
      context: context,
      bodyBuilder: (context) {
        final promptsViewModel =
            Provider.of<PromptViewModel>(context, listen: false);
        final _prompts = (promptsViewModel.privatePromptList?.items ?? []) +
            (promptsViewModel.publicPromptList?.items ?? []);

        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: _prompts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_prompts[index].title),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height *
                            maxBottomSheetHeightPercentage,
                      ),
                      child: SendPromptBottomSheet(prompt: _prompts[index]),
                    );
                  },
                );
              },
            );
          },
        );
      },
      onPop: () => _textController.text =
          _textController.text.substring(0, _textController.text.length - 1),
      direction: PopoverDirection.bottom,
      width: 200,
      height: 400,
      arrowHeight: 15,
      arrowWidth: 30,
    );
  }

  @override
  Widget build(BuildContext context) {
    final emailViewModel = Provider.of<EmailViewModel>(context);
    final isSending = emailViewModel.isSending;

    return Row(
      children: [
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Tell Jarvis how you want to reply',
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
                    : () {
                        emailViewModel.sendMessage(
                            message: _textController.text);
                        _textController.clear();
                      },
                color: _isTextEmpty ? Colors.grey : Colors.blue,
              ),
      ],
    );
  }
}
