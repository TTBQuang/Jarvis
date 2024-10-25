import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/view/shared/my_scaffold.dart';
import 'package:jarvis/view/shared/top_app_bar_with_drawer_icon.dart';
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
        home: MyScaffold(
          appBar: TopAppBarWithDrawerIcon(isLargeScreen: isLargeScreen),
          body: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isLargeScreen
                    ? drawerDisplayWidthThreshold
                    : double.infinity,
              ),
              child: Column(
                children: [
                  if (isLargeScreen)
                    Text(
                      'Jarvis - Best AI Assistant Powered by GPT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  isLargeScreen
                      ? const SizedBox(height: 20)
                      : const SizedBox.shrink(),
                  isLargeScreen
                      ? const Text(
                          'Upgrade plan now for a seamless, user-friendly experience. Unlock the full potential of our app and enjoy convenience at your fingertips.',
                          textAlign: TextAlign.center,
                        )
                      : const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            'Upgrade plan now for a seamless, user-friendly experience.',
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                  if (isLargeScreen) const SizedBox(height: 30),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isLargeScreen ? 0 : 50),
                      child: GridView.count(
                          crossAxisCount: isLargeScreen ? 3 : 1,
                          crossAxisSpacing: 20,
                          childAspectRatio: isLargeScreen ? 1 : 0.7,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FIcon(FAssets.icons.sun),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Basic',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text('Free',
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FIcon(FAssets.icons.infinity),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Starter',
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '1-month Free Trial',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                            ),
                                            const Text('Then',
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            const Text(
                                              '\$9.99/month',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 200,
                                                child: FButton(
                                                  label: const Text(
                                                      'Subscribe Now'),
                                                  onPress: () {},
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FIcon(FAssets.icons.crown),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Pro Annually',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('1-month Free Trial',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary)),
                                            const Text('Then',
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            const Text('\$79.99/year',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey)),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 200,
                                                child: FButton(
                                                  label: const Text(
                                                      'Subscribe Now'),
                                                  onPress: () {},
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
          isLargeScreen: isLargeScreen,
        ),
      );
    });
  }
}
