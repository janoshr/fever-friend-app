import 'package:fever_friend_app/screens/screen_definition.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class ISplashScreen extends StatelessWidget {
  const ISplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Text(
              loc.homeTitle,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const Icon(
            Icons.abc,
            size: 120.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: OutlinedButton(
                      onPressed: (() {
                        Navigator.pushNamed(context, ScreenDefinition.login);
                      }),
                      child: Text(loc.signIn),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: (() {
                        Navigator.pushNamed(context, ScreenDefinition.register);
                      }),
                      child: Text(loc.signUp),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
