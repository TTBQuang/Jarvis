import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/model/bot.dart';
import 'package:jarvis/view/bots/widget/add_knowledge_dialog.dart';
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
  Map<String, bool> deleting = {};

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
                          icon: deleting[knowledge.id] == true
                              ? const CircularProgressIndicator()
                              : const Icon(Icons.delete),
                          onPressed: () async {
                            setState(() {
                              deleting[knowledge.id] = true;
                            });

                            await botViewModel.removeKnowledge(
                                assistantId: widget.bot.id,
                                knowledgeId: knowledge.id);

                            setState(() {
                              deleting[knowledge.id] = false;
                            });
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
