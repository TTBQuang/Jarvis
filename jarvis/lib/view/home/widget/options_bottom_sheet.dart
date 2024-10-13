import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../prompt_library/prompt_library_bottom_sheet.dart';

class OptionsBottomSheet extends StatelessWidget {
  const OptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text(
              'Upload Image',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text(
              'Take Photo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text(
              'Prompt Library',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () {
              Navigator.of(context).pop();
              _showPromptLibraryBottomSheet(context);
            },
          ),
        ],
      ),
    );
  }

  void _showPromptLibraryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * maxBottomSheetHeightPercentage,
          ),
          child: const PromptLibraryBottomSheet(),
        );
      },
    );
  }
}
