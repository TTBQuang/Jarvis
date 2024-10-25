import 'package:flutter/material.dart';

class SendPromptBottomSheet extends StatefulWidget {
  const SendPromptBottomSheet({super.key});

  @override
  State<StatefulWidget> createState() => _SendPromptBottomSheetState();
}

class _SendPromptBottomSheetState extends State<SendPromptBottomSheet> {
  final List<Map<String, String>> languages = [
    {'name': 'English', 'description': 'English language'},
    {'name': 'Vietnamese', 'description': 'Ngôn ngữ Việt Nam'},
    {'name': 'French', 'description': 'Langue française'},
    {'name': 'Spanish', 'description': 'Idioma español'},
  ];

  int selectedLanguageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Name of Prompt',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Prompt',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                enabled: false,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Prompt content',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Output Language',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    fit: FlexFit.loose,
                    child: IntrinsicWidth(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF303f52)
                              : const Color(0xFFdce3f3),
                          child: DropdownButton<int>(
                            borderRadius: BorderRadius.circular(8),
                            isExpanded: true,
                            value: selectedLanguageIndex,
                            underline: Container(),
                            dropdownColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xFF303f52)
                                    : const Color(0xFFdce3f3),
                            menuMaxHeight: 300,
                            items: List.generate(languages.length, (index) {
                              return DropdownMenuItem<int>(
                                value: index,
                                child: _buildDropdownItem(languages[index]),
                              );
                            }),
                            selectedItemBuilder: (BuildContext context) {
                              return List.generate(languages.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Center(
                                    child: Text(languages[index]['name'] ?? ''),
                                  ),
                                );
                              });
                            },
                            onChanged: (int? newIndex) {
                              setState(() {
                                selectedLanguageIndex = newIndex ?? 0;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'TOPIC',
                  hintMaxLines: 4,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4b85e9),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Send',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownItem(Map<String, String> lang) {
    return RichText(
      softWrap: false,
      text: TextSpan(
        children: [
          TextSpan(
            text: lang['name'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),

          TextSpan(
            text: '\n${lang['description']}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
