import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/view/bots/widget/bot_card.dart';
import 'package:jarvis/view/bots/widget/create_bot_dialog.dart';
import 'package:jarvis/view_model/bot_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final botTypes = {
  'all': 'All',
  'published': 'Published',
  'myFavorite': 'My Favorite',
};

class BotsScreen extends StatefulWidget {
  const BotsScreen({super.key});

  @override
  State<BotsScreen> createState() => _BotsScreenState();
}

class _BotsScreenState extends State<BotsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final botViewModel = context.read<BotViewModel>();
      botViewModel.getBots();
    });
  }

  String type = 'all';
  String query = '';

  @override
  Widget build(BuildContext context) {
    final botViewModel = Provider.of<BotViewModel>(context);
    final bots = botViewModel.bots;

    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > drawerDisplayWidthThreshold;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flex(
              direction: isLargeScreen ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: isLargeScreen
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Flex(
                  direction: isLargeScreen ? Axis.horizontal : Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 180),
                        child: ShadSelect<String>(
                          placeholder: const Text('Select a type'),
                          initialValue: 'all',
                          options: botTypes.entries.map((e) =>
                              ShadOption(value: e.key, child: Text(e.value))),
                          selectedOptionBuilder: (context, value) =>
                              Text(botTypes[value]!),
                          onChanged: (value) => {
                            setState(() {
                              type = value;
                            }),
                            botViewModel.getBots(
                              isPublished: type == 'published',
                              isFavorite: type == 'myFavorite',
                              q: query,
                            )
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: SizedBox(
                        width: 200,
                        child: FTextField(
                          hint: 'Search',
                          maxLines: 1,
                          initialValue: query,
                          onChange: (value) => {
                            setState(() {
                              query = value;
                            }),
                            botViewModel.getBots(
                              q: value,
                              isFavorite: type == 'myFavorite',
                              isPublished: type == 'published',
                            )
                          },
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
                        builder: (context) => const CreateBotDialog(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: botViewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: GridView.count(
                        crossAxisCount: MediaQuery.sizeOf(context).width >
                                drawerDisplayWidthThreshold
                            ? 2
                            : 1,
                        padding: const EdgeInsets.all(8.0),
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 3 / 1,
                        children: List.generate(
                            bots.length, (index) => BotCard(bot: bots[index])),
                      ),
                    ),
            ),
          ],
        );
      }),
    );
  }
}
