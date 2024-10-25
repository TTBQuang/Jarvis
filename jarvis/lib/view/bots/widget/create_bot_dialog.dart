import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class CreateBotDialog extends StatefulWidget {
  const CreateBotDialog({super.key});

  @override
  State<CreateBotDialog> createState() => _CreateBotDialogState();
}

class _CreateBotDialogState extends State<CreateBotDialog> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: const Text('Create New Bot'),
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              FTextField(
                controller: TextEditingController(),
                label: const Text('Bot Name'),
                hint: 'Enter bot name',
                maxLines: 1,
                maxLength: 50,
              ),
              const SizedBox(height: 10),
              FTextField.multiline(
                controller: TextEditingController(),
                label: const Text('Bot Description'),
                hint: 'Enter bot description',
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
