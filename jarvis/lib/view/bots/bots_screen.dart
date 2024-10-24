import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/model/bot.dart';
import 'package:jarvis/view/bots/widget/bot_card.dart';
import 'package:jarvis/view/bots/widget/create_bot_dialog.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

List<Bot> bots = [
  Bot(
    name: "INV001",
    createdAt: "10/22/2024",
    isFavorite: true,
  ),
  Bot(
    name: "INV004",
    createdAt: "10/22/2024",
    isFavorite: false,
  ),
  Bot(
    name: "INV005",
    createdAt: "10/22/2024",
    isFavorite: false,
  ),
];

final botTypes = {
  'all': 'All',
  'published': 'Published',
  'myFavorite': 'My Favorite',
};

class BotsScreen extends StatelessWidget {
  const BotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 180),
                        child: ShadSelect<String>(
                          placeholder: const Text('Select a type'),
                          initialValue: 'all',
                          options: botTypes.entries.map((e) =>
                              ShadOption(value: e.key, child: Text(e.value))),
                          selectedOptionBuilder: (context, value) =>
                              Text(botTypes[value]!),
                          onChanged: print,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: SizedBox(
                        width: 200,
                        child: ShadInput(
                          placeholder: Text('Search'),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    child: FButton(
                      label: const Text('Create Bot'),
                      onPress: () => showAdaptiveDialog(
                        context: context,
                        builder: (context) => CreateBotDialog(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: GridView.count(
                  crossAxisCount: MediaQuery.sizeOf(context).width >
                          drawerDisplayWidthThreshold
                      ? 2
                      : 1,
                  children: List.generate(
                      bots.length, (index) => BotCard(bot: bots[index])),
                  padding: const EdgeInsets.all(8.0),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 3 / 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
