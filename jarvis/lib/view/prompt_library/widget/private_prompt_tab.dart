import 'package:flutter/material.dart';
import 'package:jarvis/view/prompt_library/widget/private_prompt_item.dart';

class PrivatePromptTab extends StatelessWidget {
  const PrivatePromptTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'Search prompts...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const PrivatePromptItem();
            },
          ),
        ),
      ],
    );
  }
}
