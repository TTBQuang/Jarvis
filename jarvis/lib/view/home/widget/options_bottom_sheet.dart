import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jarvis/view_model/chat_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../prompt_library/prompt_library_bottom_sheet.dart';

class OptionsBottomSheet extends StatelessWidget {
  const OptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final chatViewModel = Provider.of<ChatViewModel>(context);

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
            onTap: () {
              _pickImage(context, ImageSource.gallery, chatViewModel);
            },
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
            onTap: () {
              _pickImage(context, ImageSource.camera, chatViewModel);
            },
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
            maxHeight: MediaQuery.of(context).size.height *
                maxBottomSheetHeightPercentage,
          ),
          child: const PromptLibraryBottomSheet(),
        );
      },
    );
  }
}

Future<void> _pickImage(BuildContext context, ImageSource source,
    ChatViewModel chatViewModel) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    // Do something with the image (e.g., show it, upload it, etc.)
    Navigator.of(context).pop();
    chatViewModel.setImage(imageFile);
  } else {
    // Handle the case when no image is selected or camera capture is cancelled
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('No image selected or capture was cancelled')),
    );
  }
}
