// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fever_measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeverMeasurement _$FeverMeasurementFromJson(Map<String, dynamic> json) =>
    FeverMeasurement(
      id: json['id'] as String,
      data: FeverMeasurementData.fromJson(json['data'] as Map<String, dynamic>),
      meta: FeverMeasurementMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeverMeasurementToJson(FeverMeasurement instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', FeverMeasurement.toNull(instance.id));
  val['meta'] = instance.meta.toJson();
  val['data'] = instance.data.toJson();
  return val;
}

FeverMeasurementMeta _$FeverMeasurementMetaFromJson(
        Map<String, dynamic> json) =>
    FeverMeasurementMeta(
      createdAt: DateTime.parse(json['createdAt'] as String),
      numberOfQuestions: json['numberOfQuestions'] as int,
      appVersion: json['appVersion'] as String? ?? 'dev',
      fcmToken: json['fcmToken'] as String? ?? '',
      anseredQuestions: json['anseredQuestions'] as int? ?? 0,
      progressPercent: (json['progressPercent'] as num?)?.toDouble() ?? 0.0,
      autosaved: json['autosaved'] as bool? ?? false,
      saved: json['saved'] as bool? ?? false,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$FeverMeasurementMetaToJson(
        FeverMeasurementMeta instance) =>
    <String, dynamic>{
      'appVersion': instance.appVersion,
      'numberOfQuestions': instance.numberOfQuestions,
      'anseredQuestions': instance.anseredQuestions,
      'progressPercent': instance.progressPercent,
      'fcmToken': instance.fcmToken,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'autosaved': instance.autosaved,
      'saved': instance.saved,
    };

FeverMeasurementData _$FeverMeasurementDataFromJson(
        Map<String, dynamic> json) =>
    FeverMeasurementData(
      antibiotics: json['antibiotics'] as String?,
      antibioticsHowManyTimes: json['antibioticsHowManyTimes'] as String?,
      antibioticsHowManyTimesState:
          json['antibioticsHowManyTimesState'] as String?,
      antibioticsHowMuch: json['antibioticsHowMuch'] as String?,
      antibioticsState: json['antibioticsState'] as String?,
      antibioticsWhat: json['antibioticsWhat'] as String?,
      antipyreticMedication: json['antipyreticMedication'] as String?,
      antipyreticMedicationHowManyTimes:
          json['antipyreticMedicationHowManyTimes'] as String?,
      antipyreticMedicationHowManyTimesState:
          json['antipyreticMedicationHowManyTimesState'] as String?,
      antipyreticMedicationHowMuch:
          json['antipyreticMedicationHowMuch'] as String?,
      antipyreticMedicationState: json['antipyreticMedicationState'] as String?,
      antipyreticMedicationWhat: json['antipyreticMedicationWhat'] as String?,
      awareness: json['awareness'] as String?,
      awarenessState: json['awarenessState'] as String?,
      bulgingFontanelleMax18MOld: json['bulgingFontanelleMax18MOld'] as String?,
      bulgingFontanelleMax18MOldState:
          json['bulgingFontanelleMax18MOldState'] as String?,
      crying: json['crying'] as String?,
      cryingState: json['cryingState'] as String?,
      diarrhea: json['diarrhea'] as String?,
      diarrheaState: json['diarrheaState'] as String?,
      drinking: json['drinking'] as String?,
      drinkingState: json['drinkingState'] as String?,
      dyspnea: json['dyspnea'] as String?,
      dyspneaState: json['dyspneaState'] as String?,
      exoticTripInTheLast12Months:
          json['exoticTripInTheLast12Months'] as String?,
      thermometerUsed: json['thermometerUsed'] as String?,
      exoticTripInTheLast12MonthsState:
          json['exoticTripInTheLast12MonthsState'] as String?,
      febrileSeizure: json['febrileSeizure'] as String?,
      febrileSeizureState: json['febrileSeizureState'] as String?,
      feverDuration: json['feverDuration'] as String?,
      feverDurationState: json['feverDurationState'] as String?,
      feverMeasurementLocation: json['feverMeasurementLocation'] as String?,
      feverMeasurementLocationState:
          json['feverMeasurementLocationState'] as String?,
      glassTest: json['glassTest'] as String?,
      glassTestState: json['glassTestState'] as String?,
      lang: json['lang'] as String?,
      lastTimeEating: json['lastTimeEating'] as String?,
      lastTimeEatingState: json['lastTimeEatingState'] as String?,
      lastUrination: json['lastUrination'] as String?,
      lastUrinationState: json['lastUrinationState'] as String?,
      notificationIllnessReviewTask:
          json['notificationIllnessReviewTask'] as String?,
      notificationTask: json['notificationTask'] as String?,
      pain: json['pain'] as String?,
      painState: json['painState'] as String?,
      painfulUrination: json['painfulUrination'] as String?,
      painfulUrinationState: json['painfulUrinationState'] as String?,
      parentConfident: json['parentConfident'] as String?,
      parentConfidentState: json['parentConfidentState'] as String?,
      parentFeel: json['parentFeel'] as String?,
      parentFeelState: json['parentFeelState'] as String?,
      parentThink: json['parentThink'] as String?,
      parentThinkState: json['parentThinkState'] as String?,
      patientName: json['patientName'] as String?,
      patientState: json['patientState'] as String?,
      pulse: json['pulse'] as String?,
      pulseState: json['pulseState'] as String?,
      rash: json['rash'] as String?,
      rashState: json['rashState'] as String?,
      respiratoryRate: json['respiratoryRate'] as String?,
      respiratoryRateState: json['respiratoryRateState'] as String?,
      skinColor: json['skinColor'] as String?,
      skinColorState: json['skinColorState'] as String?,
      skinTurgor: json['skinTurgor'] as String?,
      skinTurgorState: json['skinTurgorState'] as String?,
      smellyUrine: json['smellyUrine'] as String?,
      smellyUrineState: json['smellyUrineState'] as String?,
      tearsWhenCrying: json['tearsWhenCrying'] as String?,
      tearsWhenCryingState: json['tearsWhenCryingState'] as String?,
      temperature: json['temperature'] as String?,
      temperatureAdjusted: json['temperatureAdjusted'] as String?,
      temperatureState: json['temperatureState'] as String?,
      thermometerUsedState: json['thermometerUsedState'] as String?,
      tongue: json['tongue'] as String?,
      tongueState: json['tongueState'] as String?,
      vaccinationsHowManyHoursAgo:
          json['vaccinationsHowManyHoursAgo'] as String?,
      vaccinationsHowManyHoursAgoState:
          json['vaccinationsHowManyHoursAgoState'] as String?,
      vaccinationsUsedVaccination:
          json['vaccinationsUsedVaccination'] as String?,
      vaccinationsWithIn14days: json['vaccinationsWithIn14days'] as String?,
      vaccinationsWithIn14daysState:
          json['vaccinationsWithIn14daysState'] as String?,
      vomit: json['vomit'] as String?,
      vomitState: json['vomitState'] as String?,
      wheezing: json['wheezing'] as String?,
      wheezingState: json['wheezingState'] as String?,
      wryNeck: json['wryNeck'] as String?,
      wryNeckState: json['wryNeckState'] as String?,
    );

Map<String, dynamic> _$FeverMeasurementDataToJson(
        FeverMeasurementData instance) =>
    <String, dynamic>{
      'antibiotics': instance.antibiotics,
      'antibioticsHowManyTimes': instance.antibioticsHowManyTimes,
      'antibioticsHowManyTimesState': instance.antibioticsHowManyTimesState,
      'antibioticsHowMuch': instance.antibioticsHowMuch,
      'antibioticsState': instance.antibioticsState,
      'antibioticsWhat': instance.antibioticsWhat,
      'antipyreticMedication': instance.antipyreticMedication,
      'antipyreticMedicationHowManyTimesState':
          instance.antipyreticMedicationHowManyTimesState,
      'antipyreticMedicationHowManyTimes':
          instance.antipyreticMedicationHowManyTimes,
      'antipyreticMedicationHowMuch': instance.antipyreticMedicationHowMuch,
      'antipyreticMedicationState': instance.antipyreticMedicationState,
      'antipyreticMedicationWhat': instance.antipyreticMedicationWhat,
      'awareness': instance.awareness,
      'awarenessState': instance.awarenessState,
      'bulgingFontanelleMax18MOld': instance.bulgingFontanelleMax18MOld,
      'bulgingFontanelleMax18MOldState':
          instance.bulgingFontanelleMax18MOldState,
      'crying': instance.crying,
      'cryingState': instance.cryingState,
      'diarrhea': instance.diarrhea,
      'diarrheaState': instance.diarrheaState,
      'drinking': instance.drinking,
      'drinkingState': instance.drinkingState,
      'dyspnea': instance.dyspnea,
      'dyspneaState': instance.dyspneaState,
      'exoticTripInTheLast12Months': instance.exoticTripInTheLast12Months,
      'exoticTripInTheLast12MonthsState':
          instance.exoticTripInTheLast12MonthsState,
      'febrileSeizure': instance.febrileSeizure,
      'febrileSeizureState': instance.febrileSeizureState,
      'feverDuration': instance.feverDuration,
      'feverDurationState': instance.feverDurationState,
      'feverMeasurementLocation': instance.feverMeasurementLocation,
      'feverMeasurementLocationState': instance.feverMeasurementLocationState,
      'glassTest': instance.glassTest,
      'glassTestState': instance.glassTestState,
      'lang': instance.lang,
      'lastTimeEating': instance.lastTimeEating,
      'lastTimeEatingState': instance.lastTimeEatingState,
      'lastUrination': instance.lastUrination,
      'lastUrinationState': instance.lastUrinationState,
      'notificationIllnessReviewTask': instance.notificationIllnessReviewTask,
      'notificationTask': instance.notificationTask,
      'pain': instance.pain,
      'painState': instance.painState,
      'painfulUrination': instance.painfulUrination,
      'painfulUrinationState': instance.painfulUrinationState,
      'parentConfident': instance.parentConfident,
      'parentConfidentState': instance.parentConfidentState,
      'parentFeel': instance.parentFeel,
      'parentFeelState': instance.parentFeelState,
      'parentThink': instance.parentThink,
      'parentThinkState': instance.parentThinkState,
      'patientName': instance.patientName,
      'patientState': instance.patientState,
      'pulse': instance.pulse,
      'pulseState': instance.pulseState,
      'rash': instance.rash,
      'rashState': instance.rashState,
      'respiratoryRate': instance.respiratoryRate,
      'respiratoryRateState': instance.respiratoryRateState,
      'skinColor': instance.skinColor,
      'skinColorState': instance.skinColorState,
      'skinTurgor': instance.skinTurgor,
      'skinTurgorState': instance.skinTurgorState,
      'smellyUrine': instance.smellyUrine,
      'smellyUrineState': instance.smellyUrineState,
      'tearsWhenCrying': instance.tearsWhenCrying,
      'tearsWhenCryingState': instance.tearsWhenCryingState,
      'temperature': instance.temperature,
      'temperatureAdjusted': instance.temperatureAdjusted,
      'temperatureState': instance.temperatureState,
      'thermometerUsed': instance.thermometerUsed,
      'thermometerUsedState': instance.thermometerUsedState,
      'tongue': instance.tongue,
      'tongueState': instance.tongueState,
      'vaccinationsWithIn14days': instance.vaccinationsWithIn14days,
      'vaccinationsWithIn14daysState': instance.vaccinationsWithIn14daysState,
      'vaccinationsHowManyHoursAgo': instance.vaccinationsHowManyHoursAgo,
      'vaccinationsHowManyHoursAgoState':
          instance.vaccinationsHowManyHoursAgoState,
      'vaccinationsUsedVaccination': instance.vaccinationsUsedVaccination,
      'vomit': instance.vomit,
      'vomitState': instance.vomitState,
      'wheezing': instance.wheezing,
      'wheezingState': instance.wheezingState,
      'wryNeck': instance.wryNeck,
      'wryNeckState': instance.wryNeckState,
    };
