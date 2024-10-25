import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/view/knowledge/widget/create_knowledge_dialog.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AddKnowledgeDialog extends StatefulWidget {
  const AddKnowledgeDialog({super.key});

  @override
  State<AddKnowledgeDialog> createState() => _AddKnowledgeDialogState();
}

class _AddKnowledgeDialogState extends State<AddKnowledgeDialog> {
  final _formKey = GlobalKey<FormState>();
  String knowledgeName = '';
  String knowledgeDescription = '';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isLargeScreen = constraints.maxWidth > drawerDisplayWidthThreshold;
      return FDialog(
        direction: Axis.horizontal,
        title: const Text('Select Knowledge'),
        body: Flex(
          direction: isLargeScreen ? Axis.horizontal : Axis.vertical,
          children: [
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: SizedBox(
                width: 200,
                child: ShadInput(
                  placeholder: Text('Search'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                child: FButton(
                  label: const Text('Create Knowledge'),
                  onPress: () => showAdaptiveDialog(
                    context: context,
                    builder: (context) => CreateKnowledgeDialog(),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          FButton(
              style: FButtonStyle.outline,
              label: const Text('Cancel'),
              onPress: () => Navigator.of(context).pop()),
        ],
      );
    });
  }
}
