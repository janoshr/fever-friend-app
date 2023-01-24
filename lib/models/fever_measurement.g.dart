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
      lang: json['lang'] as String?,
    )
      ..notificationIllnessReviewTask =
          json['notificationIllnessReviewTask'] as String?
      ..notificationTask = json['notificationTask'] as String?;

Map<String, dynamic> _$FeverMeasurementMetaToJson(
        FeverMeasurementMeta instance) =>
    <String, dynamic>{
      'appVersion': instance.appVersion,
      'numberOfQuestions': instance.numberOfQuestions,
      'anseredQuestions': instance.anseredQuestions,
      'progressPercent': instance.progressPercent,
      'fcmToken': instance.fcmToken,
      'notificationIllnessReviewTask': instance.notificationIllnessReviewTask,
      'notificationTask': instance.notificationTask,
      'lang': instance.lang,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'autosaved': instance.autosaved,
      'saved': instance.saved,
    };

FeverMeasurementData _$FeverMeasurementDataFromJson(
        Map<String, dynamic> json) =>
    FeverMeasurementData(
      antibiotics: json['antibiotics'] as String?,
      antibioticsHowManyTimes: json['antibioticsHowManyTimes'] as int?,
      antibioticsHowMuch: (json['antibioticsHowMuch'] as num?)?.toDouble(),
      antibioticsWhat: json['antibioticsWhat'] as String?,
      antipyreticMedication: json['antipyreticMedication'] as String?,
      antipyreticMedicationHowManyTimes:
          json['antipyreticMedicationHowManyTimes'] as int?,
      antipyreticMedicationHowMuch:
          (json['antipyreticMedicationHowMuch'] as num?)?.toDouble(),
      antipyreticMedicationWhat: json['antipyreticMedicationWhat'] as String?,
      awareness: json['awareness'] as String?,
      bulgingFontanelleMax18MOld: json['bulgingFontanelleMax18MOld'] as String?,
      crying: json['crying'] as String?,
      diarrhea: json['diarrhea'] as String?,
      drinking: json['drinking'] as String?,
      dyspnea: json['dyspnea'] as String?,
      exoticTripInTheLast12Months:
          json['exoticTripInTheLast12Months'] as String?,
      thermometerUsed: json['thermometerUsed'] as String?,
      febrileSeizure: json['febrileSeizure'] as String?,
      feverDuration: json['feverDuration'] as String?,
      feverMeasurementLocation: json['feverMeasurementLocation'] as String?,
      glassTest: json['glassTest'] as String?,
      lastTimeEating: json['lastTimeEating'] as String?,
      lastUrination: json['lastUrination'] as String?,
      pain: (json['pain'] as List<dynamic>?)?.map((e) => e as String).toList(),
      painfulUrination: json['painfulUrination'] as String?,
      parentConfident: json['parentConfident'] as String?,
      parentFeel: json['parentFeel'] as String?,
      parentThink: json['parentThink'] as String?,
      patientName: json['patientName'] as String?,
      patientState: json['patientState'] as String?,
      pulse: (json['pulse'] as num?)?.toDouble(),
      rash: json['rash'] as String?,
      respiratoryRate: (json['respiratoryRate'] as num?)?.toDouble(),
      skinColor: json['skinColor'] as String?,
      skinTurgor: json['skinTurgor'] as String?,
      smellyUrine: json['smellyUrine'] as String?,
      tearsWhenCrying: json['tearsWhenCrying'] as String?,
      temperature: (json['temperature'] as num?)?.toDouble(),
      temperatureAdjusted: (json['temperatureAdjusted'] as num?)?.toDouble(),
      tongue: json['tongue'] as String?,
      vaccinationsHowManyHoursAgo:
          json['vaccinationsHowManyHoursAgo'] as String?,
      vaccinationsUsedVaccination:
          json['vaccinationsUsedVaccination'] as String?,
      vaccinationsWithIn14days: json['vaccinationsWithIn14days'] as String?,
      vomit: json['vomit'] as String?,
      wheezing: json['wheezing'] as String?,
      wryNeck: json['wryNeck'] as String?,
    );

Map<String, dynamic> _$FeverMeasurementDataToJson(
        FeverMeasurementData instance) =>
    <String, dynamic>{
      'antibiotics': instance.antibiotics,
      'antibioticsHowManyTimes': instance.antibioticsHowManyTimes,
      'antibioticsHowMuch': instance.antibioticsHowMuch,
      'antibioticsWhat': instance.antibioticsWhat,
      'antipyreticMedication': instance.antipyreticMedication,
      'antipyreticMedicationHowManyTimes':
          instance.antipyreticMedicationHowManyTimes,
      'antipyreticMedicationHowMuch': instance.antipyreticMedicationHowMuch,
      'antipyreticMedicationWhat': instance.antipyreticMedicationWhat,
      'awareness': instance.awareness,
      'bulgingFontanelleMax18MOld': instance.bulgingFontanelleMax18MOld,
      'crying': instance.crying,
      'diarrhea': instance.diarrhea,
      'drinking': instance.drinking,
      'dyspnea': instance.dyspnea,
      'exoticTripInTheLast12Months': instance.exoticTripInTheLast12Months,
      'febrileSeizure': instance.febrileSeizure,
      'feverDuration': instance.feverDuration,
      'feverMeasurementLocation': instance.feverMeasurementLocation,
      'glassTest': instance.glassTest,
      'lastTimeEating': instance.lastTimeEating,
      'lastUrination': instance.lastUrination,
      'pain': instance.pain,
      'painfulUrination': instance.painfulUrination,
      'parentConfident': instance.parentConfident,
      'parentFeel': instance.parentFeel,
      'parentThink': instance.parentThink,
      'patientName': instance.patientName,
      'patientState': instance.patientState,
      'pulse': instance.pulse,
      'rash': instance.rash,
      'respiratoryRate': instance.respiratoryRate,
      'skinColor': instance.skinColor,
      'skinTurgor': instance.skinTurgor,
      'smellyUrine': instance.smellyUrine,
      'tearsWhenCrying': instance.tearsWhenCrying,
      'temperature': instance.temperature,
      'temperatureAdjusted': instance.temperatureAdjusted,
      'thermometerUsed': instance.thermometerUsed,
      'tongue': instance.tongue,
      'vaccinationsWithIn14days': instance.vaccinationsWithIn14days,
      'vaccinationsHowManyHoursAgo': instance.vaccinationsHowManyHoursAgo,
      'vaccinationsUsedVaccination': instance.vaccinationsUsedVaccination,
      'vomit': instance.vomit,
      'wheezing': instance.wheezing,
      'wryNeck': instance.wryNeck,
    };
