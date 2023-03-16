import 'package:fever_friend_app/screens/screen_definition.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class ISplashScreen extends StatelessWidget {
  const ISplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Column(
              children: [
                Text(
                  loc.homeTitle,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.teal),
                ),
                Text(
                  'App for Fever management',
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
            const Spacer(),
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
                          Navigator.pushNamed(
                              context, ScreenDefinition.register);
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
      ),
    );
  }
}
