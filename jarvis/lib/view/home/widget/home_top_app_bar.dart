import 'package:flutter/material.dart';
import 'package:jarvis/view/shared/token_display.dart';

class HomeTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isLargeScreen;

  const HomeTopAppBar({super.key, required this.isLargeScreen});

  @override
  State<StatefulWidget> createState() => _HomeTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeTopAppBarState extends State<HomeTopAppBar> {
  final List<String> items = [
    'ChatGPT-2o TurboTurbo',
    'ChatGPT-5o',
    'ChatGPT-4o',
    'ChatGPT-3o',
    'ChatGPT-6o',
    'ChatGPT-7o'
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      leading: widget.isLargeScreen
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
                  child: DropdownButton<int>(
                    borderRadius: BorderRadius.circular(20),
                    isExpanded: true,
                    value: selectedIndex,
                    underline: Container(),
                    dropdownColor:
                    Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF303f52)
                        : const Color(0xFFdce3f3),
                    menuMaxHeight: 300,
                    items: List.generate(items.length, (int index) {
                      return DropdownMenuItem<int>(
                        value: index,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            items[index],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }),
                    onChanged: (int? newIndex) {
                      setState(() {
                        selectedIndex = newIndex ?? 0;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: TokenDisplay(),
          ),
        ],
      ),
    );
  }
}
