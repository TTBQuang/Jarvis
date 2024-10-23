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
    return FDialog(
      direction: Axis.horizontal,
      title: const Text('Create New Knowledge'),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 10),
            FTextField(
              controller: TextEditingController(), // TextEditingController
              label: const Text('Knowledge Name'),
              hint: 'Enter knowledge name',
              maxLines: 1,
              maxLength: 50,
            ),
            SizedBox(height: 10),
            FTextField.multiline(
              controller: TextEditingController(), // TextEditingController
              label: const Text('Knowledge Description'),
              hint: 'Enter knowledge description',
              maxLines: 4,
              maxLength: 2000,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      actions: [
        FButton(
            style: FButtonStyle.outline,
            label: const Text('Cancel'),
            onPress: () => Navigator.of(context).pop()),
        FButton(
            label: const Text('Confirm'),
            onPress: () => Navigator.of(context).pop()),
      ],
    );
  }
}
