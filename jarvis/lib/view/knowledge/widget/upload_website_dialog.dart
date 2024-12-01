import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/knowledge_view_model.dart';

class UploadWebsiteDialog extends StatelessWidget {
  final Function(String url, String name) onUpload;

  const UploadWebsiteDialog({super.key, required this.onUpload});

  @override
  Widget build(BuildContext context) {
    final TextEditingController urlController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    return AlertDialog(
      title: const Text('Upload Website'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: urlController,
            decoration: const InputDecoration(
              labelText: 'URL',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Consumer<KnowledgeViewModel>(builder: (context, viewModel, child) {
          if (viewModel.isUploadingFile) {
            return const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            );
          } else {
            return ElevatedButton(
              onPressed: () async {
                final url = urlController.text;
                final name = nameController.text;
                await onUpload(url, name);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Upload',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }
        }),
      ],
    );
  }
}
