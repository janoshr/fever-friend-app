import 'package:fever_friend_app/models/models.dart';
import 'package:fever_friend_app/models/notification.dart';
import 'package:fever_friend_app/screens/screen_definition.dart';
import 'package:fever_friend_app/services/illness_provider.dart';
import 'package:fever_friend_app/services/patient_provider.dart';
import 'package:fever_friend_app/widgets/illness_list.dart';
import 'package:fever_friend_app/widgets/speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../layout/drawer_menu.dart';
import '../widgets/illness_card.dart';

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
    final illnessProvider = Provider.of<IllnessProvider>(context);

    final loc = AppLocalizations.of(context);
    List<Illness> illnessList = illnessProvider.illnessList;
    bool activeIllness = illnessList.isNotEmpty && illnessList.first.isActive;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(loc!.homeTitle),
        actions: <Widget>[
          Badge(
            // label: Text(notis.length.toString()),
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
      body: illnessList.isEmpty
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Column(
                    children: [
                      const Icon(Icons.info_outline),
                      Text(loc.emptyMeasurements)
                    ],
                  ),
                ),
              ),
            )
          : SafeArea(
              child: Column(children: [
                if (activeIllness)
                  IllnessCard(
                    illness: illnessList.first,
                  ),
                Expanded(
                  child: IllnessList(
                    illnessList: activeIllness
                        ? illnessList.skip(1).toList()
                        : illnessList,
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
                        arguments: illnessList.first);
                  },
                  label: Text(loc.measure),
                  icon: const Icon(Icons.thermostat),
                ),
                FloatingActionButton.extended(
                  heroTag: UniqueKey(),
                  onPressed: () {
                    // TODO close illness
                  },
                  label: Text(loc.healed),
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
              label: Text(loc.measure),
              icon: const Icon(Icons.thermostat),
            ),
    );
  }
}
