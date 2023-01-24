import 'package:fever_friend_app/models/illness.dart';
import 'package:fever_friend_app/models/models.dart';
import 'package:fever_friend_app/screens/screen_definition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fever_friend_app/ui/shared/constants.dart' as Constants;

import '../ui/layout/drawer_menu.dart';
import '../ui/shared/constants.dart';
import '../ui/widgets/pulse_icon.dart';

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CS310 Fever Friend App'),
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

class IllnessCard extends StatelessWidget {
  final Illness illness;
  const IllnessCard({
    Key? key,
    required this.illness,
  }) : super(key: key);

  void handleTap() {
    debugPrint('Tapped');
    // TODO navigate to illness
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('MMM d, hh:mm');

    final temperatureString =
        illness.feverMeasurements.first.data.temperature?.toStringAsFixed(1);

    return Card(
      elevation: 3,
      child: InkWell(
        onTap: handleTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text(
                'Ongoing Illness',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                formatter.format(illness.feverMeasurements.last.meta.createdAt),
              ),
              leading: PulsingIcon(
                stateColor: stateToColor(
                    illness.feverMeasurements.first.data.patientState!),
              ),
            ),
            ListTile(
              title: Text(
                  temperatureString != null ? '$temperatureString °C' : 'n/a'),
              leading: const Icon(Icons.thermostat),
            ),
            ListTile(
              title: Text(
                  'Number of measurements: ${illness.feverMeasurements.length}'),
              leading: const Icon(Icons.numbers),
            )
          ],
        ),
      ),
    );
  }
}

