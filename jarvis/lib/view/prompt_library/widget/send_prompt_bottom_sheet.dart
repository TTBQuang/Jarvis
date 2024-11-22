import 'package:flutter/material.dart';
import 'package:jarvis/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';

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
  final List<TextEditingController> placeholderControllers = [];
  late List<String> placeholders;

  @override
  void initState() {
    super.initState();
    contentController = TextEditingController(text: widget.prompt.content);
    selectedLanguage = widget.prompt.language;

    // Extract placeholders from the content
    placeholders = _extractPlaceholders(widget.prompt.content);

    // Initialize TextEditingController for each placeholder
    placeholderControllers.addAll(
      placeholders.map((_) => TextEditingController()),
    );
  }

  @override
  void dispose() {
    contentController.dispose();
    for (var controller in placeholderControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<String> _extractPlaceholders(String content) {
    final regex = RegExp(r'\[(.*?)\]');
    return regex.allMatches(content).map((match) => match.group(1)!).toList();
  }

  @override
  Widget build(BuildContext context) {
    final chatViewModel = Provider.of<ChatViewModel>(context, listen: false);

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
                            dropdownColor:
                                Theme.of(context).brightness == Brightness.dark
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
                                selectedLanguage =
                                    newLanguage ?? Language.english;
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
              ..._buildPlaceholderFields(),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Combine user input with placeholders
                    final filledPrompt = _generateFilledPrompt();
                    chatViewModel.sendMessage(
                      message: filledPrompt,
                    );
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  },
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

  List<Widget> _buildPlaceholderFields() {
    return List<Widget>.generate(
      placeholders.length,
      (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            controller: placeholderControllers[index],
            decoration: InputDecoration(
              labelText: placeholders[index],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
    );
  }

  String _generateFilledPrompt() {
    String content = widget.prompt.content;
    for (int i = 0; i < placeholders.length; i++) {
      content = content.replaceFirst(
        '[${placeholders[i]}]',
        placeholderControllers[i].text,
      );
    }
    return content;
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
