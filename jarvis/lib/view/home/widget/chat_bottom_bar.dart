import 'package:flutter/material.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/view/prompt_library/widget/send_prompt_bottom_sheet.dart';
import 'package:jarvis/view_model/chat_view_model.dart';
import 'package:jarvis/view_model/prompt_view_model.dart';
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
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();

    // Listen to TextField changes
    _textController.addListener(() {
      setState(() {
        _isTextEmpty = _textController.text.isEmpty;

        // Listen to TextField changes
        _textController.addListener(() {
          setState(() {
            _isTextEmpty = _textController.text.isEmpty;

            if (_textController.text.endsWith('/')) {
              _showPromptsOverlay();
            } else {
              _removePromptsOverlay();
            }
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _removePromptsOverlay();
    super.dispose();
  }

  void _showPromptsOverlay() {
    if (_overlayEntry != null) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context);
    final offset = renderBox.localToGlobal(Offset.zero);

    final promptsViewModel =
        Provider.of<PromptViewModel>(context, listen: false);
    final _prompts = promptsViewModel.privatePromptList!.items +
        promptsViewModel.publicPromptList!.items;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx + 10,
        top: offset.dy - 150, // Adjust the position as needed
        child: Material(
          elevation: 4,
          child: Container(
            width: renderBox.size.width - 20,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: _prompts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_prompts[index].title),
                  onTap: () {
                    _removePromptsOverlay();
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
            ),
          ),
        ),
      ),
    );

    overlay?.insert(_overlayEntry!);
  }

  void _removePromptsOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final chatViewModel = Provider.of<ChatViewModel>(context, listen: false);

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
              hintText: 'Ask me anything, press \'/\' for prompts...',
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
                  chatViewModel.sendMessage(message: _textController.text);
                  _textController.clear();
                },
          color: _isTextEmpty ? Colors.grey : Colors.blue,
        ),
      ],
    );
  }
}
