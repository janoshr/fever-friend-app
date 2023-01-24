import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fever_friend_app/get_it.dart';
import 'package:fever_friend_app/models/models.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'fever_measurement.g.dart';

enum FormSteps {
  fever,
  medication,
  hydration,
  respiration,
  skin,
  pulse,
  general,
  caregiver
}

enum FeverFields {
  thermometerUsed,
  measurementLocation,
  temperature,
  feverDuration,
}

enum MedicationFields {
  antipyretic,
  antipyreticWhat,
  antipyreticHowMany,
  antipyreticHowMuch,
  antipyreticReason,
  antibiotics,
  antibioticsWhat,
  antibioticsHowMany,
  antibioticsHowMuch,
}

enum HydrationFields {
  lastUrination,
  skinTurgor,
  crying,
  tearsWhenCrying,
  tongue,
  drinking,
  diarrhea,
  vomit,
}

enum RespirationFields { respiratoryRate, stridor, dyspnea }

enum SkinFields {
  skinColor,
  rash,
  glassTest,
}

enum PulseFields {
  pulse,
}

enum GeneralFields {
  lastTimeEating,
  painfulUrination,
  smellyUrine,
  awareness,
  vaccinationIn14days,
  vaccinationIn14daysHowManyHoursAgo,
  exoticTrip,
  vaccinationWhat,
  seizure,
  wryNeck,
  pain,
}

enum CaregiverFields {
  parentFeel,
  parentThink,
  parentConfident,
}

@JsonSerializable(explicitToJson: true)
class FeverMeasurement {
  @JsonKey(toJson: toNull, includeIfNull: false)
  String id;

  FeverMeasurementMeta meta;
  FeverMeasurementData data;

  FeverMeasurement({
    required this.id,
    required this.data,
    required this.meta,
  });

  factory FeverMeasurement.fromJson(Map<String, dynamic> json) =>
      _$FeverMeasurementFromJson(json);

  factory FeverMeasurement.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;

    data['id'] = doc.id;

    return _$FeverMeasurementFromJson(data);
  }

  factory FeverMeasurement.fromFormBuilder(
      FormBuilderState formState, Patient patient) {
    PackageInfo pi = getIt.get<PackageInfo>();
    final data = FeverMeasurementData(
      antibiotics: formState.value[MedicationFields.antibiotics.name],
      antibioticsHowManyTimes:
          formState.value[MedicationFields.antibioticsHowMuch.name],
      antibioticsHowMuch:
          formState.value[MedicationFields.antibioticsHowMuch.name],
      antibioticsWhat: formState.value[MedicationFields.antibioticsWhat.name],
      antipyreticMedication: formState.value[MedicationFields.antipyretic.name],
      antipyreticMedicationHowManyTimes:
          formState.value[MedicationFields.antipyreticHowMany.name],
      antipyreticMedicationHowMuch:
          formState.value[MedicationFields.antipyreticHowMuch.name],
      antipyreticMedicationWhat:
          formState.value[MedicationFields.antipyreticWhat.name],
      awareness: formState.value[GeneralFields.awareness.name],
      crying: formState.value[HydrationFields.crying.name],
      diarrhea: formState.value[HydrationFields.diarrhea.name],
      drinking: formState.value[HydrationFields.drinking.name],
      dyspnea: formState.value[RespirationFields.dyspnea.name],
      exoticTripInTheLast12Months:
          formState.value[GeneralFields.exoticTrip.name],
      febrileSeizure: formState.value[GeneralFields.seizure.name],
      feverDuration: formState.value[FeverFields.feverDuration.name],
      feverMeasurementLocation:
          formState.value[FeverFields.measurementLocation.name],
      glassTest: formState.value[SkinFields.glassTest.name],
      lastTimeEating: formState.value[GeneralFields.lastTimeEating.name],
      lastUrination: formState.value[HydrationFields.lastUrination.name],
      pain: formState.value[GeneralFields.pain.name],
      painfulUrination: formState.value[GeneralFields.painfulUrination.name],
      parentConfident: formState.value[CaregiverFields.parentConfident.name],
      parentFeel: formState.value[CaregiverFields.parentFeel.name],
      parentThink: formState.value[CaregiverFields.parentThink.name],
      patientName: patient.name,
      // TODO use model to predict patientState
      patientState: null,
      pulse: formState.value[PulseFields.pulse.name],
      rash: formState.value[SkinFields.rash.name],
      respiratoryRate: formState.value[RespirationFields.respiratoryRate.name],
      skinColor: formState.value[SkinFields.skinColor.name],
      skinTurgor: formState.value[HydrationFields.skinTurgor.name],
      smellyUrine: formState.value[GeneralFields.smellyUrine.name],
      tearsWhenCrying: formState.value[HydrationFields.tearsWhenCrying.name],
      temperature: formState.value[FeverFields.temperature.name],
      // TODO add calculating logic to screen
      temperatureAdjusted: null,
      thermometerUsed: formState.value[FeverFields.thermometerUsed.name],
      tongue: formState.value[HydrationFields.tongue.name],
      vaccinationsHowManyHoursAgo: formState
          .value[GeneralFields.vaccinationIn14daysHowManyHoursAgo.name],
      vaccinationsWithIn14days:
          formState.value[GeneralFields.vaccinationIn14days.name],
      vaccinationsUsedVaccination:
          formState.value[GeneralFields.vaccinationWhat.name],
      vomit: formState.value[HydrationFields.vomit.name],
      wheezing: formState.value[RespirationFields.stridor.name],
      wryNeck: formState.value[GeneralFields.wryNeck.name],
    );
    final meta = FeverMeasurementMeta(
      createdAt: DateTime.now(),
      lang: 'en',
      // TODO calculate
      numberOfQuestions: 0,
      // TODO calculate
      anseredQuestions: 0,
      appVersion: pi.version,
      autosaved: false,
      progressPercent: 1 / 1,
      saved: true,
      updatedAt: null,
    );
    return FeverMeasurement(id: 'n/a', data: data, meta: meta);
  }

  Map<String, dynamic> toJson() => _$FeverMeasurementToJson(this);

  static toNull(_) => null;
}

@JsonSerializable()
class FeverMeasurementMeta {
  // https://stackoverflow.com/a/53672255/13280594
  String appVersion;
  int numberOfQuestions;
  int anseredQuestions;
  double progressPercent;
  String fcmToken;

  String? notificationIllnessReviewTask;
  String? notificationTask;

  String? lang;

  DateTime createdAt;
  DateTime? updatedAt;
  bool autosaved;
  bool saved;

  FeverMeasurementMeta({
    required this.createdAt,
    required this.numberOfQuestions,
    this.appVersion = 'dev',
    this.fcmToken = '',
    this.anseredQuestions = 0,
    this.progressPercent = 0.0,
    this.autosaved = false,
    this.saved = false,
    this.updatedAt,
    this.lang,
  });

  factory FeverMeasurementMeta.fromJson(Map<String, dynamic> json) =>
      _$FeverMeasurementMetaFromJson(json);

  factory FeverMeasurementMeta.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;

    data['id'] = doc.id;

    return _$FeverMeasurementMetaFromJson(data);
  }

  Map<String, dynamic> toJson() => _$FeverMeasurementMetaToJson(this);
}

@JsonSerializable()
class FeverMeasurementData {
  String? antibiotics;
  int? antibioticsHowManyTimes;
  double? antibioticsHowMuch;
  String? antibioticsWhat;

  String? antipyreticMedication;
  int? antipyreticMedicationHowManyTimes;
  double? antipyreticMedicationHowMuch;
  String? antipyreticMedicationWhat;

  String? awareness;

  String? bulgingFontanelleMax18MOld;

  String? crying;

  String? diarrhea;
  String? drinking;
  String? dyspnea;

  String? exoticTripInTheLast12Months;
  String? febrileSeizure;
  String? feverDuration;
  String? feverMeasurementLocation;
  String? glassTest;
  String? lastTimeEating;
  String? lastUrination;
  List<String>? pain;
  String? painfulUrination;

  String? parentConfident;
  String? parentFeel;
  String? parentThink;

  String? patientName;
  String? patientState;

  double? pulse;

  String? rash;

  double? respiratoryRate;

  String? skinColor;
  String? skinTurgor;
  String? smellyUrine;
  String? tearsWhenCrying;

  double? temperature;
  double? temperatureAdjusted;

  String? thermometerUsed;
  String? tongue;
  String? vaccinationsWithIn14days;
  String? vaccinationsHowManyHoursAgo;
  String? vaccinationsUsedVaccination;
  String? vomit;
  String? wheezing;
  String? wryNeck;

  FeverMeasurementData({
    this.antibiotics,
    this.antibioticsHowManyTimes,
    this.antibioticsHowMuch,
    this.antibioticsWhat,
    this.antipyreticMedication,
    this.antipyreticMedicationHowManyTimes,
    this.antipyreticMedicationHowMuch,
    this.antipyreticMedicationWhat,
    this.awareness,
    this.bulgingFontanelleMax18MOld,
    this.crying,
    this.diarrhea,
    this.drinking,
    this.dyspnea,
    this.exoticTripInTheLast12Months,
    this.thermometerUsed,
    this.febrileSeizure,
    this.feverDuration,
    this.feverMeasurementLocation,
    this.glassTest,
    this.lastTimeEating,
    this.lastUrination,
    this.pain,
    this.painfulUrination,
    this.parentConfident,
    this.parentFeel,
    this.parentThink,
    this.patientName,
    this.patientState,
    this.pulse,
    this.rash,
    this.respiratoryRate,
    this.skinColor,
    this.skinTurgor,
    this.smellyUrine,
    this.tearsWhenCrying,
    this.temperature,
    this.temperatureAdjusted,
    this.tongue,
    this.vaccinationsHowManyHoursAgo,
    this.vaccinationsUsedVaccination,
    this.vaccinationsWithIn14days,
    this.vomit,
    this.wheezing,
    this.wryNeck,
  });

  factory FeverMeasurementData.fromJson(Map<String, dynamic> json) =>
      _$FeverMeasurementDataFromJson(json);

  factory FeverMeasurementData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;

    data['id'] = doc.id;

    return _$FeverMeasurementDataFromJson(data);
  }

  Map<String, dynamic> toJson() => _$FeverMeasurementDataToJson(this);
}
