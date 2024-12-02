import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/model/knowledge.dart';
import 'package:jarvis/view/knowledge/widget/upload_confluence_dialog.dart';
import 'package:jarvis/view/knowledge/widget/upload_slack_dialog.dart';
import 'package:jarvis/view/knowledge/widget/upload_website_dialog.dart';
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
              if (_selectedUnitType == UnitType.localFile) {
                await uploadLocalFile(context, widget.knowledge.id);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              } else if (_selectedUnitType == UnitType.website) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) => UploadWebsiteDialog(
                    onUpload: (url, name) async {
                      final knowledgeViewModel =
                          Provider.of<KnowledgeViewModel>(context,
                              listen: false);

                      await knowledgeViewModel.uploadWebsite(
                        webUrl: url,
                        unitName: name,
                        knowledgeId: widget.knowledge.id,
                      );
                    },
                  ),
                );
              } else if (_selectedUnitType == UnitType.googleDrive) {
              } else if (_selectedUnitType == UnitType.slack) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) => UploadSlackDialog(
                    onUpload: (name, workspace, token) async {
                      final knowledgeViewModel =
                          Provider.of<KnowledgeViewModel>(context,
                              listen: false);

                      await knowledgeViewModel.uploadDataFromSlack(
                        name: name,
                        workspace: workspace,
                        token: token,
                        knowledgeId: widget.knowledge.id,
                      );
                    },
                  ),
                );
              } else if (_selectedUnitType == UnitType.confluence) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) => UploadConfluenceDialog(
                    onUpload: (name, wikiPageUrl, username, accessToken) async {
                      final knowledgeViewModel =
                          Provider.of<KnowledgeViewModel>(context,
                              listen: false);

                      await knowledgeViewModel.uploadDataFromConfluence(
                        name: name,
                        wikiPageUrl: wikiPageUrl,
                        username: username,
                        accessToken: accessToken,
                        knowledgeId: widget.knowledge.id,
                      );
                    },
                  ),
                );
              }
            },
          );
        }),
      ],
    );
  }
}

Future<void> uploadLocalFile(BuildContext context, String knowledgeId) async {
  final knowledgeViewModel =
  Provider.of<KnowledgeViewModel>(context, listen: false);
  final result = await FilePicker.platform.pickFiles(
    type: FileType.any,
  );

  if (result != null) {
    if (kIsWeb) {
      final bytes = result.files.single.bytes;
      if (bytes != null) {
        await knowledgeViewModel.uploadLocalFileWeb(
          knowledgeId: knowledgeId,
          fileName: result.files.single.name,
          bytes: bytes,
        );
      }
    } else {
      final filePath = result.files.single.path;
      if (filePath != null) {
        await knowledgeViewModel.uploadLocalFile(
          knowledgeId: knowledgeId,
          path: filePath,
        );
      }
    }
  } else {
    print('No file selected');
  }
}