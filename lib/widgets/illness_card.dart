import 'package:fever_friend_app/l10n/app_localizations.dart';
import 'package:fever_friend_app/screens/illness.dart';
import 'package:fever_friend_app/widgets/pulse_icon.dart';
import 'package:flutter/material.dart';
import 'package:fever_friend_app/shared/utils.dart';

import '../models/illness.dart';
import '../shared/constants.dart';

class IllnessCard extends StatelessWidget {
  final Illness illness;
  const IllnessCard({
    Key? key,
    required this.illness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final temperatureString = illness
        .feverMeasurements.first.data.feverSection.temperature
        .toStringAsFixed(1);
    final loc = AppLocalizations.of(context)!;

    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => IllnessScreen(illness: illness)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                loc.ongoingIllness,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                dateFMMMDDHmm
                    .format(illness.feverMeasurements.last.meta.createdAt),
              ),
              leading: IPulseIcon(
                stateColor: stateToColor(
                    illness.feverMeasurements.first.state?.patientState),
              ),
            ),
            ListTile(
              subtitle: Text(loc.temperature),
              title: Text('$temperatureString °C'),
              leading: const Icon(Icons.thermostat),
            ),
            ListTile(
              subtitle: Text(loc.measurements),
              leading: const Icon(Icons.numbers),
              title: Row(
                  children: illness.feverMeasurements.map((m) {
                return Icon(
                  Icons.circle,
                  size: 16,
                  color: stateToColor(m.state?.patientState),
                );
              }).toList()),
            )
          ],
        ),
      ),
    );
  }
}
