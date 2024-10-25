import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

enum UnitType {
  localFile,
  website,
  githubRepository,
  gitlabRepository,
  googleDrive
}

class AddUnitDialog extends StatefulWidget {
  const AddUnitDialog({super.key});

  @override
  State<AddUnitDialog> createState() => _AddUnitDialogState();
}

class _AddUnitDialogState extends State<AddUnitDialog> {
  @override
  Widget build(BuildContext context) {
    return FDialog(
      direction: Axis.horizontal,
      title: const Text('Add New Unit'),
      body: SizedBox(
        width: double.maxFinite,
        height: 200,
        child: Material(
          child: ListView(
            children: const <Widget>[
              RadioListTile(
                  value: UnitType.localFile,
                  groupValue: UnitType.localFile,
                  onChanged: null,
                  title: Text('Local File')),
              RadioListTile(
                  value: UnitType.website,
                  groupValue: UnitType.localFile,
                  onChanged: null,
                  title: Text('Website')),
              RadioListTile(
                  value: UnitType.githubRepository,
                  groupValue: UnitType.localFile,
                  onChanged: null,
                  title: Text('Github Repository')),
              RadioListTile(
                  value: UnitType.gitlabRepository,
                  groupValue: UnitType.localFile,
                  onChanged: null,
                  title: Text('Gitlab Repository')),
              RadioListTile(
                  value: UnitType.googleDrive,
                  groupValue: UnitType.localFile,
                  onChanged: null,
                  title: Text('Google Drive')),
            ],
          ),
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
