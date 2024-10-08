import 'package:flutter/material.dart';

class HomeTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isLargeScreen;

  HomeTopAppBar({super.key, required this.isLargeScreen});

  final List<String> items = [
    'ChatGPT-2o TurboTurbo',
    'ChatGPT-5o',
    'ChatGPT-4o',
    'ChatGPT-3o',
    'ChatGPT-6o',
    'ChatGPT-7o'
  ];

  @override
  Widget build(BuildContext context) {
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
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(20),
                    isExpanded: true,
                    value: items[0],
                    items: items.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            value,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (_) {},
                    underline: Container(),
                    dropdownColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF303f52)
                            : const Color(0xFFdce3f3),
                    menuMaxHeight: 300,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF303f52)
                    : const Color(0xFFdce3f3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(
                    '50',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF6297ee)
                          : const Color(0xFF285baf),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Image(
                    image: AssetImage("assets/token.png"),
                    width: 24.0,
                    height: 24.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
