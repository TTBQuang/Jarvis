import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/model/bot.dart';
import 'package:jarvis/view/bots/widget/setting_publish_dialog.dart';
import 'package:jarvis/view_model/bot_view_model.dart';
import 'package:provider/provider.dart';

const platforms = [
  {
    'name': 'Slack',
    'copylink': [
      {
        'name': 'OAuth2 Redirect URLs',
        'link': baseUrlKb + '/kb-core/v1/bot-integration/slack/auth/'
      },
      {
        'name': 'Event Request URL',
        'link': baseUrlKb + '/kb-core/v1/hook/slack/'
      },
      {
        'name': 'Slash Request URL',
        'link': baseUrlKb + '/kb-core/v1/hook/slack/slash/'
      }
    ],
    'information': ['Token', 'Client ID', 'Client Secret', 'Signing Secret'],
  },
  {
    'name': 'Telegram',
    'information': ['Token'],
    'copylink': [],
  },
  {
    'name': 'Messenger',
    'copylink': [
      {
        'name': 'Callback URL',
        'link': baseUrlKb + '/kb-core/v1/hook/messenger/'
      },
      {'name': 'Verify Token', 'link': 'knowledge'}
    ],
    'information': [
      'Messenger Bot Token',
      'Messenger Bot Page ID',
      'Messenger Bot App Secret'
    ],
  },
];

class PublishDialog extends StatefulWidget {
  const PublishDialog({super.key, required this.bot});

  final BotData bot;

  @override
  State<PublishDialog> createState() => _PublishDialogState();
}

class _PublishDialogState extends State<PublishDialog> {
  @override
  Widget build(BuildContext context) {
    final botViewModel = Provider.of<BotViewModel>(context);

    return SingleChildScrollView(
      child: FDialog(
        direction: Axis.horizontal,
        title: const Text('Publishing platform'),
        body: SizedBox(
          height: 200,
          width: double.maxFinite,
          child: Material(
            child: ListView(
              children: platforms
                  .map((platform) => ListTile(
                        title: Text(platform['name'] as String),
                        trailing: IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () => showAdaptiveDialog(
                            context: context,
                            builder: (context) => SettingPublishDialog(
                              bot: widget.bot,
                              platform: platform,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
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
        ],
      ),
    );
  }
}
