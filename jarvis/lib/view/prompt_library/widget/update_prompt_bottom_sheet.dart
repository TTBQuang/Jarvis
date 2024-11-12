import 'package:flutter/material.dart';
import 'package:jarvis/model/prompt.dart';

import '../../../model/category.dart';
import '../../../model/language.dart';

class UpdatePromptBottomSheet extends StatefulWidget {
  final Function(Prompt) onSave;
  final Prompt prompt;

  const UpdatePromptBottomSheet({
    super.key,
    required this.prompt,
    required this.onSave,
  });

  @override
  State<StatefulWidget> createState() => _UpdatePromptBottomSheetState();
}

class _UpdatePromptBottomSheetState extends State<UpdatePromptBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController promptController = TextEditingController();
  late TextEditingController descriptionController;
  Category selectedCategory = Category.all;
  Language selectedLanguage = Language.auto;

  @override
  void initState() {
    super.initState();

    nameController.text = widget.prompt.title;
    promptController.text = widget.prompt.content;
    descriptionController =
        TextEditingController(text: widget.prompt.description);
    selectedCategory = widget.prompt.category;
    selectedLanguage = widget.prompt.language;
  }

  @override
  void dispose() {
    nameController.dispose();
    promptController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Push the content in the bottom sheet up when the keyboard appears
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
                    'Update Prompt',
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
              // Language section
              const Text(
                'Output language',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF303f52)
                      : const Color(0xFFdce3f3),
                  child: DropdownButton<Language>(
                    value: selectedLanguage,
                    borderRadius: BorderRadius.circular(8),
                    isExpanded: true,
                    underline: Container(),
                    dropdownColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF303f52)
                            : const Color(0xFFdce3f3),
                    menuMaxHeight: 600,
                    items: Language.values.map((Language language) {
                      return DropdownMenuItem<Language>(
                        value: language,
                        child: RichText(
                          softWrap: false,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: language.englishName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
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
                        ),
                      );
                    }).toList(),
                    selectedItemBuilder: (BuildContext context) {
                      return Language.values.map((Language language) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              language.englishName,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }).toList();
                    },
                    onChanged: (Language? newLanguage) {
                      setState(() {
                        selectedLanguage = newLanguage ?? Language.auto;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Name section
              const Text(
                'Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Name of the prompt',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Category section
              const Text(
                'Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF303f52)
                      : const Color(0xFFdce3f3),
                  child: DropdownButton<Category>(
                    value: selectedCategory,
                    borderRadius: BorderRadius.circular(8),
                    isExpanded: true,
                    underline: Container(),
                    dropdownColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF303f52)
                            : const Color(0xFFdce3f3),
                    menuMaxHeight: 600,
                    items: Category.values.map((Category category) {
                      return DropdownMenuItem<Category>(
                        value: category,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            category.displayName,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (Category? newCategory) {
                      setState(() {
                        selectedCategory = newCategory ?? Category.all;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Description section
              const Text(
                'Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText:
                      'Describe your prompt so others can have a better understanding.',
                  hintMaxLines: 4,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Prompt section
              const Text(
                'Prompt',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(8),
                child: const Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Use square brackets [ ] to specify user input.',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: promptController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText:
                      'e.g: Write an article about [topic], make sure to include this keyword: [keyword]',
                  hintMaxLines: 4,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Button section
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      widget.onSave(
                        widget.prompt.copyWith(
                          title: nameController.text,
                          description: descriptionController.text,
                          category: selectedCategory,
                          language: selectedLanguage,
                          content: promptController.text,
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4b85e9),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
