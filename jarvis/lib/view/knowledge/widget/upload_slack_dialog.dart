import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/knowledge_view_model.dart';

class UploadSlackDialog extends StatelessWidget {
  final Function(String name, String workspace, String token) onUpload;

  const UploadSlackDialog({super.key, required this.onUpload});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController workspaceController = TextEditingController();
    final TextEditingController tokenController = TextEditingController();

    return AlertDialog(
      title: const Text('Upload data from Slack'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: workspaceController,
            decoration: const InputDecoration(
              labelText: 'Slack Workspace',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: tokenController,
            decoration: const InputDecoration(
              labelText: 'Slack Bot Token',
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
                final name = nameController.text;
                final workspace = workspaceController.text;
                final token = tokenController.text;
                await onUpload(name, workspace, token);
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
