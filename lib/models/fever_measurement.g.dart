// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fever_measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeasurementModel _$MeasurementModelFromJson(Map<String, dynamic> json) =>
    MeasurementModel(
      id: json['id'] as String,
      data: MeasurementModelData.fromJson(json['data'] as Map<String, dynamic>),
      meta: MeasurementModelMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeasurementModelToJson(MeasurementModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', MeasurementModel.toNull(instance.id));
  val['meta'] = instance.meta.toJson();
  val['data'] = instance.data.toJson();
  return val;
}

MeasurementModelMeta _$MeasurementModelMetaFromJson(
        Map<String, dynamic> json) =>
    MeasurementModelMeta(
      createdAt: fromTimestampToDate(json['createdAt'] as Timestamp),
      numberOfQuestions: json['numberOfQuestions'] as int,
      appVersion: json['appVersion'] as String? ?? 'dev',
      anseredQuestions: json['anseredQuestions'] as int? ?? 0,
      progressPercent: (json['progressPercent'] as num?)?.toDouble() ?? 0.0,
      autosaved: json['autosaved'] as bool? ?? false,
      saved: json['saved'] as bool? ?? false,
      updatedAt: fromTimestampToDateNullable(json['updatedAt'] as Timestamp?),
    )
      ..notificationIllnessReviewTask =
          json['notificationIllnessReviewTask'] as String?
      ..notificationTask = json['notificationTask'] as String?;

Map<String, dynamic> _$MeasurementModelMetaToJson(
        MeasurementModelMeta instance) =>
    <String, dynamic>{
      'appVersion': instance.appVersion,
      'numberOfQuestions': instance.numberOfQuestions,
      'anseredQuestions': instance.anseredQuestions,
      'progressPercent': instance.progressPercent,
      'notificationIllnessReviewTask': instance.notificationIllnessReviewTask,
      'notificationTask': instance.notificationTask,
      'createdAt': fromDateToTimestamp(instance.createdAt),
      'updatedAt': fromDateToTimestampNullable(instance.updatedAt),
      'autosaved': instance.autosaved,
      'saved': instance.saved,
    };

MeasurementModelData _$MeasurementModelDataFromJson(
        Map<String, dynamic> json) =>
    MeasurementModelData(
      feverSection: json['feverSection'] == null
          ? null
          : FeverSectionModel.fromJson(
              json['feverSection'] as Map<String, dynamic>),
      medicationSection: json['medicationSection'] == null
          ? null
          : MedicationSectionModel.fromJson(
              json['medicationSection'] as Map<String, dynamic>),
      hydrationSection: json['hydrationSection'] == null
          ? null
          : HydrationSectionModel.fromJson(
              json['hydrationSection'] as Map<String, dynamic>),
      respirationSection: json['respirationSection'] == null
          ? null
          : RespirationSectionModel.fromJson(
              json['respirationSection'] as Map<String, dynamic>),
      skinSection: json['skinSection'] == null
          ? null
          : SkinSectionModel.fromJson(
              json['skinSection'] as Map<String, dynamic>),
      pulseSection: json['pulseSection'] == null
          ? null
          : PulseSectionModel.fromJson(
              json['pulseSection'] as Map<String, dynamic>),
      generalSection: json['generalSection'] == null
          ? null
          : GeneralSectionModel.fromJson(
              json['generalSection'] as Map<String, dynamic>),
      caregiverSection: json['caregiverSection'] == null
          ? null
          : CaregiverSectionModel.fromJson(
              json['caregiverSection'] as Map<String, dynamic>),
      patientState:
          $enumDecodeNullable(_$PatientStateEnumMap, json['patientState']),
    );

Map<String, dynamic> _$MeasurementModelDataToJson(
        MeasurementModelData instance) =>
    <String, dynamic>{
      'feverSection': instance.feverSection,
      'medicationSection': instance.medicationSection,
      'hydrationSection': instance.hydrationSection,
      'respirationSection': instance.respirationSection,
      'skinSection': instance.skinSection,
      'pulseSection': instance.pulseSection,
      'generalSection': instance.generalSection,
      'caregiverSection': instance.caregiverSection,
      'patientState': _$PatientStateEnumMap[instance.patientState],
    };

const _$PatientStateEnumMap = {
  PatientState.good: 'good',
  PatientState.caution: 'caution',
  PatientState.danger: 'danger',
};

FeverSectionModel _$FeverSectionModelFromJson(Map<String, dynamic> json) =>
    FeverSectionModel(
      thermometerUsed: json['thermometerUsed'] as String?,
      feverDuration: json['feverDuration'] as String?,
      feverMeasurementLocation: json['feverMeasurementLocation'] as String?,
      temperature: (json['temperature'] as num?)?.toDouble(),
      temperatureAdjusted: (json['temperatureAdjusted'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FeverSectionModelToJson(FeverSectionModel instance) =>
    <String, dynamic>{
      'feverDuration': instance.feverDuration,
      'feverMeasurementLocation': instance.feverMeasurementLocation,
      'temperature': instance.temperature,
      'temperatureAdjusted': instance.temperatureAdjusted,
      'thermometerUsed': instance.thermometerUsed,
    };

MedicationSectionModel _$MedicationSectionModelFromJson(
        Map<String, dynamic> json) =>
    MedicationSectionModel(
      antibiotics: json['antibiotics'] as String?,
      antibioticsHowMany: json['antibioticsHowMany'] as int?,
      antibioticsHowMuch: (json['antibioticsHowMuch'] as num?)?.toDouble(),
      antibioticsWhat: json['antibioticsWhat'] as String?,
      antipyretic: json['antipyretic'] as String?,
      antipyreticHowMany: json['antipyreticHowMany'] as int?,
      antipyreticHowMuch: (json['antipyreticHowMuch'] as num?)?.toDouble(),
      antipyreticReason: json['antipyreticReason'] as String?,
      antipyreticWhat: json['antipyreticWhat'] as String?,
    );

Map<String, dynamic> _$MedicationSectionModelToJson(
        MedicationSectionModel instance) =>
    <String, dynamic>{
      'antibiotics': instance.antibiotics,
      'antibioticsHowMany': instance.antibioticsHowMany,
      'antibioticsHowMuch': instance.antibioticsHowMuch,
      'antibioticsWhat': instance.antibioticsWhat,
      'antipyretic': instance.antipyretic,
      'antipyreticHowMany': instance.antipyreticHowMany,
      'antipyreticHowMuch': instance.antipyreticHowMuch,
      'antipyreticReason': instance.antipyreticReason,
      'antipyreticWhat': instance.antipyreticWhat,
    };

HydrationSectionModel _$HydrationSectionModelFromJson(
        Map<String, dynamic> json) =>
    HydrationSectionModel(
      crying: json['crying'] as String?,
      diarrhea: json['diarrhea'] as String?,
      drinking: json['drinking'] as String?,
      lastUrination: json['lastUrination'] as String?,
      skinTurgor: json['skinTurgor'] as String?,
      tearsWhenCrying: json['tearsWhenCrying'] as String?,
      tongue: json['tongue'] as String?,
      vomit: json['vomit'] as String?,
    );

Map<String, dynamic> _$HydrationSectionModelToJson(
        HydrationSectionModel instance) =>
    <String, dynamic>{
      'crying': instance.crying,
      'diarrhea': instance.diarrhea,
      'drinking': instance.drinking,
      'lastUrination': instance.lastUrination,
      'skinTurgor': instance.skinTurgor,
      'tearsWhenCrying': instance.tearsWhenCrying,
      'tongue': instance.tongue,
      'vomit': instance.vomit,
    };

RespirationSectionModel _$RespirationSectionModelFromJson(
        Map<String, dynamic> json) =>
    RespirationSectionModel(
      dyspnea: json['dyspnea'] as String?,
      respiratoryRate: (json['respiratoryRate'] as num?)?.toDouble(),
      wheezing: json['wheezing'] as String?,
    );

Map<String, dynamic> _$RespirationSectionModelToJson(
        RespirationSectionModel instance) =>
    <String, dynamic>{
      'dyspnea': instance.dyspnea,
      'respiratoryRate': instance.respiratoryRate,
      'wheezing': instance.wheezing,
    };

SkinSectionModel _$SkinSectionModelFromJson(Map<String, dynamic> json) =>
    SkinSectionModel(
      glassTest: json['glassTest'] as String?,
      rash: json['rash'] as String?,
      skinColor: json['skinColor'] as String?,
    );

Map<String, dynamic> _$SkinSectionModelToJson(SkinSectionModel instance) =>
    <String, dynamic>{
      'glassTest': instance.glassTest,
      'rash': instance.rash,
      'skinColor': instance.skinColor,
    };

PulseSectionModel _$PulseSectionModelFromJson(Map<String, dynamic> json) =>
    PulseSectionModel(
      pulse: (json['pulse'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PulseSectionModelToJson(PulseSectionModel instance) =>
    <String, dynamic>{
      'pulse': instance.pulse,
    };

GeneralSectionModel _$GeneralSectionModelFromJson(Map<String, dynamic> json) =>
    GeneralSectionModel(
      awareness: json['awareness'] as String?,
      bulgingFontanelleMax18MOld: json['bulgingFontanelleMax18MOld'] as String?,
      exoticTrip: json['exoticTrip'] as String?,
      lastTimeEating: json['lastTimeEating'] as String?,
      pain: (json['pain'] as List<dynamic>?)?.map((e) => e as String).toList(),
      painfulUrination: json['painfulUrination'] as String?,
      seizure: json['seizure'] as String?,
      smellyUrine: json['smellyUrine'] as String?,
      vaccinationHowManyHoursAgo: json['vaccinationHowManyHoursAgo'] as String?,
      vaccinationIn14days: json['vaccinationIn14days'] as String?,
      vaccinationWhat: json['vaccinationWhat'] as String?,
      wryNeck: json['wryNeck'] as String?,
    );

Map<String, dynamic> _$GeneralSectionModelToJson(
        GeneralSectionModel instance) =>
    <String, dynamic>{
      'awareness': instance.awareness,
      'bulgingFontanelleMax18MOld': instance.bulgingFontanelleMax18MOld,
      'exoticTrip': instance.exoticTrip,
      'lastTimeEating': instance.lastTimeEating,
      'pain': instance.pain,
      'painfulUrination': instance.painfulUrination,
      'seizure': instance.seizure,
      'smellyUrine': instance.smellyUrine,
      'vaccinationIn14days': instance.vaccinationIn14days,
      'vaccinationHowManyHoursAgo': instance.vaccinationHowManyHoursAgo,
      'vaccinationWhat': instance.vaccinationWhat,
      'wryNeck': instance.wryNeck,
    };

CaregiverSectionModel _$CaregiverSectionModelFromJson(
        Map<String, dynamic> json) =>
    CaregiverSectionModel(
      parentConfident: json['parentConfident'] as String?,
      parentFeel: json['parentFeel'] as String?,
      parentThink: json['parentThink'] as String?,
    );

Map<String, dynamic> _$CaregiverSectionModelToJson(
        CaregiverSectionModel instance) =>
    <String, dynamic>{
      'parentConfident': instance.parentConfident,
      'parentFeel': instance.parentFeel,
      'parentThink': instance.parentThink,
    };
