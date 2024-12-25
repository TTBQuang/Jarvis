import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/model/bot.dart';
import 'package:jarvis/view/bots/widget/knowledge_list_dialog.dart';
import 'package:jarvis/view/home/widget/chat_bottom_bar.dart';
import 'package:jarvis/view/home/widget/messages_list.dart';
import 'package:jarvis/view/home/widget/options_bottom_sheet.dart';
import 'package:jarvis/view/shared/app_logo_with_name.dart';
import 'package:jarvis/view/shared/my_scaffold.dart';
import 'package:jarvis/view/shared/token_display.dart';
import 'package:jarvis/view_model/bot_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BotDetailScreen extends StatefulWidget {
  const BotDetailScreen({super.key, required this.bot});

  final BotData bot;

  @override
  State<BotDetailScreen> createState() => _BotDetailScreenState();
}

class _BotDetailScreenState extends State<BotDetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final botViewModel = context.read<BotViewModel>();
      botViewModel.getImportedKnowledge(assistantId: widget.bot.id);
    });
  }

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
          resizeToAvoidBottomInset: true,
          isLargeScreen: isLargeScreen,
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
          body: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isLargeScreen
                    ? drawerDisplayWidthThreshold
                    : double.infinity,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
                      child: FButton(
                        label: const Text('Knowledge List'),
                        onPress: () => showAdaptiveDialog(
                          context: context,
                          builder: (context) => KnowledgeListDialog(
                            bot: widget.bot,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: MessagesList(isLargeScreen: isLargeScreen),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChatBottomBar(
                      onAddIconBtnClicked: (context) =>
                          _showOptionsBottomSheet(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const OptionsBottomSheet();
      },
    );
  }
}
