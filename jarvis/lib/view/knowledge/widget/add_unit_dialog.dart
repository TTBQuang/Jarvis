import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class AddUnitDialog extends StatefulWidget {
  const AddUnitDialog({super.key});

  @override
  State<AddUnitDialog> createState() => _AddUnitDialogState();
}

class _AddUnitDialogState extends State<AddUnitDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FDialog(
      direction: Axis.horizontal,
      title: const Text('Add New Unit'),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 10),
            FTextField(
              controller: TextEditingController(), // TextEditingController
              label: const Text('Unit Name'),
              hint: 'Enter unit name',
              maxLines: 1,
              maxLength: 50,
            ),
            SizedBox(height: 10),
            FTextField.multiline(
              controller: TextEditingController(), // TextEditingController
              label: const Text('Unit Description'),
              hint: 'Enter unit description',
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
            label: const Text('Next'),
            onPress: () => Navigator.of(context).pop()),
      ],
    );
  }
}
