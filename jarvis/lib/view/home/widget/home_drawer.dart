import 'package:flutter/material.dart';
import 'package:jarvis/view/email/email_screen.dart';
import 'package:jarvis/view/home/home_screen.dart';
import 'package:jarvis/view/personal/personal_screen.dart';
import 'package:jarvis/view/profile/profile_screen.dart';
import 'package:jarvis/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';
import '../../../view_model/auth_view_model.dart';
import '../../auth/auth_screen.dart';
import '../../auth_redirect/auth_redirect.dart';
import '../../shared/app_logo_with_name.dart';
import '../../../view_model/drawer_view_model.dart';

class HomeDrawer extends StatelessWidget {
  final bool isLargeScreen;

  const HomeDrawer({
    super.key,
    required this.isLargeScreen,
  });

  @override
  Widget build(BuildContext context) {
    final drawerNotifier = Provider.of<DrawerViewModel>(context);
    final chatViewModel = Provider.of<ChatViewModel>(context);
    final conversations = chatViewModel.conversations;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 12),
              child: Row(
                children: [
                  const AppLogoWithName(),
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
              tileColor: drawerNotifier.value == 0
                  ? (Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF303f52)
                      : const Color(0xFFdce3f3))
                  : null,
              iconColor: drawerNotifier.value == 0 ? Colors.blue : null,
              textColor: drawerNotifier.value == 0 ? Colors.blue : null,
              onTap: () {
                drawerNotifier.selectTab(0);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
            ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text(
                  'Profile',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                tileColor: drawerNotifier.value == 1
                    ? (Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF303f52)
                        : const Color(0xFFdce3f3))
                    : null,
                iconColor: drawerNotifier.value == 1 ? Colors.blue : null,
                textColor: drawerNotifier.value == 1 ? Colors.blue : null,
                onTap: () {
                  drawerNotifier.selectTab(1);

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const AuthRedirect(),
                    ),
                  );
                }),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              tileColor: drawerNotifier.value == 2
                  ? (Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF303f52)
                      : const Color(0xFFdce3f3))
                  : null,
              iconColor: drawerNotifier.value == 2 ? Colors.blue : null,
              textColor: drawerNotifier.value == 2 ? Colors.blue : null,
              onTap: () {
                drawerNotifier.selectTab(2);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const EmailScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.work),
              title: const Text(
                'Personal',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              tileColor: drawerNotifier.value == 3
                  ? (Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF303f52)
                      : const Color(0xFFdce3f3))
                  : null,
              iconColor: drawerNotifier.value == 3 ? Colors.blue : null,
              textColor: drawerNotifier.value == 3 ? Colors.blue : null,
              onTap: () {
                drawerNotifier.selectTab(3);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const PersonalScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text(
                'New Chat',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                chatViewModel.changeConversation(null);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: conversations?.length,
                itemBuilder: (context, index) {
                  int listViewIndex = index + 4;
                  return ListTile(
                    title: Text(
                      conversations![index].title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    tileColor: drawerNotifier.value == listViewIndex
                        ? (Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF303f52)
                            : const Color(0xFFdce3f3))
                        : null,
                    iconColor: drawerNotifier.value == listViewIndex
                        ? Colors.blue
                        : null,
                    textColor: drawerNotifier.value == listViewIndex
                        ? Colors.blue
                        : null,
                    onTap: () {
                      drawerNotifier.selectTab(listViewIndex);
                      chatViewModel
                          .changeConversation(conversations![index].id);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
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
