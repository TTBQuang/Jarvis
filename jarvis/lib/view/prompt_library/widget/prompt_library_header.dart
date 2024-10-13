import 'package:flutter/material.dart';

import '../../../constant.dart';
import 'new_prompt_bottom_sheet.dart';

class PromptLibraryHeader extends StatelessWidget {
  const PromptLibraryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Prompt Library',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF4b85e9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                onPressed: () {
                  _showNewPromptBottomSheet(context);
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ],
    );
  }

  void _showNewPromptBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * maxBottomSheetHeightPercentage,
          ),
          child: const NewPromptBottomSheet(),
        );
      },
    );
  }

}
