import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fever_measurement.g.dart';

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
  String? antibioticsHowManyTimes;
  String? antibioticsHowManyTimesState;
  String? antibioticsHowMuch;
  String? antibioticsState;
  String? antibioticsWhat;

  String? antipyreticMedication;
  String? antipyreticMedicationHowManyTimesState;
  String? antipyreticMedicationHowManyTimes;
  String? antipyreticMedicationHowMuch;
  String? antipyreticMedicationState;
  String? antipyreticMedicationWhat;

  String? awareness;
  String? awarenessState;

  String? bulgingFontanelleMax18MOld;
  String? bulgingFontanelleMax18MOldState;

  String? crying;
  String? cryingState;

  String? diarrhea;
  String? diarrheaState;
  String? drinking;
  String? drinkingState;
  String? dyspnea;
  String? dyspneaState;

  String? exoticTripInTheLast12Months;
  String? exoticTripInTheLast12MonthsState;
  String? febrileSeizure;
  String? febrileSeizureState;
  String? feverDuration;
  String? feverDurationState;
  String? feverMeasurementLocation;
  String? feverMeasurementLocationState;
  String? glassTest;
  String? glassTestState;
  String? lang;
  String? lastTimeEating;
  String? lastTimeEatingState;
  String? lastUrination;
  String? lastUrinationState;
  String? notificationIllnessReviewTask;
  String? notificationTask;
  String? pain;
  String? painState;
  String? painfulUrination;
  String? painfulUrinationState;

  String? parentConfident;
  String? parentConfidentState;
  String? parentFeel;
  String? parentFeelState;
  String? parentThink;
  String? parentThinkState;

  String? patientName;
  String? patientState;
  String? pulse;
  String? pulseState;
  String? rash;
  String? rashState;
  String? respiratoryRate;
  String? respiratoryRateState;
  String? skinColor;
  String? skinColorState;
  String? skinTurgor;
  String? skinTurgorState;
  String? smellyUrine;
  String? smellyUrineState;
  String? tearsWhenCrying;
  String? tearsWhenCryingState;
  String? temperature;
  String? temperatureAdjusted;
  String? temperatureState;
  String? thermometerUsed;
  String? thermometerUsedState;
  String? tongue;
  String? tongueState;
  String? vaccinationsWithIn14days;
  String? vaccinationsWithIn14daysState;
  String? vaccinationsHowManyHoursAgo;
  String? vaccinationsHowManyHoursAgoState;
  String? vaccinationsUsedVaccination;
  String? vomit;
  String? vomitState;
  String? wheezing;
  String? wheezingState;
  String? wryNeck;
  String? wryNeckState;

  FeverMeasurementData({
    this.antibiotics,
    this.antibioticsHowManyTimes,
    this.antibioticsHowManyTimesState,
    this.antibioticsHowMuch,
    this.antibioticsState,
    this.antibioticsWhat,
    this.antipyreticMedication,
    this.antipyreticMedicationHowManyTimes,
    this.antipyreticMedicationHowManyTimesState,
    this.antipyreticMedicationHowMuch,
    this.antipyreticMedicationState,
    this.antipyreticMedicationWhat,
    this.awareness,
    this.awarenessState,
    this.bulgingFontanelleMax18MOld,
    this.bulgingFontanelleMax18MOldState,
    this.crying,
    this.cryingState,
    this.diarrhea,
    this.diarrheaState,
    this.drinking,
    this.drinkingState,
    this.dyspnea,
    this.dyspneaState,
    this.exoticTripInTheLast12Months,
    this.thermometerUsed,
    this.exoticTripInTheLast12MonthsState,
    this.febrileSeizure,
    this.febrileSeizureState,
    this.feverDuration,
    this.feverDurationState,
    this.feverMeasurementLocation,
    this.feverMeasurementLocationState,
    this.glassTest,
    this.glassTestState,
    this.lang,
    this.lastTimeEating,
    this.lastTimeEatingState,
    this.lastUrination,
    this.lastUrinationState,
    this.notificationIllnessReviewTask,
    this.notificationTask,
    this.pain,
    this.painState,
    this.painfulUrination,
    this.painfulUrinationState,
    this.parentConfident,
    this.parentConfidentState,
    this.parentFeel,
    this.parentFeelState,
    this.parentThink,
    this.parentThinkState,
    this.patientName,
    this.patientState,
    this.pulse,
    this.pulseState,
    this.rash,
    this.rashState,
    this.respiratoryRate,
    this.respiratoryRateState,
    this.skinColor,
    this.skinColorState,
    this.skinTurgor,
    this.skinTurgorState,
    this.smellyUrine,
    this.smellyUrineState,
    this.tearsWhenCrying,
    this.tearsWhenCryingState,
    this.temperature,
    this.temperatureAdjusted,
    this.temperatureState,
    this.thermometerUsedState,
    this.tongue,
    this.tongueState,
    this.vaccinationsHowManyHoursAgo,
    this.vaccinationsHowManyHoursAgoState,
    this.vaccinationsUsedVaccination,
    this.vaccinationsWithIn14days,
    this.vaccinationsWithIn14daysState,
    this.vomit,
    this.vomitState,
    this.wheezing,
    this.wheezingState,
    this.wryNeck,
    this.wryNeckState,
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
