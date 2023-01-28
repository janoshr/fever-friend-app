import 'package:json_annotation/json_annotation.dart';

enum FormSteps {
  fever,
  medication,
  hydration,
  respiration,
  skin,
  pulse,
  general,
  caregiver,
}

enum FeverFields {
  feverDuration,
  measurementLocation,
  temperature,
  thermometerUsed,
}

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

enum RespirationFields {
  dyspnea,
  respiratoryRate,
  wheezing,
}

enum SkinFields {
  glassTest,
  rash,
  skinColor,
}

enum PulseFields {
  pulse,
}

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

enum CaregiverFields {
  parentConfident,
  parentFeel,
  parentThink,
}

enum PatientState {
  @JsonValue('good')
  good,
  @JsonValue('caution')
  caution,
  @JsonValue('danger')
  danger,
}