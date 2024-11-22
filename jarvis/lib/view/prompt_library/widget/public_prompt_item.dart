import 'package:flutter/material.dart';
import 'package:jarvis/view/prompt_library/widget/send_prompt_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../model/prompt.dart';
import '../../../view_model/prompt_view_model.dart';

class PublicPromptItem extends StatefulWidget {
  final Prompt prompt;

  const PublicPromptItem({super.key, required this.prompt});

  @override
  State<StatefulWidget> createState() => _PublicPromptItemState();
}

class _PublicPromptItemState extends State<PublicPromptItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => _onItemTapped(context),
          title: Text(
            widget.prompt.title,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            widget.prompt.description,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: toggleFavorite,
            icon: Icon(
              widget.prompt.isFavorite ? Icons.star : Icons.star_border,
              color: widget.prompt.isFavorite ? const Color(0xFFFFD700) : null,
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

  void toggleFavorite() {
    final promptViewModel = context.read<PromptViewModel>();

    if (widget.prompt.isFavorite) {
      promptViewModel.removePromptFromFavorites(promptId: widget.prompt.id);
    } else {
      promptViewModel.addPromptToFavorites(promptId: widget.prompt.id);
    }

    setState(() {
      widget.prompt.isFavorite = !widget.prompt.isFavorite;
    });
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
          child: SendPromptBottomSheet(prompt: widget.prompt),
        );
      },
    );
  }
}
