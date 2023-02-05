import 'package:json_annotation/json_annotation.dart';

enum MeasurementSections {
  fever,
  medication,
  hydration,
  respiration,
  skin,
  pulse,
  general,
  caregiver,
}

/// Fever form questions
/// (4)
enum FeverFields {
  feverDuration,
  measurementLocation,
  temperature,
  thermometerUsed,
}

/// Medication form questions
/// (9)
enum MedicationFields {
  antibiotics,
  antibioticsHowMany,
  antibioticsHowMuch,
  antibioticsWhat,
  antipyretic,
  antipyreticHowMany,
  antipyreticHowMuch,
  antipyreticReason,
  antipyreticWhat,
}

/// Hydration form questions
/// (8)
enum HydrationFields {
  crying,
  diarrhea,
  drinking,
  lastUrination,
  skinTurgor,
  tearsWhenCrying,
  tongue,
  vomit,
}

/// Respiration form questions
/// (3)
enum RespirationFields {
  dyspnea,
  respiratoryRate,
  wheezing,
}

/// Skin condition form questions
/// (3)
enum SkinFields {
  glassTest,
  rash,
  skinColor,
}

/// Pulse form question
/// (1)
enum PulseFields {
  pulse,
}

/// General condition form questions
/// (12)
enum GeneralFields {
  awareness,
  // TODO add everywhere with logic
  bulgingFontanelleMax18MOld,
  exoticTrip,
  lastTimeEating,
  pain,
  painfulUrination,
  seizure,
  smellyUrine,
  vaccinationIn14days,
  vaccinationHowManyHoursAgo,
  vaccinationWhat,
  wryNeck,
}

/// Caregiver form questions
/// (3)
enum CaregiverFields {
  caregiverConfident,
  caregiverFeel,
  caregiverThink,
}

enum PatientState {
  @JsonValue('good')
  good,
  @JsonValue('caution')
  caution,
  @JsonValue('danger')
  danger,
}
