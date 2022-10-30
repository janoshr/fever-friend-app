import 'package:fever_friend_app/screens/screen_definition.dart';
import 'package:flutter/material.dart';

class ISplashScreen extends StatelessWidget {
  const ISplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('CS310 Fever Friend App'),
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
                      child: const Text('Sign in'),
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
                      child: const Text('Sign up'),
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
