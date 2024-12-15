import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/view/prompt_library/widget/public_prompt_item.dart';
import 'package:jarvis/view_model/prompt_view_model.dart';
import 'package:provider/provider.dart';

import '../../../model/category.dart';

class PublicPromptTab extends StatefulWidget {
  const PublicPromptTab({super.key});

  @override
  State<StatefulWidget> createState() => _PublicPromptTabState();
}

class _PublicPromptTabState extends State<PublicPromptTab> {
  bool isFavorite = false;

  Category selectedCategory = Category.all;

  late ScrollController _scrollController;
  late Timer _debounceTimer;
  final TextEditingController searchQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {});
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (context.read<PromptViewModel>().publicPromptList?.hasNext == true) {
        _loadMoreData();
      }
    }
  }

  Future<void> _loadMoreData({bool resetOffset = false}) async {
    final viewModel = context.read<PromptViewModel>();
    final currentOffset = viewModel.publicPromptList?.offset ?? 0;

    await viewModel.fetchPublicPrompt(
      category: selectedCategory == Category.all ? null : selectedCategory,
      offset: resetOffset ? 0 : currentOffset + defaultLimitPrompt,
      limit: defaultLimitPrompt,
      isFavorite: isFavorite ? true : null,
      query: searchQueryController.text.isNotEmpty
          ? searchQueryController.text
          : null,
    );
  }

  @override
  void dispose() {
    _debounceTimer.cancel();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String _) {
    if (_debounceTimer.isActive) {
      _debounceTimer.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _loadMoreData(resetOffset: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PromptViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.errorMessagePublicTab.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 48),
                const SizedBox(height: 8),
                Text(
                  viewModel.errorMessagePublicTab,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }

        var promptList = viewModel.publicPromptList;

        if (viewModel.isPublicPromptListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchQueryController,
                    onChanged: _onSearchChanged,
                    // Gọi hàm _onSearchChanged khi gõ
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search prompts...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                      _loadMoreData(resetOffset: true);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                        color:
                            isFavorite ? const Color(0xFFFFD700) : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 10),
                  child: Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: IntrinsicWidth(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF303f52)
                            : const Color(0xFFdce3f3),
                        child: DropdownButton<Category>(
                          value: selectedCategory,
                          borderRadius: BorderRadius.circular(8),
                          isExpanded: true,
                          underline: Container(),
                          dropdownColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? const Color(0xFF303f52)
                                  : const Color(0xFFdce3f3),
                          menuMaxHeight: 600,
                          items: Category.values.map((Category category) {
                            return DropdownMenuItem<Category>(
                              value: category,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Center(
                                  child: Text(
                                    category.displayName,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (Category? newCategory) {
                            setState(() {
                              selectedCategory = newCategory ?? Category.all;
                            });
                            _loadMoreData(resetOffset: true);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: promptList?.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return PublicPromptItem(prompt: promptList!.items[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
