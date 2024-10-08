import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final bool isLargeScreen;

  HomeDrawer({
    super.key,
    required this.isLargeScreen,
  });

  final List<String> chatHistory = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Very longggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg',
    'Item 1',
    'Item 1',
    'Item 1',
    'Item 1',
    'Item 1',
    'Item 1',
    'Item 1',
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 12),
              child: Row(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 48,
                    height: 48,
                  ),
                  const Text(
                    'Jarvis',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const Spacer(),
                  if (!isLargeScreen)
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.chat_bubble),
              title: const Text(
                'Chat',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
              tileColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF303f52)
                  : const Color(0xFFdce3f3),
              iconColor: Colors.blue,
              textColor: Colors.blue,
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: chatHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      chatHistory[index],
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
