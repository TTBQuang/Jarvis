import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/view/bots/widget/add_knowledge_dialog.dart';
import 'package:jarvis/view/knowledge/widget/create_knowledge_dialog.dart';

class KnowledgeListDialog extends StatefulWidget {
  const KnowledgeListDialog({super.key});

  @override
  State<KnowledgeListDialog> createState() => _KnowledgeListDialogState();
}

class _KnowledgeListDialogState extends State<KnowledgeListDialog> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FDialog(
        direction: Axis.horizontal,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Knowledge List'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => showAdaptiveDialog(
                context: context,
                builder: (context) => const AddKnowledgeDialog(),
              ),
            ),
          ],
        ),
        body: SizedBox(
          height: 300,
          width: double.maxFinite,
          child: Material(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Knowledge 1'),
                  subtitle: const Text('Description 1'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => showAdaptiveDialog(
                      context: context,
                      builder: (context) => const CreateKnowledgeDialog(),
                    ),
                  ),
                ),
              ],
            ),
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
        ],
      ),
    );
  }
}
