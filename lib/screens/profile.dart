import 'package:fever_friend_app/screens/screen_definition.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class IProfileScreen extends StatelessWidget {
  const IProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      actions: [
        SignedOutAction(((context) {
          Navigator.of(context).pushReplacementNamed(ScreenDefinition.splash);
        }))
      ],
    );
  }
}
