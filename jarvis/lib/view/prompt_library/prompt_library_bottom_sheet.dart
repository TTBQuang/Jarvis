import 'package:flutter/material.dart';
import 'package:jarvis/view/prompt_library/widget/private_prompt_tab.dart';
import 'package:jarvis/view/prompt_library/widget/prompt_library_header.dart';
import 'package:jarvis/view/prompt_library/widget/prompt_library_toggle.dart';
import 'package:jarvis/view/prompt_library/widget/public_prompt_tab.dart';
import 'package:jarvis/view_model/prompt_view_model.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

enum PromptType { private, public }

class PromptLibraryBottomSheet extends StatefulWidget {
  const PromptLibraryBottomSheet({super.key});

  @override
  State<StatefulWidget> createState() => _PromptLibraryBottomSheetState();
}

class _PromptLibraryBottomSheetState extends State<PromptLibraryBottomSheet> {
  PromptType currentType = PromptType.private;

  @override
  void initState() {
    super.initState();
    fetchPromptData();
  }

  void togglePromptType(PromptType type) {
    setState(() {
      currentType = type;
      fetchPromptData();
    });
  }

  void fetchPromptData() {
    final promptViewModel = Provider.of<PromptViewModel>(context, listen: false);

    if (currentType == PromptType.private) {
      promptViewModel.fetchPrivatePrompts(limit: defaultLimit);
    } else {
      promptViewModel.fetchPublicPrompt(limit: defaultLimit);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const PromptLibraryHeader(),
          const SizedBox(height: 16),
          PromptToggle(
            currentType: currentType,
            onToggle: togglePromptType,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: currentType == PromptType.private
                ? const PrivatePromptTab()
                : const PublicPromptTab(),
          ),
        ],
      ),
    );
  }
}
