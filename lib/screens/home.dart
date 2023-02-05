import 'package:fever_friend_app/models/models.dart';
import 'package:fever_friend_app/models/notification.dart';
import 'package:fever_friend_app/screens/screen_definition.dart';
import 'package:fever_friend_app/services/firestore.dart';
import 'package:fever_friend_app/services/patient_provider.dart';
import 'package:fever_friend_app/ui/widgets/illness_list.dart';
import 'package:fever_friend_app/ui/widgets/speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/get_it.dart';
import '../ui/layout/drawer_menu.dart';
import '../ui/widgets/illness_card.dart';

class IHomeScreen extends StatefulWidget {
  const IHomeScreen({Key? key}) : super(key: key);

  @override
  _IHomeScreenState createState() => _IHomeScreenState();
}

class _IHomeScreenState extends State<IHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final notis = Provider.of<List<INotification>>(context);
    final patient = Provider.of<PatientProvider>(context).patient;

    return Consumer<List<Illness>>(builder: (context, illnesses, _) {
      bool activeIllness = illnesses.isNotEmpty && illnesses.first.isActive;

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
        body: illnesses.isEmpty
            ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: Column(
                      children: const [
                        Icon(Icons.info_outline),
                        Text('No measurements to display')
                      ],
                    ),
                  ),
                ),
              )
            : SafeArea(
                child: Column(children: [
                  if (activeIllness)
                    IllnessCard(
                      illness: illnesses.first,
                    ),
                  Expanded(
                    child: IllnessList(
                      illnessList: activeIllness
                          ? illnesses.skip(1).toList()
                          : illnesses,
                    ),
                  ),
                ]),
              ),
        floatingActionButton: activeIllness
            ? SpeedDial(
                dials: <FloatingActionButton>[
                  FloatingActionButton.extended(
                    heroTag: UniqueKey(),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          ScreenDefinition.createMeasurement,
                          arguments: illnesses.first);
                    },
                    label: const Text('Measure'),
                    icon: const Icon(
                      Icons.thermostat,
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  FloatingActionButton.extended(
                    heroTag: UniqueKey(),
                    onPressed: () {
                      // TODO close illness
                    },
                    label: const Text('Healed'),
                    icon: const Icon(
                      Icons.healing,
                    ),
                    backgroundColor: Colors.green,
                  ),
                ],
              )
            : FloatingActionButton.extended(
                heroTag: UniqueKey(),
                onPressed: () {
                  Navigator.pushNamed(
                      context, ScreenDefinition.createMeasurement);
                },
                label: const Text('Measure'),
                icon: const Icon(Icons.thermostat),
              ),
      );
    });
  }
}
