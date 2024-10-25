import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class QuickReplyChips extends StatelessWidget {
  const QuickReplyChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0, // gap between lines
      children: <Widget>[
        Chip(
          avatar: FIcon(FAssets.icons.heartHandshake),
          label: const Text('Thanks'),
        ),
        Chip(
          avatar: FIcon(FAssets.icons.frown),
          label: const Text('Sorry'),
        ),
        Chip(
          label: const Text('Yes'),
        ),
        Chip(
          label: const Text('No'),
        ),
        Chip(
          avatar: FIcon(FAssets.icons.calendar),
          label: const Text('Follow up'),
        ),
        Chip(
          avatar: FIcon(FAssets.icons.sparkle),
          label: const Text('Request for more infomation'),
        ),
      ],
    );
  }
}
