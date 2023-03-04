import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/models.dart';
import 'caregiver_section.dart';
import 'fever_section.dart';
import 'general_section.dart';
import 'hydration_section.dart';
import 'medication_section.dart';
import 'pulse_section.dart';
import 'respiration_section.dart';
import 'skin_section.dart';

export 'caregiver_section.dart';
export 'fever_section.dart';
export 'general_section.dart';
export 'hydration_section.dart';
export 'medication_section.dart';
export 'pulse_section.dart';
export 'respiration_section.dart';
export 'skin_section.dart';

class SectionConfig {
  final String title;
  final Icon icon;
  final Type widgetType;

  const SectionConfig({
    required this.title,
    required this.icon,
    required this.widgetType,
  });
}

Map<MeasurementSections, SectionConfig> sectionConfigMap(BuildContext context) {
  final loc = AppLocalizations.of(context)!;
  return {
    MeasurementSections.fever: SectionConfig(
        title: loc.fever,
        icon: const Icon(Icons.thermostat),
        widgetType: FeverSectionForm),
    MeasurementSections.medication: SectionConfig(
        title: loc.medication,
        icon: const Icon(Icons.medication),
        widgetType: MedicationSectionForm),
    MeasurementSections.hydration: SectionConfig(
        title: loc.hydration,
        icon: const Icon(Icons.water_drop),
        widgetType: HydrationSectionForm),
    MeasurementSections.respiration: SectionConfig(
        title: loc.respiration,
        icon: const Icon(Icons.air),
        widgetType: RespirationSectionForm),
    MeasurementSections.skin: SectionConfig(
        title: loc.skin,
        icon: const Icon(Icons.face),
        widgetType: SkinSectionForm),
    MeasurementSections.pulse: SectionConfig(
        title: loc.pulse,
        icon: const Icon(Icons.monitor_heart),
        widgetType: PulseSectionForm),
    MeasurementSections.general: SectionConfig(
        title: loc.general,
        icon: const Icon(Icons.self_improvement),
        widgetType: GeneralSectionForm),
    MeasurementSections.caregiver: SectionConfig(
        title: loc.caregiver,
        icon: const Icon(Icons.volunteer_activism),
        widgetType: CaregiverSectionForm),
  };
}
