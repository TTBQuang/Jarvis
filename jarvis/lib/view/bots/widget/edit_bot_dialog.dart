import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/model/bot.dart';
import 'package:jarvis/view_model/bot_view_model.dart';
import 'package:provider/provider.dart';

class EditBotDialog extends StatefulWidget {
  const EditBotDialog({super.key, required this.bot});

  final BotData bot;

  @override
  State<EditBotDialog> createState() => _EditBotDialogState();
}

class _EditBotDialogState extends State<EditBotDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController promptController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.bot.assistantName;
    descriptionController.text = widget.bot.description;
    promptController.text = widget.bot.instructions;
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final botViewModel = Provider.of<BotViewModel>(context);

    return SingleChildScrollView(
      child: AlertDialog(
        title: const Text('Update Assistant'),
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10),
              FTextField(
                controller: nameController,
                label: const Text('Assistant Name'),
                hint: 'Enter assistant name',
                maxLines: 1,
                maxLength: 50,
              ),
              const SizedBox(height: 10),
              FTextField.multiline(
                controller: descriptionController,
                onChange: (value) => descriptionController.text = value,
                label: const Text('Assistant Description'),
                hint: 'Enter assistant description',
                maxLines: 4,
                maxLength: 2000,
              ),
              const SizedBox(height: 10),
              FTextField(
                controller: promptController,
                onChange: (value) => promptController.text = value,
                label: const Text('Persona & Prompt'),
                hint: 'Enter prompt',
                maxLines: 1,
                maxLength: 50,
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
              await botViewModel.updateBot(
                  assistantId: widget.bot.id,
                  name: nameController.text,
                  description: descriptionController.text,
                  instructions: promptController.text);
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
