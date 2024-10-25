import 'package:flutter/material.dart';

import 'app_logo_with_name.dart';

class TopAppBarWithDrawerIcon extends StatelessWidget
    implements PreferredSizeWidget {
  const TopAppBarWithDrawerIcon({super.key, required this.isLargeScreen});

  final bool isLargeScreen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
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
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLogoWithName(),
          SizedBox(width: 48),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
