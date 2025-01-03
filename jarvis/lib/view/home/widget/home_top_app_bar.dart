import 'package:flutter/material.dart';
import 'package:jarvis/model/chat.dart';
import 'package:jarvis/view/shared/token_display.dart';
import 'package:jarvis/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';

class HomeTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isLargeScreen;

  const HomeTopAppBar({super.key, required this.isLargeScreen});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final chatViewModel = Provider.of<ChatViewModel>(context);
    final token = chatViewModel.token;
    final assistantId = chatViewModel.assistantId;

    return AppBar(
      forceMaterialTransparency: true,
      leading: isLargeScreen
          ? null
          : Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: IntrinsicWidth(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF303f52)
                      : const Color(0xFFdce3f3),
                  child: DropdownButton<AssistantId>(
                    borderRadius: BorderRadius.circular(20),
                    isExpanded: true,
                    value: assistantId,
                    underline: Container(),
                    dropdownColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? const Color.fromARGB(255, 13, 21, 31)
                            : const Color(0xFFdce3f3),
                    menuMaxHeight: 300,
                    items: AssistantId.values
                        .map((item) => DropdownMenuItem<AssistantId>(
                              value: item,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  item!.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (AssistantId? newAssistantId) {
                      chatViewModel.changeAssistant(newAssistantId!);
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TokenDisplay(
              token: token,
            ),
          ),
        ],
      ),
    );
  }
}
