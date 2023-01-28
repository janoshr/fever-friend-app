import 'package:fever_friend_app/models/models.dart';
import 'package:fever_friend_app/models/notification.dart';
import 'package:fever_friend_app/screens/screen_definition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui/layout/drawer_menu.dart';
import '../ui/widgets/illness_card.dart';

// TODO remove dummy data
final illness = Illness(id: 'asdf', feverMeasurements: [
  MeasurementModel(
    id: 'num1',
    data: MeasurementModelData(
      feverSection: FeverSectionModel(
        temperature: 37.8,
      ),
      patientState: PatientState.good,
    ),
    meta: MeasurementModelMeta(
      createdAt: DateTime.now(),
      numberOfQuestions: 3,
    ),
  ),
  MeasurementModel(
    id: 'num1',
    data: MeasurementModelData(
      feverSection: FeverSectionModel(
        temperature: 37.8,
      ),
      patientState: PatientState.danger,
    ),
    meta: MeasurementModelMeta(
      createdAt: DateTime.now(),
      numberOfQuestions: 3,
    ),
  ),
  MeasurementModel(
    id: 'num1',
    data: MeasurementModelData(
      feverSection: FeverSectionModel(
        temperature: 37.8,
      ),
      patientState: PatientState.caution,
    ),
    meta: MeasurementModelMeta(
      createdAt: DateTime.now(),
      numberOfQuestions: 3,
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
