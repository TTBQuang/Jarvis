import 'package:flutter/material.dart';

import '../../../model/language.dart';
import '../../../model/prompt.dart';

class SendPromptBottomSheet extends StatefulWidget {
  final Prompt prompt;

  const SendPromptBottomSheet({super.key, required this.prompt});

  @override
  State<StatefulWidget> createState() => _SendPromptBottomSheetState();
}

class _SendPromptBottomSheetState extends State<SendPromptBottomSheet> {
  Language selectedLanguage = Language.auto;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    contentController = TextEditingController(text: widget.prompt.content);
    selectedLanguage = widget.prompt.language;
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

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
                  Text(
                    widget.prompt.title,
                    style: const TextStyle(
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
              Text(
                '${widget.prompt.category.displayName} - ${widget.prompt.userName}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                widget.prompt.description,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              const Text(
                'Prompt',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: contentController,
                maxLines: null,
                decoration: InputDecoration(
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          child: DropdownButton<Language>(
                            borderRadius: BorderRadius.circular(8),
                            isExpanded: true,
                            value: selectedLanguage,
                            underline: Container(),
                            dropdownColor: Theme.of(context).brightness == Brightness.dark
                                ? const Color(0xFF303f52)
                                : const Color(0xFFdce3f3),
                            menuMaxHeight: 300,
                            items: Language.values.map((Language language) {
                              return DropdownMenuItem<Language>(
                                value: language,
                                child: _buildDropdownItem(language),
                              );
                            }).toList(),
                            selectedItemBuilder: (BuildContext context) {
                              return Language.values.map((Language language) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Center(
                                    child: Text(language.englishName),
                                  ),
                                );
                              }).toList();
                            },
                            onChanged: (Language? newLanguage) {
                              setState(() {
                                selectedLanguage = newLanguage ?? Language.english;
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

  Widget _buildDropdownItem(Language language) {
    return RichText(
      softWrap: false,
      text: TextSpan(
        children: [
          TextSpan(
            text: language.englishName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          TextSpan(
            text: '\n${language.nativeName}',
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
