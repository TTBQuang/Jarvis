import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/model/knowledge.dart';
import 'package:provider/provider.dart';

import '../../../view_model/knowledge_view_model.dart';

enum UnitType { localFile, website, googleDrive, slack, confluence }

class AddUnitDialog extends StatefulWidget {
  final Knowledge knowledge;

  const AddUnitDialog(this.knowledge, {super.key});

  @override
  State<AddUnitDialog> createState() => _AddUnitDialogState();
}

class _AddUnitDialogState extends State<AddUnitDialog> {
  UnitType? _selectedUnitType = UnitType.localFile;

  @override
  Widget build(BuildContext context) {
    return FDialog(
      direction: Axis.horizontal,
      title: const Text('Add New Unit'),
      body: SizedBox(
        width: double.maxFinite,
        height: 250,
        child: Material(
          child: ListView(
            children: <Widget>[
              RadioListTile<UnitType>(
                value: UnitType.localFile,
                groupValue: _selectedUnitType,
                onChanged: (UnitType? value) {
                  setState(() {
                    _selectedUnitType = value;
                  });
                },
                title: const Text('Local File'),
              ),
              RadioListTile<UnitType>(
                value: UnitType.website,
                groupValue: _selectedUnitType,
                onChanged: (UnitType? value) {
                  setState(() {
                    _selectedUnitType = value;
                  });
                },
                title: const Text('Website'),
              ),
              RadioListTile<UnitType>(
                value: UnitType.googleDrive,
                groupValue: _selectedUnitType,
                onChanged: (UnitType? value) {
                  setState(() {
                    _selectedUnitType = value;
                  });
                },
                title: const Text('Google Drive'),
              ),
              RadioListTile<UnitType>(
                value: UnitType.slack,
                groupValue: _selectedUnitType,
                onChanged: (UnitType? value) {
                  setState(() {
                    _selectedUnitType = value;
                  });
                },
                title: const Text('Slack'),
              ),
              RadioListTile<UnitType>(
                value: UnitType.confluence,
                groupValue: _selectedUnitType,
                onChanged: (UnitType? value) {
                  setState(() {
                    _selectedUnitType = value;
                  });
                },
                title: const Text('Confluence'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        FButton(
          style: FButtonStyle.outline,
          label: const Text('Cancel'),
          onPress: () => Navigator.of(context).pop(),
        ),
        Consumer<KnowledgeViewModel>(builder: (context, viewModel, child) {
          return FButton(
            label: viewModel.isUploadingFile
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  )
                : const Text('Next'),
            onPress: () async {
              await handleUpload(context, widget.knowledge.id);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
          );
        }),
      ],
    );
  }
}

Future<String?> pickLocalFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.any,
  );

  if (result != null && result.files.isNotEmpty) {
    return result.files.first.path;
  }
  return null;
}

Future<void> handleUpload(BuildContext context, String knowledgeId) async {
  final knowledgeViewModel =
      Provider.of<KnowledgeViewModel>(context, listen: false);
  final filePath = await pickLocalFile();
  if (filePath != null) {
    await knowledgeViewModel.uploadLocalFile(
        knowledgeId: knowledgeId, path: filePath);
  } else {
    print('No file selected');
  }
}
