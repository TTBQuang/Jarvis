import 'package:flutter/material.dart';
import 'package:jarvis/view/prompt_library/widget/delete_prompt_dialog.dart';
import 'package:jarvis/view/prompt_library/widget/send_prompt_bottom_sheet.dart';
import 'package:jarvis/view/prompt_library/widget/update_prompt_bottom_sheet.dart';

import '../../../constant.dart';

class PrivatePromptItem extends StatelessWidget {
  const PrivatePromptItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text(
            'Private prompt',
            style: TextStyle(fontSize: 16),
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
          child: const UpdatePromptBottomSheet(),
        );
      },
    );
  }

  void _showDeletePromptDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const DeletePromptDialog();
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
          child: SendPromptBottomSheet(),
        );
      },
    );
  }
}
