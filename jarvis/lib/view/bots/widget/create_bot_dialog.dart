import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/view_model/bot_view_model.dart';
import 'package:provider/provider.dart';

class CreateBotDialog extends StatefulWidget {
  const CreateBotDialog({super.key});

  @override
  State<CreateBotDialog> createState() => _CreateBotDialogState();
}

class _CreateBotDialogState extends State<CreateBotDialog> {
  @override
  Widget build(BuildContext context) {
    final botViewModel = Provider.of<BotViewModel>(context);
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return SingleChildScrollView(
      child: AlertDialog(
        title: const Text('Create New Bot'),
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              FTextField(
                controller: nameController,
                label: const Text('Bot Name'),
                hint: 'Enter bot name',
                maxLines: 1,
                maxLength: 50,
              ),
              const SizedBox(height: 10),
              FTextField.multiline(
                controller: descriptionController,
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
            onPressed: () async {
              await botViewModel.createBot(
                  name: nameController.text,
                  description: descriptionController.text);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: botViewModel.isCreating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const Text(
                    'Confirm',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          ),
        ],
      ),
    );
  }
}
