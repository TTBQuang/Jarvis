import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/model/bot.dart';
import 'package:jarvis/view/bots/bot_detail_screen.dart';

class BotCard extends StatelessWidget {
  const BotCard({super.key, required this.bot});

  final Bot bot;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 20),
        child: FCard(
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
        ),
      ),
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => BotDetailScreen(bot: bot),
          ),
        );
      },
    );
  }
}
