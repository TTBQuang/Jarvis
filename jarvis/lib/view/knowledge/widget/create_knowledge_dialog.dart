import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../../view_model/knowledge_view_model.dart';

class CreateKnowledgeDialog extends StatefulWidget {
  const CreateKnowledgeDialog({super.key});

  @override
  State<CreateKnowledgeDialog> createState() => _CreateKnowledgeDialogState();
}

class _CreateKnowledgeDialogState extends State<CreateKnowledgeDialog> {
  final _formKey = GlobalKey<FormState>();
  String knowledgeName = '';
  String knowledgeDescription = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FDialog(
        direction: Axis.horizontal,
        title: const Text('Create New Knowledge'),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Consumer<AuthViewModel>(
                builder: (context, authViewModel, child) {
                  return authViewModel.user.userToken != null
                      ? const SizedBox.shrink()
                      : const Text(
                          'You must sign in to use this function',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                },
              ),
              const SizedBox(height: 10),
              FTextField(
                controller: nameController,
                label: const Text('Knowledge Name'),
                hint: 'Enter knowledge name',
                maxLines: 1,
                maxLength: 50,
              ),
              const SizedBox(height: 10),
              FTextField.multiline(
                controller: descriptionController,
                label: const Text('Knowledge Description'),
                hint: 'Enter knowledge description',
                maxLines: 4,
                maxLength: 2000,
              ),
              const SizedBox(height: 10),
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
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final knowledgeViewModel =
                    Provider.of<KnowledgeViewModel>(context, listen: false);
                knowledgeViewModel.createKnowledge(
                    nameController.text, descriptionController.text);
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
              'Confirm',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
