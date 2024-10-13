import 'package:flutter/material.dart';
import 'package:jarvis/view/prompt_library/widget/send_prompt_bottom_sheet.dart';

import '../../../constant.dart';

class PublicPromptItem extends StatefulWidget {
  const PublicPromptItem({super.key});

  @override
  State<StatefulWidget> createState() => _PublicPromptItemState();
}

class _PublicPromptItemState extends State<PublicPromptItem> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => _onItemTapped(context),
          title: const Text(
            'Public prompt',
            style: TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: toggleFavorite,
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? const Color(0xFFFFD700) : null,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const Divider(),
      ],
    );
  }

  void _onItemTapped(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height *
                maxBottomSheetHeightPercentage,
          ),
          child: SendPromptBottomSheet(),
        );
      },
    );
  }
}
