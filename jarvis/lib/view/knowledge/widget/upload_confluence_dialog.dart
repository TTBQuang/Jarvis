import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/knowledge_view_model.dart';

class UploadConfluenceDialog extends StatefulWidget {
  final Function(String name, String wikiPageUrl, String username, String accessToken) onUpload;

  const UploadConfluenceDialog({super.key, required this.onUpload});

  @override
  State<UploadConfluenceDialog> createState() => _UploadConfluenceDialogState();
}

class _UploadConfluenceDialogState extends State<UploadConfluenceDialog> {
  late TextEditingController nameController;
  late TextEditingController wikiPageUrlController;
  late TextEditingController usernameController;
  late TextEditingController accessTokenController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    wikiPageUrlController = TextEditingController();
    usernameController = TextEditingController();
    accessTokenController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    wikiPageUrlController.dispose();
    usernameController.dispose();
    accessTokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Upload data from Confluence'),
      content: SingleChildScrollView(
        child: Column(
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
              controller: wikiPageUrlController,
              decoration: const InputDecoration(
                labelText: 'Wiki Page URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Confluence Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: accessTokenController,
              decoration: const InputDecoration(
                labelText: 'Confluence Access Token',
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
                final name = nameController.text;
                final wikiPageUrl = wikiPageUrlController.text;
                final username = usernameController.text;
                final accessToken = accessTokenController.text;
                await widget.onUpload(name, wikiPageUrl, username, accessToken);
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
