import 'package:flutter/material.dart';
import 'package:jarvis/view/prompt_library/widget/private_prompt_tab.dart';
import 'package:jarvis/view/prompt_library/widget/prompt_library_header.dart';
import 'package:jarvis/view/prompt_library/widget/prompt_library_toggle.dart';
import 'package:jarvis/view/prompt_library/widget/public_prompt_tab.dart';
import 'package:jarvis/view_model/prompt_view_model.dart';
import 'package:provider/provider.dart';

enum PromptType { private, public }

class PromptLibraryBottomSheet extends StatelessWidget {
  const PromptLibraryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final promptViewModel = Provider.of<PromptViewModel>(context);
    final currentType = promptViewModel.currentType;

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
            onToggle: promptViewModel.changePromptType,
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
