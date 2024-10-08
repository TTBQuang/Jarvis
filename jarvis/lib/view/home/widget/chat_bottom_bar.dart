import 'package:flutter/material.dart';

class ChatBottomBar extends StatelessWidget {
  final void Function(BuildContext context) onAddIconBtnClicked;

  const ChatBottomBar({required this.onAddIconBtnClicked, super.key});

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
            onPressed: () => onAddIconBtnClicked(context),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Type a message',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onSubmitted: (value) {},
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {},
        ),
      ],
    );
  }
}
