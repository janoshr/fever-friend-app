import 'package:fever_friend_app/models/models.dart';
import 'package:fever_friend_app/screens/measurement/sections.dart';
import 'package:flutter/material.dart';

class ViewMeasurement extends StatelessWidget {
  final MeasurementModel measurementModel;
  const ViewMeasurement({Key? key, required this.measurementModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = measurementModel.data;

    const formActionState = FormActionState.view;

    return DefaultTabController(
      length: measurementModel.data.sectionCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Measurement'),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            tabs: <Tab>[
              if (data.feverSection != null)
                Tab(
                  text: sectionConfigMap[MeasurementSections.fever]!.title,
                  icon: sectionConfigMap[MeasurementSections.fever]!.icon,
                ),
              if (data.medicationSection != null)
                Tab(
                  text: sectionConfigMap[MeasurementSections.medication]!.title,
                  icon: sectionConfigMap[MeasurementSections.medication]!.icon,
                ),
              if (data.hydrationSection != null)
                Tab(
                  text: sectionConfigMap[MeasurementSections.hydration]!.title,
                  icon: sectionConfigMap[MeasurementSections.hydration]!.icon,
                ),
              if (data.respirationSection != null)
                Tab(
                  text:
                      sectionConfigMap[MeasurementSections.respiration]!.title,
                  icon: sectionConfigMap[MeasurementSections.respiration]!.icon,
                ),
              if (data.skinSection != null)
                Tab(
                  text: sectionConfigMap[MeasurementSections.skin]!.title,
                  icon: sectionConfigMap[MeasurementSections.skin]!.icon,
                ),
              if (data.pulseSection != null)
                Tab(
                  text: sectionConfigMap[MeasurementSections.pulse]!.title,
                  icon: sectionConfigMap[MeasurementSections.pulse]!.icon,
                ),
              if (data.generalSection != null)
                Tab(
                  text: sectionConfigMap[MeasurementSections.general]!.title,
                  icon: sectionConfigMap[MeasurementSections.general]!.icon,
                ),
              if (data.caregiverSection != null)
                Tab(
                  text: sectionConfigMap[MeasurementSections.caregiver]!.title,
                  icon: sectionConfigMap[MeasurementSections.caregiver]!.icon,
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            if (data.feverSection != null)
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FeverSectionForm(
                    formState: null,
                    feverSectionModel: data.feverSection,
                    formActionState: formActionState,
                  ),
                ),
              ),
            if (data.medicationSection != null)
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MedicationSectionForm(
                    formState: null,
                    medicationSectionModel: data.medicationSection,
                    formActionState: formActionState,
                  ),
                ),
              ),
            if (data.hydrationSection != null)
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HydrationSectionForm(
                    formState: null,
                    hydrationSectionModel: data.hydrationSection,
                    formActionState: formActionState,
                  ),
                ),
              ),
            if (data.respirationSection != null)
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RespirationSectionForm(
                    formState: null,
                    formActionState: formActionState,
                    respirationSectionModel: data.respirationSection,
                  ),
                ),
              ),
            if (data.skinSection != null)
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SkinSectionForm(
                    formState: null,
                    formActionState: formActionState,
                    skinSectionModel: data.skinSection,
                  ),
                ),
              ),
            if (data.pulseSection != null)
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PulseSectionForm(
                    formState: null,
                    formActionState: formActionState,
                    pulseSectionModel: data.pulseSection,
                  ),
                ),
              ),
            if (data.generalSection != null)
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GeneralSectionForm(
                    formState: null,
                    formActionState: formActionState,
                    generalSectionModel: data.generalSection,
                  ),
                ),
              ),
            if (data.caregiverSection != null)
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CaregiverSectionForm(
                    formState: null,
                    formActionState: formActionState,
                    caregiverSectionModel: data.caregiverSection,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
