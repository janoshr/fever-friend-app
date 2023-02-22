import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fever_friend_app/models/notification.dart';
import 'package:fever_friend_app/ui/shared/utils.dart';

import '../l10n/app_localizations.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc!.notifications),
        centerTitle: true,
      ),
      body: Consumer<List<INotification>>(
        builder: (context, value, child) {
          if (value.isEmpty) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Center(
                  child: Column(
                    children: [
                      const Icon(Icons.notifications_none),
                      Text(
                        loc.emptyNoti,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          final data = value;

          return SafeArea(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) => ListTile(
                title: Text(data[i].title),
                subtitle: Text(data[i].content),
                trailing: Text(
                  dateFMMMDDHmm.format(data[i].scheduledAt),
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
