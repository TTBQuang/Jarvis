import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/view/bots/bots_screen.dart';
import 'package:jarvis/view/knowledge/knowledge_screen.dart';
import 'package:jarvis/view/shared/token_display.dart';

import '../../constant.dart';
import '../shared/app_logo_with_name.dart';
import '../shared/my_scaffold.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > drawerDisplayWidthThreshold;
        return MyScaffold(
          appBar: AppBar(
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
                Expanded(
                  child: AppLogoWithName(),
                ),
                TokenDisplay(),
              ],
            ),
          ),
          body: FTabs(
            tabs: [
              FTabEntry(
                label: SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FIcon(FAssets.icons.bot),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Bots'),
                      ),
                    ],
                  ),
                ),
                content: const BotsScreen(),
              ),
              FTabEntry(
                label: SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FIcon(FAssets.icons.tableProperties),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Knowledge'),
                      ),
                    ],
                  ),
                ),
                content: const KnowledgeScreen(),
              ),
            ],
          ),
          isLargeScreen: isLargeScreen,
        );
      },
    );
  }
}
