import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/model/bot.dart';
import 'package:jarvis/view_model/bot_view_model.dart';
import 'package:provider/provider.dart';

class SettingPublishDialog extends StatefulWidget {
  const SettingPublishDialog(
      {super.key, required this.bot, required this.platform});

  final BotData bot;
  final Map<String, dynamic> platform;

  @override
  State<SettingPublishDialog> createState() => _SettingPublishDialogState();
}

class _SettingPublishDialogState extends State<SettingPublishDialog> {
  @override
  Widget build(BuildContext context) {
    final botViewModel = Provider.of<BotViewModel>(context);

    Map<String, TextEditingController> informationController = {};

    for (var information in widget.platform['information']) {
      informationController[information] = TextEditingController();
    }

    return SingleChildScrollView(
      child: FDialog(
        direction: Axis.horizontal,
        title: Text('Configure ${widget.platform['name']} Bot'),
        body: SizedBox(
          height: 300,
          width: 300,
          child: Material(
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.grey[800]
                                  : Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: const Center(child: Text('1'))),
                        Text('${widget.platform['name']} copylink')
                      ],
                    ),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: ListView(
                        children: widget.platform['copylink']
                            .map<Widget>((copylink) => ListTile(
                                  title: Text(copylink['name'] as String),
                                  subtitle: copylink['link'] == 'knowledge'
                                      ? SelectableText(
                                          copylink['link'] as String)
                                      : SelectableText(
                                          (copylink['link'] as String) +
                                              widget.bot.id),
                                ))
                            .toList(),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.grey[800]
                                  : Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: const Center(child: Text('2'))),
                        Text('${widget.platform['name']} information')
                      ],
                    ),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: ListView(
                        children: widget.platform['information']
                            .map<Widget>((information) => ListTile(
                                  title: Text(information as String),
                                  subtitle: TextField(
                                    controller:
                                        informationController[information],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {
              Map<String, String> data = {};
              informationController.forEach((key, value) {
                data[key] = value.text;
              });
              if (widget.platform['name'] == 'Slack') {
                botViewModel.publishSlackBot(
                    assistantId: widget.bot.id, data: data);
              } else if (widget.platform['name'] == 'Telegram') {
                botViewModel.publishTelegramBot(
                    assistantId: widget.bot.id, data: data);
              } else if (widget.platform['name'] == 'Messenger') {
                botViewModel.publishMessengerBot(
                    assistantId: widget.bot.id, data: data);
              }
              Navigator.of(context).pop();
            },
            child: const Text(
              'Publish',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
