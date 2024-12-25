import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/model/bot.dart';
import 'package:jarvis/view/bots/widget/add_knowledge_dialog.dart';
import 'package:jarvis/view/knowledge/widget/create_knowledge_dialog.dart';
import 'package:jarvis/view_model/bot_view_model.dart';
import 'package:jarvis/view_model/knowledge_view_model.dart';
import 'package:provider/provider.dart';

class KnowledgeListDialog extends StatefulWidget {
  const KnowledgeListDialog({super.key, required this.bot});

  final BotData bot;

  @override
  State<KnowledgeListDialog> createState() => _KnowledgeListDialogState();
}

class _KnowledgeListDialogState extends State<KnowledgeListDialog> {
  @override
  Widget build(BuildContext context) {
    final knowledgeViewModel = Provider.of<KnowledgeViewModel>(context);
    final botViewModel = Provider.of<BotViewModel>(context);

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
                builder: (context) => AddKnowledgeDialog(bot: widget.bot),
              ),
            ),
          ],
        ),
        body: SizedBox(
          height: 300,
          width: double.maxFinite,
          child: Material(
            child: ListView(
              children: botViewModel.importedKnowledge
                  .map((knowledge) => ListTile(
                        title: Text(knowledge.knowledgeName),
                        subtitle: Text(knowledge.description),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            botViewModel.removeKnowledge(
                                assistantId: widget.bot.id,
                                knowledgeId: knowledge.id);
                          },
                        ),
                      ))
                  .toList(),
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
