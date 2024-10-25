import 'package:flutter/material.dart';

import '../../../constant.dart';

class MessagesList extends StatelessWidget {
  final bool isLargeScreen;

  MessagesList({super.key, required this.isLargeScreen});

  final List<Map<String, String>> messages = [
    {'sender': 'user', 'text': 'Hello!'},
    {'sender': 'bot', 'text': 'Hi there! How can I help you today?'},
    {'sender': 'user', 'text': 'Tell me about Flutter.'},
    {
      'sender': 'bot',
      'text': 'Flutter is an open-source UI software development toolkit created by Google.'
          'Flutter is an open-source UI software develop toolkit created by Google.'
    },
    {'sender': 'user', 'text': 'Hello!'},
    {'sender': 'bot', 'text': 'Hi there! How can I help you today?'},
    {'sender': 'user', 'text': 'Tell me about Flutter.'},
    {
      'sender': 'bot',
      'text':
          'Flutter is an open-source UI software development toolkit created by Google.'
    },
    {
      'sender': 'user',
      'text': 'Flutter is an open-source UI software development toolkit created by Google.'
          'Flutter is an open-source UI software development toolkit created by Google.'
    },
    {'sender': 'bot', 'text': 'Hi there! How can I help you today?'},
    {'sender': 'user', 'text': 'Tell me about Flutter.'},
    {
      'sender': 'bot',
      'text': 'Flutter is an open-source UI software development toolkit created by Google.'
          'Flutter is an open-source UI software development toolkit created by Google.'
    },
    {'sender': 'user', 'text': 'Hello!'},
    {
      'sender': 'bot',
      'text': 'Flutter is an open-source UI software development toolkit created by Google.'
          'Flutter is an open-source UI software development toolkit created by Google.'
    },
    {'sender': 'user', 'text': 'Tell me about Flutter.'},
    {
      'sender': 'bot',
      'text': 'Flutter is an open-source UI software development toolkit created by Google.'
          'Flutter is an open-source UI software development toolkit created by Google.'
    },
    {'sender': 'user', 'text': 'Hello!'},
    {'sender': 'bot', 'text': 'Hi there! How can I help you today?'},
    {'sender': 'user', 'text': 'Tell me about Flutter.'},
    {
      'sender': 'bot',
      'text':
          'Flutter is an open-source UI software development toolkit created by Google.'
    },
    {'sender': 'user', 'text': 'Hello!'},
    {'sender': 'bot', 'text': 'Hi there! How can I help you today?'},
    {'sender': 'user', 'text': 'Tell me about Flutter.'},
    {
      'sender': 'bot',
      'text':
          'Flutter is an open-source UI software development toolkit created by Google.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double paddingSize = isLargeScreen
        ? drawerDisplayWidthThreshold * 0.15
        : MediaQuery.of(context).size.width * 0.15;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return Align(
          alignment: message['sender'] == 'user'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Padding(
            padding: message['sender'] == 'user'
                ? EdgeInsets.only(left: paddingSize, bottom: 15)
                : const EdgeInsets.only(bottom: 15),
            child: message['sender'] == 'user'
                ? Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      message['text'] ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      message['text'] ?? '',
                    ),
                  ),
          ),
        );
      },
    );
  }
}
