import 'package:fever_friend_app/models/models.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'sections/sections.dart';

const formActionState = FormActionState.view;

Map<MeasurementSections, Widget Function(dynamic)> formTypes = {
  MeasurementSections.fever: (model) => FeverSectionForm(
        feverSectionModel: model,
        formActionState: formActionState,
      ),
  MeasurementSections.medication: (model) => MedicationSectionForm(
        medicationSectionModel: model,
        formActionState: formActionState,
      ),
  MeasurementSections.hydration: (model) => HydrationSectionForm(
        hydrationSectionModel: model,
        formActionState: formActionState,
      ),
  MeasurementSections.respiration: (model) => RespirationSectionForm(
        respirationSectionModel: model,
        formActionState: formActionState,
      ),
  MeasurementSections.skin: (model) => SkinSectionForm(
        skinSectionModel: model,
        formActionState: formActionState,
      ),
  MeasurementSections.pulse: (model) => PulseSectionForm(
        pulseSectionModel: model,
        formActionState: formActionState,
      ),
  MeasurementSections.general: (model) => GeneralSectionForm(
        generalSectionModel: model,
        formActionState: formActionState,
      ),
  MeasurementSections.caregiver: (model) => CaregiverSectionForm(
        caregiverSectionModel: model,
        formActionState: formActionState,
      ),
};

class ViewMeasurement extends StatelessWidget {
  final MeasurementModel measurementModel;
  const ViewMeasurement({Key? key, required this.measurementModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = measurementModel.data.sectionMap;
    final loc = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: measurementModel.data.sectionCount,
      child: Scaffold(
        appBar: AppBar(
          title: Text(loc.measurement),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            tabs: <Tab>[
              for (final section in MeasurementSections.values)
                if (data[section] != null)
                  Tab(
                    text: sectionConfigMap(context)[section]!.title,
                    icon: sectionConfigMap(context)[section]!.icon,
                  ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            for (final entry in formTypes.entries)
              if (data[entry.key] != null)
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: entry.value(data[entry.key]),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
