import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/model/bot.dart';
import 'package:jarvis/view/bots/widget/add_knowledge_dialog.dart';
import 'package:jarvis/view/home/widget/chat_bottom_bar.dart';
import 'package:jarvis/view/home/widget/messages_list.dart';
import 'package:jarvis/view/home/widget/options_bottom_sheet.dart';
import 'package:jarvis/view/shared/app_logo_with_name.dart';
import 'package:jarvis/view/shared/token_display.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PricingScreen extends StatelessWidget {
  const PricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isLargeScreen = constraints.maxWidth > drawerDisplayWidthThreshold;
      return ShadApp.material(
        title: 'Jarvis',
        materialThemeBuilder: (context, theme) {
          return theme.copyWith(
            colorScheme:
                MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? ColorScheme.fromSeed(
                        seedColor: Colors.deepPurple,
                        brightness: Brightness.dark)
                    : ColorScheme.fromSeed(
                        seedColor: Colors.lightBlueAccent,
                        brightness: Brightness.light),
            useMaterial3: true,
          );
        },
        themeMode: ThemeMode.system,
        builder: (context, child) {
          return FTheme(
              data: MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? FThemes.blue.dark
                  : FThemes.blue.light,
              child: child!);
        },
        home: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: AppLogoWithName(),
                ),
              ],
            ),
          ),
          body: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isLargeScreen
                    ? drawerDisplayWidthThreshold
                    : double.infinity,
              ),
              child: Column(
                children: [
                  FDivider(),
                  Text(
                    'Pricing',
                    style: TextStyle(fontSize: 22),
                  ),
                  Text('Jarvis - Best AI Assistant Powered by GPT',
                      style: TextStyle(fontSize: 26)),
                  Text(
                    'Upgrade plan now for a seamless, user-friendly experience. Unlock the full potential of our app and enjoy convenience at your fingertips.',
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: GridView.count(
                        crossAxisCount: isLargeScreen ? 3 : 1,
                        children: [
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FIcon(FAssets.icons.sun),
                                      Text('Basic'),
                                    ],
                                  ),
                                  Text('Free'),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FIcon(FAssets.icons.infinity),
                                      Text('Starter'),
                                    ],
                                  ),
                                  Text('1-month Free Trial'),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FIcon(FAssets.icons.crown),
                                      Text('Pro Annually'),
                                    ],
                                  ),
                                  Text('1-month Free Trial'),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
