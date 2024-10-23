import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/model/bot.dart';

class BotCard extends StatelessWidget {
  const BotCard({super.key, required this.bot});

  final Bot bot;

  @override
  Widget build(BuildContext context) {
    return FCard(
      child: ListTile(
        leading: CircleAvatar(
          child: FIcon(FAssets.icons.bot),
        ),
        title: Text(bot.name),
        subtitle: Row(
          children: [
            Icon(Icons.access_time, size: 16),
            SizedBox(width: 5),
            Text(bot.createdAt),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.star_border),
              onPressed: () {
                // Handle favorite action
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Handle delete action
              },
            ),
          ],
        ),
      ),
    );
  }
}
