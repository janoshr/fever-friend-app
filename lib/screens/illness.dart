import 'package:fever_friend_app/models/fever_measurement.dart';
import 'package:fever_friend_app/models/models.dart';
import 'package:fever_friend_app/screens/measurement/sections/sections.dart';
import 'package:fever_friend_app/screens/measurement/view_measurement.dart';
import 'package:fever_friend_app/screens/screens.dart';
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

    final loc = AppLocalizations.of(context)!;

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
          for (final section in measurement.data.sectionMap.entries)
            if (section.value != null)
              ListTile(
                dense: true,
                title: Text(
                  sectionConfigMap(context)[section.key]!.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                leading: sectionConfigMap(context)[section.key]!.icon,
                iconColor:
                    stateToColor(measurement.state?.sectionMap[section.key]),
              ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          ViewMeasurement(measurementModel: entry.value)));
                },
                child: Text(loc.view),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          AdviceScreen(measurementModel: entry.value)));
                },
                child: Text(loc.adviceScreenTitle),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    final firstCreatedAt = widget.illness.feverMeasurements.last.meta.createdAt;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc!.illnessHistory),
      ),
      body: Column(
        children: [
          ILineChart(
            title: 'Temperature over time',
            data: widget.illness.feverMeasurements.reversed.map((e) {
              return FlSpot(
                e.meta.createdAt.difference(firstCreatedAt).inMinutes.abs() /
                    60,
                e.data.feverSection.temperature,
              );
            }).toList(),
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
