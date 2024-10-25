import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/view/knowledge/knowledge_detail_screen.dart';
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
      child: LayoutBuilder(builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > drawerDisplayWidthThreshold;
        return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flex(
              direction: isLargeScreen ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: isLargeScreen
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                    width: 200,
                    child: FTextField(
                      hint: 'Search',
                      maxLines: 1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 250,
                    child: FButton(
                      label: const Text('Create Knowledge'),
                      onPress: () => showAdaptiveDialog(
                        context: context,
                        builder: (context) => const CreateKnowledgeDialog(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    onRowTap: (index) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const KnowledgeDetailScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
