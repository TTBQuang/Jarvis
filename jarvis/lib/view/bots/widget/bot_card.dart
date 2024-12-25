import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/model/bot.dart';
import 'package:jarvis/view/bots/bot_detail_screen.dart';
import 'package:jarvis/view/bots/widget/edit_bot_dialog.dart';
import 'package:jarvis/view_model/bot_view_model.dart';
import 'package:provider/provider.dart';

class BotCard extends StatelessWidget {
  const BotCard({super.key, required this.bot});

  final BotData bot;

  @override
  Widget build(BuildContext context) {
    final botViewModel = Provider.of<BotViewModel>(context);

    return GestureDetector(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 100),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue[50]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: FIcon(FAssets.icons.bot),
          ),
          title: Text(
            bot.assistantName,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Row(
            children: [
              const Icon(Icons.access_time, size: 16),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  bot.createdAt.split('T')[0],
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.star_border),
                onPressed: () {
                  // Handle favorite action
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => showAdaptiveDialog(
                  context: context,
                  builder: (context) => EditBotDialog(
                    bot: bot,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  botViewModel.deleteBot(assistantId: bot.id);
                },
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        botViewModel.selecteBot(bot: bot);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => BotDetailScreen(bot: bot),
          ),
        );
      },
    );
  }
}
