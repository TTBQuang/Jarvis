import 'package:flutter/material.dart';
import 'package:jarvis/model/prompt.dart';
import 'package:jarvis/view/prompt_library/widget/delete_prompt_dialog.dart';
import 'package:jarvis/view/prompt_library/widget/send_prompt_bottom_sheet.dart';
import 'package:jarvis/view/prompt_library/widget/update_prompt_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../view_model/prompt_view_model.dart';

class PrivatePromptItem extends StatelessWidget {
  final Prompt prompt;

  const PrivatePromptItem({super.key, required this.prompt});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            prompt.title,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _showUpdatePromptBottomSheet(context),
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => _showDeletePromptDialog(context),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          onTap: () {
            _onItemTapped(context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const Divider(),
      ],
    );
  }

  void _showUpdatePromptBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height *
                maxBottomSheetHeightPercentage,
          ),
          child: UpdatePromptBottomSheet(
            prompt: prompt,
            onSave: (Prompt prompt) async {
              final PromptViewModel promptViewModel = context.read<PromptViewModel>();
              await promptViewModel.updatePrompt(prompt);
            },
          ),
        );
      },
    );
  }

  void _showDeletePromptDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeletePromptDialog(
          onDelete: () async {
            final promptViewModel = context.read<PromptViewModel>();
            await promptViewModel.deletePrompt(promptId: prompt.id);
          },
        );
      },
    );
  }

  void _onItemTapped(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height *
                maxBottomSheetHeightPercentage,
          ),
          child: SendPromptBottomSheet(prompt: prompt),
        );
      },
    );
  }
}
