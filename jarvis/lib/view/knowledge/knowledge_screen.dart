import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/view/knowledge/widget/create_knowledge_dialog.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const knowledges = [
  (
    name: "INV001",
    units: "0",
    size: r"0 byte",
    editTime: "10/22/2024",
  ),
  (
    name: "INV004",
    units: "0",
    size: r"0 byte",
    editTime: "10/22/2024",
  ),
  (
    name: "INV005",
    units: "0",
    size: r"0 byte",
    editTime: "10/22/2024",
  ),
];

class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: SizedBox(
                width: 200,
                child: ShadInput(
                  placeholder: Text('Search'),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(),
                    child: ShadTable.list(
                      header: const [
                        ShadTableCell.header(child: Text('Knowledge')),
                        ShadTableCell.header(child: Text('Units')),
                        ShadTableCell.header(child: Text('Size')),
                        ShadTableCell.header(
                          child: Text('Edit time'),
                        ),
                        ShadTableCell.header(
                          child: Text('Action'),
                        )
                      ],
                      children: knowledges.map(
                        (knowledge) => [
                          ShadTableCell(
                            child: Text(
                              knowledge.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          ShadTableCell(child: Text(knowledge.units)),
                          ShadTableCell(
                            child: Text(
                              knowledge.size,
                            ),
                          ),
                          ShadTableCell(child: Text(knowledge.editTime)),
                          ShadTableCell(
                            child: FIcon(
                              FAssets.icons.trash,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
