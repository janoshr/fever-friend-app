import 'package:fever_friend_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class IHomeScreen extends StatefulWidget {
  const IHomeScreen({Key? key}) : super(key: key);

  @override
  _IHomeScreenState createState() => _IHomeScreenState();
}

class _IHomeScreenState extends State<IHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CS310 Fever Friend App'),
      ),
      drawer: const DrawerMenu(),
      body: Column(children: const [
        Icon(Icons.abc_outlined),
      ]),
    );
  }
}
