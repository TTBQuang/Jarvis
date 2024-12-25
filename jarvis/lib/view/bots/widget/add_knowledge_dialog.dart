import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/model/bot.dart';
import 'package:jarvis/view_model/bot_view_model.dart';
import 'package:jarvis/view_model/knowledge_view_model.dart';
import 'package:provider/provider.dart';

class AddKnowledgeDialog extends StatefulWidget {
  const AddKnowledgeDialog({super.key, required this.bot});

  final BotData bot;

  @override
  State<AddKnowledgeDialog> createState() => _AddKnowledgeDialogState();
}

class _AddKnowledgeDialogState extends State<AddKnowledgeDialog> {
  @override
  Widget build(BuildContext context) {
    final botViewModel = Provider.of<BotViewModel>(context);
    final knowledgeViewModel = Provider.of<KnowledgeViewModel>(context);
    final knowledges = (knowledgeViewModel.knowledgeList?.data ?? [])
        .takeWhile((knowledge) =>
            botViewModel.importedKnowledge.indexWhere(
                (importedKnowledge) => importedKnowledge.id == knowledge.id) ==
            -1)
        .toList();

    return AlertDialog(
      title: const Text('Select Knowledge'),
      content: SingleChildScrollView(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Column(
            children: [
              const FTextField(
                hint: 'Search',
                maxLines: null,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: knowledges.length,
                  itemBuilder: (context, index) {
                    final knowledge = knowledges[index];
                    return ListTile(
                      title: Text(knowledge.knowledgeName),
                      subtitle: Text(knowledge.description),
                      trailing: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => botViewModel.addKnowledge(
                          assistantId: widget.bot.id,
                          knowledgeId: knowledge.id,
                        ),
                      ),
                    );
                  },
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
    );
  }
}
