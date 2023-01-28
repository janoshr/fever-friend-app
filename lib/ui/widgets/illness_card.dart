import 'package:fever_friend_app/ui/widgets/pulse_icon.dart';
import 'package:flutter/material.dart';
import 'package:fever_friend_app/ui/shared/utils.dart';

import '../../models/illness.dart';
import '../shared/constants.dart';

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
    final temperatureString =
        illness.feverMeasurements.first.data.feverSection?.temperature?.toStringAsFixed(1);

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
                dateFMMMDDHmm
                    .format(illness.feverMeasurements.last.meta.createdAt),
              ),
              leading: IPulseIcon(
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
