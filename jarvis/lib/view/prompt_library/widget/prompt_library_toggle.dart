import 'package:flutter/material.dart';

import '../prompt_library_bottom_sheet.dart';

class PromptToggle extends StatelessWidget {
  final PromptType currentType;
  final Function(PromptType) onToggle;

  const PromptToggle({
    super.key,
    required this.currentType,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    const selectedColor = Color(0xFF4b85e9);
    final unselectedColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF014493)
        : const Color(0xffbcc6e8);

    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: unselectedColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onToggle(PromptType.private),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: currentType == PromptType.private
                          ? selectedColor
                          : unselectedColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Private Prompts",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: GestureDetector(
                  onTap: () => onToggle(PromptType.public),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: currentType == PromptType.public
                          ? selectedColor
                          : unselectedColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Public Prompts",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
