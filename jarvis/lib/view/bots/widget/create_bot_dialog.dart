import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class CreateBotDialog extends StatefulWidget {
  const CreateBotDialog({super.key});

  @override
  State<CreateBotDialog> createState() => _CreateBotDialogState();
}

class _CreateBotDialogState extends State<CreateBotDialog> {
  final _formKey = GlobalKey<FormState>();
  String botName = '';
  String botDescription = '';

  @override
  Widget build(BuildContext context) {
    return FDialog(
      direction: Axis.horizontal,
      title: const Text('Create New Bot'),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 10),
            FTextField(
              controller: TextEditingController(), // TextEditingController
              label: const Text('Bot Name'),
              hint: 'Enter bot name',
              maxLines: 1,
              maxLength: 50,
            ),
            SizedBox(height: 10),
            FTextField.multiline(
              controller: TextEditingController(), // TextEditingController
              label: const Text('Bot Description'),
              hint: 'Enter bot description',
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
