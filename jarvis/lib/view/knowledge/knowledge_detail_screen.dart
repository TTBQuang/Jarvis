import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/model/knowledge.dart';
import 'package:jarvis/view/knowledge/widget/add_unit_dialog.dart';
import 'package:jarvis/view/shared/app_logo_with_name.dart';
import 'package:jarvis/view/shared/my_scaffold.dart';
import 'package:jarvis/view/shared/token_display.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../view_model/knowledge_view_model.dart';

class KnowledgeDetailScreen extends StatefulWidget {
  final Knowledge knowledge;

  const KnowledgeDetailScreen(this.knowledge, {super.key});

  @override
  State<StatefulWidget> createState() => _KnowledgeDetailScreenState();
}

class _KnowledgeDetailScreenState extends State<KnowledgeDetailScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final knowledgeViewModel =
          Provider.of<KnowledgeViewModel>(context, listen: false);

      knowledgeViewModel.fetchKnowledgeUnitList(
        knowledgeId: widget.knowledge.id,
        offset: 0,
        limit: defaultLimitKb,
      );
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final viewModel = Provider.of<KnowledgeViewModel>(context, listen: false);

    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        viewModel.knowledgeUnitList?.meta.hasNext == true) {
      viewModel.fetchKnowledgeUnitList(
        knowledgeId: widget.knowledge.id,
        offset: viewModel.knowledgeUnitList!.data.length,
        limit: defaultLimitKb,
      );
    }
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
              Row(
                children: [
                  const SizedBox(width: 10),
                  Image.asset(
                    "assets/knowledge_icon.png",
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.knowledge.knowledgeName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: FButton(
                        label: const Text('Add Unit'),
                        onPress: () => showAdaptiveDialog(
                          context: context,
                          builder: (context) => AddUnitDialog(widget.knowledge),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Consumer<KnowledgeViewModel>(
                  builder: (context, viewModel, child) {
                if (viewModel.isUploadingSuccess) {
                  return const SizedBox.shrink();
                } else {
                  return const Center(
                    child: Text(
                      'Failed to upload',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
              }),
              Expanded(
                child: Consumer<KnowledgeViewModel>(
                    builder: (context, viewModel, child) {
                  if (viewModel.isFetchingKnowledgeUnitList) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (viewModel.knowledgeUnitList == null ||
                      viewModel.knowledgeUnitList!.data.isEmpty) {
                    return const Center(
                      child: Text('No Unit Available'),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                      itemCount: viewModel.knowledgeUnitList?.data.length,
                      itemBuilder: (context, index) {
                        final unit = viewModel.knowledgeUnitList?.data[index];
                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          title: Text(
                            unit?.name ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {},
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
          isLargeScreen: isLargeScreen,
        ),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
