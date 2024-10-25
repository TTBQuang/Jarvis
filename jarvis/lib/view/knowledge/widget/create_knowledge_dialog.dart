import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class CreateKnowledgeDialog extends StatefulWidget {
  const CreateKnowledgeDialog({super.key});

  @override
  State<CreateKnowledgeDialog> createState() => _CreateKnowledgeDialogState();
}

class _CreateKnowledgeDialogState extends State<CreateKnowledgeDialog> {
  final _formKey = GlobalKey<FormState>();
  String knowledgeName = '';
  String knowledgeDescription = '';

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
              const SizedBox(height: 10),
              FTextField(
                controller: TextEditingController(), // TextEditingController
                label: const Text('Knowledge Name'),
                hint: 'Enter knowledge name',
                maxLines: 1,
                maxLength: 50,
              ),
              const SizedBox(height: 10),
              FTextField.multiline(
                controller: TextEditingController(), // TextEditingController
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
            onPressed: () {},
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
