import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jarvis/view/prompt_library/widget/private_prompt_item.dart';
import 'package:jarvis/view_model/prompt_view_model.dart'; // Import PromptViewModel
import 'package:provider/provider.dart';

import '../../../constant.dart'; // Import AuthViewModel

class PrivatePromptTab extends StatefulWidget {
  const PrivatePromptTab({super.key});

  @override
  State<StatefulWidget> createState() => _PrivatePromptTabState();
}

class _PrivatePromptTabState extends State<PrivatePromptTab> {
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
      if (context.read<PromptViewModel>().privatePromptList?.hasNext == true) {
        _loadMoreData();
      }
    }
  }

  Future<void> _loadMoreData({bool resetOffset = false}) async {
    final viewModel = context.read<PromptViewModel>();
    final currentOffset = viewModel.privatePromptList?.offset ?? 0;

    await viewModel.fetchPrivatePrompts(
      offset: resetOffset ? 0 : currentOffset + defaultLimit,
      limit: defaultLimit,
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
        // Kiểm tra thông báo lỗi từ viewModel
        if (viewModel.errorMessagePrivateTab.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 48),
                const SizedBox(height: 8),
                Text(
                  viewModel.errorMessagePrivateTab,
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

        // Lấy danh sách private prompts từ viewModel
        var privatePromptList = viewModel.privatePromptList;

        // Nếu chưa có dữ liệu (chưa load hoặc lỗi khác ngoài errorMessage)
        if (privatePromptList == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Nếu không có lỗi và dữ liệu đã tải thành công, hiển thị danh sách prompts
        return Column(
          children: [
            TextField(
              controller: searchQueryController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search prompts...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                // Thêm ScrollController
                itemCount: privatePromptList.items.length,
                // Sử dụng length của danh sách privatePromptList
                itemBuilder: (context, index) {
                  return PrivatePromptItem(
                      prompt: privatePromptList.items[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
