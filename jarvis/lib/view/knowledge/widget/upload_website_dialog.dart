import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/knowledge_view_model.dart';

class UploadWebsiteDialog extends StatefulWidget {
  final Function(String url, String name) onUpload;

  const UploadWebsiteDialog({super.key, required this.onUpload});

  @override
  State<UploadWebsiteDialog> createState() => _UploadWebsiteDialogState();
}

class _UploadWebsiteDialogState extends State<UploadWebsiteDialog> {
  late TextEditingController urlController;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    urlController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    urlController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Upload Website'),
      content: SingleChildScrollView(
        child: Column(
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
                await widget.onUpload(url, name);
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
