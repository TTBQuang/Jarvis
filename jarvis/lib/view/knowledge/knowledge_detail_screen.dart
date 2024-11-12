import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/view/knowledge/widget/add_unit_dialog.dart';
import 'package:jarvis/view/shared/app_logo_with_name.dart';
import 'package:jarvis/view/shared/my_scaffold.dart';
import 'package:jarvis/view/shared/token_display.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class KnowledgeDetailScreen extends StatelessWidget {
  const KnowledgeDetailScreen({super.key});

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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 200,
                  child: FButton(
                    label: const Text('Add Unit'),
                    onPress: () => showAdaptiveDialog(
                      context: context,
                      builder: (context) => const AddUnitDialog(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(),
                      child: ShadTable.list(
                        header: const [
                          ShadTableCell.header(child: Text('Unit')),
                          ShadTableCell.header(child: Text('Source')),
                          ShadTableCell.header(child: Text('Size')),
                          ShadTableCell.header(
                            child: Text('Create Time'),
                          ),
                          ShadTableCell.header(
                            child: Text('Latest Update'),
                          ),
                          ShadTableCell.header(
                            child: Text('Enable'),
                          ),
                          ShadTableCell.header(
                            child: Text('Action'),
                          )
                        ],
                        children: const [
                          [
                            ShadTableCell(child: Text('')),
                            ShadTableCell(child: Text('')),
                            ShadTableCell(child: Text('')),
                            ShadTableCell(child: Text('')),
                            ShadTableCell(child: Text('')),
                            ShadTableCell(child: Text('')),
                            ShadTableCell(child: Text('')),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          isLargeScreen: isLargeScreen,
        ),
      );
    });
  }
}
