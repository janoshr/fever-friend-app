import 'package:fever_friend_app/models/models.dart';
import 'package:fever_friend_app/models/notification.dart';
import 'package:fever_friend_app/screens/screen_definition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui/layout/drawer_menu.dart';
import '../ui/widgets/illness_card.dart';

// TODO remove dummy data
final illness = Illness(id: 'asdf', feverMeasurements: [
  FeverMeasurement(
    id: 'num1',
    data: FeverMeasurementData(
      patientState: 'good',
      temperature: 37.8,
    ),
    meta: FeverMeasurementMeta(
      createdAt: DateTime.now(),
      numberOfQuestions: 3,
    ),
  ),
  FeverMeasurement(
    id: 'num2',
    data: FeverMeasurementData(
      patientState: 'caution',
      temperature: 39.0,
    ),
    meta: FeverMeasurementMeta(
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      numberOfQuestions: 5,
    ),
  ),
  FeverMeasurement(
    id: 'num3',
    data: FeverMeasurementData(
      patientState: 'good',
      temperature: 37.3,
    ),
    meta: FeverMeasurementMeta(
      createdAt: DateTime.now(),
      numberOfQuestions: 6,
    ),
  ),
]);

class IHomeScreen extends StatefulWidget {
  const IHomeScreen({Key? key}) : super(key: key);

  @override
  _IHomeScreenState createState() => _IHomeScreenState();
}

class _IHomeScreenState extends State<IHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final notis = Provider.of<List<INotification>>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CS310 Fever Friend App'),
        actions: <Widget>[
          Badge(
            label: Text(notis.length.toString()),
            alignment: AlignmentDirectional.topEnd,
            child: IconButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(ScreenDefinition.notification),
              icon: const Icon(Icons.notifications),
            ),
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      body: SafeArea(
        child: Column(children: [
          IllnessCard(
            illness: illness,
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ScreenDefinition.createMeasurement);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
