import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fever_friend_app/models/util.dart';
import 'package:fever_friend_app/services/get_it.dart';
import 'package:fever_friend_app/models/models.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'fever_measurement.g.dart';

@JsonSerializable(explicitToJson: true)
class MeasurementModel {
  @JsonKey(toJson: toNull, includeIfNull: false)
  String id;

  MeasurementModelMeta meta;
  MeasurementModelData data;

  MeasurementModel({
    required this.id,
    required this.data,
    required this.meta,
  });

  factory MeasurementModel.fromJson(Map<String, dynamic> json) =>
      _$MeasurementModelFromJson(json);

  factory MeasurementModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;

    data['id'] = doc.id;

    return _$MeasurementModelFromJson(data);
  }

  factory MeasurementModel.fromFormBuilder(
      FormBuilderState formState, Patient patient) {
    PackageInfo pi = getIt.get<PackageInfo>();
    final data = MeasurementModelData(
      feverSection: FeverSectionModel(
        feverDuration: formState.value[FeverFields.feverDuration.name],
        feverMeasurementLocation:
            formState.value[FeverFields.measurementLocation.name],
        temperature: formState.value[FeverFields.temperature.name],
        // TODO add calculating logic to screen
        temperatureAdjusted: null,
        thermometerUsed: formState.value[FeverFields.thermometerUsed.name],
      ),
      medicationSection: MedicationSectionModel(
        antibiotics: formState.value[MedicationFields.antibiotics.name],
        antibioticsHowMany:
            formState.value[MedicationFields.antibioticsHowMuch.name],
        antibioticsHowMuch:
            formState.value[MedicationFields.antibioticsHowMuch.name],
        antibioticsWhat: formState.value[MedicationFields.antibioticsWhat.name],
        antipyretic: formState.value[MedicationFields.antipyretic.name],
        antipyreticHowMany:
            formState.value[MedicationFields.antipyreticHowMany.name],
        antipyreticHowMuch:
            formState.value[MedicationFields.antipyreticHowMuch.name],
        antipyreticReason:
            formState.value[MedicationFields.antipyreticReason.name],
        antipyreticWhat: formState.value[MedicationFields.antipyreticWhat],
      ),
      hydrationSection: HydrationSectionModel(
        crying: formState.value[HydrationFields.crying.name],
        diarrhea: formState.value[HydrationFields.diarrhea.name],
        drinking: formState.value[HydrationFields.drinking.name],
        lastUrination: formState.value[HydrationFields.lastUrination.name],
        skinTurgor: formState.value[HydrationFields.skinTurgor.name],
        tearsWhenCrying: formState.value[HydrationFields.tearsWhenCrying.name],
        tongue: formState.value[HydrationFields.tongue.name],
        vomit: formState.value[HydrationFields.vomit.name],
      ),
      respirationSection: RespirationSectionModel(
        dyspnea: formState.value[RespirationFields.dyspnea.name],
        respiratoryRate:
            formState.value[RespirationFields.respiratoryRate.name],
        wheezing: formState.value[RespirationFields.wheezing.name],
      ),
      skinSection: SkinSectionModel(
        glassTest: formState.value[SkinFields.glassTest.name],
        rash: formState.value[SkinFields.rash.name],
        skinColor: formState.value[SkinFields.skinColor.name],
      ),
      pulseSection: PulseSectionModel(
        pulse: formState.value[PulseFields.pulse.name],
      ),
      generalSection: GeneralSectionModel(
        awareness: formState.value[GeneralFields.awareness.name],
        exoticTrip: formState.value[GeneralFields.exoticTrip.name],
        seizure: formState.value[GeneralFields.seizure.name],
        lastTimeEating: formState.value[GeneralFields.lastTimeEating.name],
        pain: formState.value[GeneralFields.pain.name],
        painfulUrination: formState.value[GeneralFields.painfulUrination.name],
        smellyUrine: formState.value[GeneralFields.smellyUrine.name],
        vaccinationHowManyHoursAgo:
            formState.value[GeneralFields.vaccinationHowManyHoursAgo.name],
        vaccinationIn14days:
            formState.value[GeneralFields.vaccinationIn14days.name],
        vaccinationWhat: formState.value[GeneralFields.vaccinationWhat.name],
        wryNeck: formState.value[GeneralFields.wryNeck.name],
      ),
      caregiverSection: CaregiverSectionModel(
        parentConfident: formState.value[CaregiverFields.parentConfident.name],
        parentFeel: formState.value[CaregiverFields.parentFeel.name],
        parentThink: formState.value[CaregiverFields.parentThink.name],
      ),
    );
    final meta = MeasurementModelMeta(
      createdAt: DateTime.now(),
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
    return MeasurementModel(id: 'n/a', data: data, meta: meta);
  }

  Map<String, dynamic> toJson() => _$MeasurementModelToJson(this);

  static toNull(_) => null;
}

@JsonSerializable()
class MeasurementModelMeta {
  // https://stackoverflow.com/a/53672255/13280594
  String appVersion;
  int numberOfQuestions;
  int anseredQuestions;
  double progressPercent;

  String? notificationIllnessReviewTask;
  String? notificationTask;

  @JsonKey(fromJson: fromTimestampToDate, toJson: fromDateToTimestamp)
  DateTime createdAt;

  @JsonKey(
      fromJson: fromTimestampToDateNullable,
      toJson: fromDateToTimestampNullable)
  DateTime? updatedAt;
  bool autosaved;
  bool saved;

  MeasurementModelMeta({
    required this.createdAt,
    required this.numberOfQuestions,
    this.appVersion = 'dev',
    this.anseredQuestions = 0,
    this.progressPercent = 0.0,
    this.autosaved = false,
    this.saved = false,
    this.updatedAt,
  });

  factory MeasurementModelMeta.fromJson(Map<String, dynamic> json) =>
      _$MeasurementModelMetaFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementModelMetaToJson(this);
}

@JsonSerializable()
class MeasurementModelData {
  FeverSectionModel? feverSection;
  MedicationSectionModel? medicationSection;
  HydrationSectionModel? hydrationSection;
  RespirationSectionModel? respirationSection;
  SkinSectionModel? skinSection;
  PulseSectionModel? pulseSection;
  GeneralSectionModel? generalSection;
  CaregiverSectionModel? caregiverSection;

  PatientState? patientState;

  MeasurementModelData({
    this.feverSection,
    this.medicationSection,
    this.hydrationSection,
    this.respirationSection,
    this.skinSection,
    this.pulseSection,
    this.generalSection,
    this.caregiverSection,
    this.patientState,
  });

  factory MeasurementModelData.fromJson(Map<String, dynamic> json) =>
      _$MeasurementModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementModelDataToJson(this);
}

@JsonSerializable()
class FeverSectionModel {
  String? feverDuration;
  String? feverMeasurementLocation;

  double? temperature;
  double? temperatureAdjusted;

  String? thermometerUsed;

  FeverSectionModel({
    this.thermometerUsed,
    this.feverDuration,
    this.feverMeasurementLocation,
    this.temperature,
    this.temperatureAdjusted,
  });

  factory FeverSectionModel.fromJson(Map<String, dynamic> json) =>
      _$FeverSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeverSectionModelToJson(this);
}

@JsonSerializable()
class MedicationSectionModel {
  String? antibiotics;
  int? antibioticsHowMany;
  double? antibioticsHowMuch;
  String? antibioticsWhat;

  String? antipyretic;
  int? antipyreticHowMany;
  double? antipyreticHowMuch;
  String? antipyreticReason;
  String? antipyreticWhat;

  MedicationSectionModel({
    this.antibiotics,
    this.antibioticsHowMany,
    this.antibioticsHowMuch,
    this.antibioticsWhat,
    this.antipyretic,
    this.antipyreticHowMany,
    this.antipyreticHowMuch,
    this.antipyreticReason,
    this.antipyreticWhat,
  });

  factory MedicationSectionModel.fromJson(Map<String, dynamic> json) =>
      _$MedicationSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicationSectionModelToJson(this);
}

@JsonSerializable()
class HydrationSectionModel {
  String? crying;
  String? diarrhea;
  String? drinking;
  String? lastUrination;
  String? skinTurgor;
  String? tearsWhenCrying;
  String? tongue;
  String? vomit;

  HydrationSectionModel({
    this.crying,
    this.diarrhea,
    this.drinking,
    this.lastUrination,
    this.skinTurgor,
    this.tearsWhenCrying,
    this.tongue,
    this.vomit,
  });

  factory HydrationSectionModel.fromJson(Map<String, dynamic> json) =>
      _$HydrationSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$HydrationSectionModelToJson(this);
}

@JsonSerializable()
class RespirationSectionModel {
  String? dyspnea;
  double? respiratoryRate;
  String? wheezing;

  RespirationSectionModel({
    this.dyspnea,
    this.respiratoryRate,
    this.wheezing,
  });

  factory RespirationSectionModel.fromJson(Map<String, dynamic> json) =>
      _$RespirationSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$RespirationSectionModelToJson(this);
}

@JsonSerializable()
class SkinSectionModel {
  String? glassTest;
  String? rash;
  String? skinColor;

  SkinSectionModel({
    this.glassTest,
    this.rash,
    this.skinColor,
  });

  factory SkinSectionModel.fromJson(Map<String, dynamic> json) =>
      _$SkinSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SkinSectionModelToJson(this);
}

@JsonSerializable()
class PulseSectionModel {
  double? pulse;

  PulseSectionModel({
    this.pulse,
  });

  factory PulseSectionModel.fromJson(Map<String, dynamic> json) =>
      _$PulseSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PulseSectionModelToJson(this);
}

@JsonSerializable()
class GeneralSectionModel {
  String? awareness;
  String? bulgingFontanelleMax18MOld;
  String? exoticTrip;
  String? lastTimeEating;
  List<String>? pain;
  String? painfulUrination;
  String? seizure;
  String? smellyUrine;
  String? vaccinationIn14days;
  String? vaccinationHowManyHoursAgo;
  String? vaccinationWhat;
  String? wryNeck;

  GeneralSectionModel({
    this.awareness,
    this.bulgingFontanelleMax18MOld,
    this.exoticTrip,
    this.lastTimeEating,
    this.pain,
    this.painfulUrination,
    this.seizure,
    this.smellyUrine,
    this.vaccinationHowManyHoursAgo,
    this.vaccinationIn14days,
    this.vaccinationWhat,
    this.wryNeck,
  });

  factory GeneralSectionModel.fromJson(Map<String, dynamic> json) =>
      _$GeneralSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralSectionModelToJson(this);
}

@JsonSerializable()
class CaregiverSectionModel {
  String? parentConfident;
  String? parentFeel;
  String? parentThink;

  CaregiverSectionModel({
    this.parentConfident,
    this.parentFeel,
    this.parentThink,
  });

  factory CaregiverSectionModel.fromJson(Map<String, dynamic> json) =>
      _$CaregiverSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CaregiverSectionModelToJson(this);
}
