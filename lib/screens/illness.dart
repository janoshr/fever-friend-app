import 'package:fever_friend_app/models/fever_measurement.dart';
import 'package:fever_friend_app/screens/measurement/view_measurement.dart';
import 'package:fever_friend_app/shared/constants.dart';
import 'package:fever_friend_app/shared/utils.dart';
import 'package:fever_friend_app/widgets/line_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/illness.dart';

class IllnessScreen extends StatefulWidget {
  final Illness illness;

  const IllnessScreen({Key? key, required this.illness}) : super(key: key);

  @override
  State<IllnessScreen> createState() => _IllnessScreenState();
}

class _IllnessScreenState extends State<IllnessScreen> {
  late List<bool> expanded;

  @override
  void initState() {
    super.initState();
    expanded =
        List.generate(widget.illness.feverMeasurements.length, (_) => false);
  }

  ExpansionPanel buildPanel(MapEntry<int, MeasurementModel> entry) {
    final measurement = entry.value;
    final i = entry.key;

    final loc = AppLocalizations.of(context);
    final states = measurement.state;

    return ExpansionPanel(
      isExpanded: expanded[i],
      headerBuilder: (context, isExpanded) {
        return ListTile(
          leading: Icon(
            Icons.circle,
            color: stateToColor(measurement.state?.patientState),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateFMMMDDHmm.format(measurement.meta.createdAt)),
              Text(
                  '${measurement.data.feverSection.temperature.toStringAsFixed(1)} °C'),
            ],
          ),
          onTap: () {
            setState(() {
              expanded[i] = !isExpanded;
            });
          },
        );
      },
      body: Column(
        children: [
          ListTile(
            title: Text(loc!.sections),
            subtitle: Wrap(
              alignment: WrapAlignment.start,
              children: [
                SmallChip(
                  text: loc.fever,
                  color: stateToColor(states?.feverState),
                ),
                if (measurement.data.medicationSection != null)
                  SmallChip(
                    text: loc.medication,
                    color: stateToColor(states?.medicationState),
                  ),
                if (measurement.data.hydrationSection != null)
                  SmallChip(
                    text: loc.hydration,
                    color: stateToColor(states?.hydrationState),
                  ),
                if (measurement.data.respirationSection != null)
                  SmallChip(
                    text: loc.respiration,
                    color: stateToColor(states?.respirationState),
                  ),
                if (measurement.data.skinSection != null)
                  SmallChip(
                    text: loc.skin,
                    color: stateToColor(states?.skinState),
                  ),
                if (measurement.data.pulseSection != null)
                  SmallChip(
                    text: loc.pulse,
                    color: stateToColor(states?.pulseState),
                  ),
                if (measurement.data.generalSection != null)
                  SmallChip(
                    text: loc.general,
                    color: stateToColor(states?.generalState),
                  ),
                if (measurement.data.caregiverSection != null)
                  SmallChip(
                    text: loc.caregiver,
                    color: stateToColor(states?.caregiverState),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) =>
                      ViewMeasurement(measurementModel: entry.value)));
            },
            child: Text(loc.view),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    final firstCreatedAt =
        widget.illness.feverMeasurements.first.meta.createdAt;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc!.illnessHistory),
      ),
      body: Column(
        children: [
          ILineChart(
            title: 'Temperature over time',
            data: widget.illness.feverMeasurements
                .map((e) => FlSpot(
                      e.meta.createdAt
                              .difference(firstCreatedAt)
                              .inMinutes
                              .abs() /
                          60,
                      e.data.feverSection.temperature,
                    ))
                .toList(),
          ),
          const Divider(
            height: 12,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    expanded[index] = !isExpanded;
                  });
                },
                children: widget.illness.feverMeasurements
                    .asMap()
                    .entries
                    .map<ExpansionPanel>(buildPanel)
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SmallChip extends StatelessWidget {
  final String text;
  final Color color;

  const SmallChip({super.key, required this.text, this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
      child: Chip(
        shape: StadiumBorder(side: BorderSide(color: color)),
        backgroundColor: Colors.white,
        label: Text(text),
        labelStyle: const TextStyle(fontSize: 12, color: Colors.black54),
        labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: -4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
