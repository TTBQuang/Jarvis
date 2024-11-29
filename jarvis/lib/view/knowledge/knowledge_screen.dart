import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/view/knowledge/widget/create_knowledge_dialog.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../view_model/knowledge_view_model.dart';
import 'knowledge_detail_screen.dart';

class KnowledgeScreen extends StatefulWidget {
  const KnowledgeScreen({super.key});

  @override
  State<KnowledgeScreen> createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    final viewModel = Provider.of<KnowledgeViewModel>(context, listen: false);
    if (viewModel.knowledgeList == null) {
      Future.microtask(() {
        viewModel.fetchKnowledgeList();
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final viewModel = Provider.of<KnowledgeViewModel>(context, listen: false);
      if (viewModel.knowledgeList?.meta.hasNext == true) {
        _loadMoreData();
      }
    }
  }

  Future<void> _loadMoreData({bool resetOffset = false}) async {
    final viewModel = Provider.of<KnowledgeViewModel>(context, listen: false);

    viewModel.fetchKnowledgeList(
      query: _searchController.text.isEmpty ? '' : _searchController.text,
      offset: resetOffset ? 0 : viewModel.knowledgeList!.data.length,
      limit: defaultLimitKb,
    );
  }

  void _onSearchChanged(String _) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _loadMoreData(resetOffset: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > drawerDisplayWidthThreshold;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flex(
              direction: isLargeScreen ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: isLargeScreen
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    width: 200,
                    child: FTextField(
                      controller: _searchController,
                      hint: 'Search',
                      maxLines: 1,
                      onChange: (value) => _onSearchChanged(value),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 250,
                    child: FButton(
                      label: const Text('Create Knowledge'),
                      onPress: () => showAdaptiveDialog(
                        context: context,
                        builder: (context) => const CreateKnowledgeDialog(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Consumer<KnowledgeViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isFetchingKnowledgeList) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (viewModel.knowledgeList == null ||
                    viewModel.knowledgeList!.data.isEmpty) {
                  return const Center(
                    child: Text('No Knowledge Data Available'),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: viewModel.knowledgeList?.data.length,
                    itemBuilder: (context, index) {
                      final knowledge = viewModel.knowledgeList?.data[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          trailing: IconButton(
                            onPressed: () {
                              viewModel.deleteKnowledge(knowledge?.id ?? '');
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          title: Text(knowledge?.knowledgeName ?? ''),
                          leading: Image.asset(
                            "assets/knowledge_icon.png",
                            width: 45,
                            height: 45,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    KnowledgeDetailScreen(knowledge!),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel(); // Hủy Timer khi dispose
    _scrollController.dispose();
    super.dispose();
  }
}
