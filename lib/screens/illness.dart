import 'package:fever_friend_app/models/fever_measurement.dart';
import 'package:fever_friend_app/ui/shared/constants.dart';
import 'package:fever_friend_app/ui/shared/utils.dart';
import 'package:flutter/material.dart';

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

    return ExpansionPanel(
      isExpanded: expanded[i],
      headerBuilder: (context, isExpanded) {
        return ListTile(
          leading: Icon(
            Icons.circle,
            color: stateToColor(measurement.data.patientState),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateFMMMDDHmm.format(measurement.meta.createdAt)),
              Text(measurement.data.feverSection != null &&
                      measurement.data.feverSection!.temperature != null
                  ? '${measurement.data.feverSection!.temperature!.toStringAsFixed(1)} °C'
                  : 'n/a'),
            ],
          ),
          onTap: () {
            setState(() {
              expanded[i] = !isExpanded;
            });
          },
        );
      },
      body: ListTile(
        title: Text('Sections'),
        subtitle: Wrap(
          alignment: WrapAlignment.start,
          children: [
            if (measurement.data.feverSection != null)
              const SmallChip(text: 'Fever'),
            if (measurement.data.medicationSection != null)
              const SmallChip(text: 'Medication'),
            if (measurement.data.hydrationSection != null)
              const SmallChip(text: 'Hydration'),
            if (measurement.data.respirationSection != null)
              const SmallChip(text: 'Respiration'),
            if (measurement.data.skinSection != null)
              const SmallChip(text: 'Skin'),
            if (measurement.data.generalSection != null)
              const SmallChip(text: 'General'),
            if (measurement.data.caregiverSection != null)
              const SmallChip(text: 'Caregiver'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Illness history'),
      ),
      body: Column(
        children: [
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

  const SmallChip({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
      child: Chip(
        shape: const StadiumBorder(side: BorderSide(color: Colors.black54)),
        backgroundColor: Colors.white,
        label: Text(text),
        labelStyle: const TextStyle(fontSize: 12, color: Colors.black54),
        labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: -4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
