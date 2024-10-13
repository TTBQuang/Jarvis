import 'package:flutter/material.dart';
import 'package:jarvis/view/prompt_library/widget/public_prompt_item.dart';

class PublicPromptTab extends StatefulWidget {
  const PublicPromptTab({super.key});

  @override
  State<StatefulWidget> createState() => _PublicPromptTabState();
}

class _PublicPromptTabState extends State<PublicPromptTab> {
  bool isFavored = false;
  final List<String> items = [
    'Item 1 Item 3 Item 3 Item 3 Item 3 Item 3',
    'Item 2',
    'Item 3 Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 1 Item 3 Item 3',
    'Item 8',
    'Item 9',
    'Item 4 Item 3',
    'Item 4 Item 3 Item 3 Item 3 Item 3 Item 3 Item 3',
    'Item 2 Item 3 Item 3 Item 3 Item 3 Item 3 Item 3',
    'Item 1 Item 3 Item 3 Item 3 Item 3',
    'Item 7',
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search prompts...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isFavored = !isFavored;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    isFavored ? Icons.star : Icons.star_border,
                    color: isFavored ? const Color(0xFFFFD700) : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 10),
              child: Text(
                'Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: IntrinsicWidth(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF303f52)
                        : const Color(0xFFdce3f3),
                    child: DropdownButton<String>(
                      value: items[selectedIndex],
                      borderRadius: BorderRadius.circular(8),
                      isExpanded: true,
                      underline: Container(),
                      dropdownColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF303f52)
                              : const Color(0xFFdce3f3),
                      menuMaxHeight: 600,
                      items: items.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(item),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedIndex = items.indexOf(newValue ?? items[0]);
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return const PublicPromptItem();
            },
          ),
        ),
      ],
    );
  }
}
