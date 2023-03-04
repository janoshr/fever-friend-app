import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fever_friend_app/models/fever_model_encode.dart';
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
  MeasurementModelState? state;

  MeasurementModel({
    required this.id,
    required this.data,
    required this.meta,
    this.state,
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
      feverSection: FeverSectionModel.fromFormBuilder(formState),
      medicationSection: MedicationSectionModel.fromFormBuilder(formState),
      hydrationSection: HydrationSectionModel.fromFormBuilder(formState),
      respirationSection: RespirationSectionModel.fromFormBuilder(formState),
      skinSection: SkinSectionModel.fromFormBuilder(formState),
      pulseSection: PulseSectionModel.fromFormBuilder(formState),
      generalSection: GeneralSectionModel.fromFormBuilder(formState),
      caregiverSection: CaregiverSectionModel.fromFormBuilder(formState),
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
class MeasurementModelState {
  PatientState? patientState;
  PatientState? feverState;
  PatientState? medicationState;
  PatientState? hydrationState;
  PatientState? respirationState;
  PatientState? skinState;
  PatientState? pulseState;
  PatientState? generalState;
  PatientState? caregiverState;

  MeasurementModelState({
    this.caregiverState,
    this.feverState,
    this.generalState,
    this.hydrationState,
    this.medicationState,
    this.patientState,
    this.pulseState,
    this.skinState,
    this.respirationState,
  });

  Map<String, PatientState?> toMap() => {
        'caregiverState': caregiverState,
        'feverState': feverState,
        'generalState': generalState,
        'hydrationState': hydrationState,
        'medicationState': medicationState,
        'patientState': patientState,
        'pulseState': pulseState,
        'skinState': skinState,
        'respirationState': respirationState,
      };

  // PatientState? operator [](String value) {
  //   return toMap()[value];
  // }

  Map<String, dynamic> toJson() => _$MeasurementModelStateToJson(this);

  factory MeasurementModelState.fromJson(Map<String, dynamic> json) =>
      _$MeasurementModelStateFromJson(json);
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
  @JsonKey(includeIfNull: false)
  FeverSectionModel? feverSection;

  @JsonKey(includeIfNull: false)
  MedicationSectionModel? medicationSection;

  @JsonKey(includeIfNull: false)
  HydrationSectionModel? hydrationSection;

  @JsonKey(includeIfNull: false)
  RespirationSectionModel? respirationSection;

  @JsonKey(includeIfNull: false)
  SkinSectionModel? skinSection;

  @JsonKey(includeIfNull: false)
  PulseSectionModel? pulseSection;

  @JsonKey(includeIfNull: false)
  GeneralSectionModel? generalSection;

  @JsonKey(includeIfNull: false)
  CaregiverSectionModel? caregiverSection;

  MeasurementModelData({
    this.feverSection,
    this.medicationSection,
    this.hydrationSection,
    this.respirationSection,
    this.skinSection,
    this.pulseSection,
    this.generalSection,
    this.caregiverSection,
  });

  int get sectionCount => sectionMap.entries
      .fold(0, (value, element) => element.value != null ? value + 1 : value);

  Map<MeasurementSections, dynamic> get sectionMap => {
        MeasurementSections.fever: feverSection,
        MeasurementSections.medication: medicationSection,
        MeasurementSections.hydration: hydrationSection,
        MeasurementSections.respiration: respirationSection,
        MeasurementSections.skin: skinSection,
        MeasurementSections.pulse: pulseSection,
        MeasurementSections.general: generalSection,
        MeasurementSections.caregiver: caregiverSection,
      };

  factory MeasurementModelData.fromJson(Map<String, dynamic> json) =>
      _$MeasurementModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementModelDataToJson(this);

  Map<String, num> get modelData {
    //  'feverDuration', 'temperature', 'antibiotics',
    //  'antibioticsHowMany', 'antibioticsHowMuch', 'antipyretic',
    //  'antipyreticHowMany', 'antipyreticHowMuch', 'crying', 'diarrhea',
    //  'drinking', 'lastUrination', 'skinTurgor', 'tearsWhenCrying', 'tongue',
    //  'dyspnea', 'respiratoryRate', 'wheezing', 'glassTest', 'rash',
    //  'skinColor', 'pulse', 'bulgingFontanelleMax18MOld', 'exoticTrip',
    //  'lastTimeEating', 'painfulUrination', 'seizure', 'smellyUrine',
    //  'vaccinationIn14days', 'vaccinationHowManyHoursAgo', 'wryNeck',
    //  'pain-01-No', 'pain-02-FeelingBad', 'pain-03-Headache',
    //  'pain-04-SwollenPainful', 'pain-05-StrongBellyacheAche',
    //  'awareness-01-Normal', 'awareness-02-SleepyOddOrFeverishNightmares',
    //  'awareness-03-NoReactionsNoAwareness', 'vomit-01-No', 'vomit-02-Slight',
    //  'vomit-03-Frequent', 'vomit-04-Yellow', 'vomit-05-5<hours'
    return encodeMeasurement(this);
  }
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

  static FeverSectionModel? fromFormBuilder(FormBuilderState formState) {
    if (FeverFields.values
        .every((element) => formState.value[element.name] == null)) {
      return null;
    }
    return FeverSectionModel(
      feverDuration: formState.value[FeverFields.feverDuration.name],
      feverMeasurementLocation:
          formState.value[FeverFields.measurementLocation.name],
      temperature: double.parse(formState.value[FeverFields.temperature.name]),
      // TODO add calculating logic to screen
      temperatureAdjusted: null,
      thermometerUsed: formState.value[FeverFields.thermometerUsed.name],
    );
  }

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
  List<String>? antipyreticWhat;

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

  static MedicationSectionModel? fromFormBuilder(FormBuilderState formState) {
    if (MedicationFields.values
        .every((element) => formState.value[element.name] == null)) {
      return null;
    }

    return MedicationSectionModel(
      antibiotics: formState.value[MedicationFields.antibiotics.name],
      antibioticsHowMany:
          formState.value[MedicationFields.antibioticsHowMuch.name] != null
              ? int.tryParse(
                  formState.value[MedicationFields.antibioticsHowMuch.name])
              : null,
      antibioticsHowMuch:
          formState.value[MedicationFields.antibioticsHowMuch.name] != null
              ? double.tryParse(
                  formState.value[MedicationFields.antibioticsHowMuch.name])
              : null,
      antibioticsWhat: formState.value[MedicationFields.antibioticsWhat.name],
      antipyretic: formState.value[MedicationFields.antipyretic.name],
      antipyreticHowMany:
          formState.value[MedicationFields.antipyreticHowMany.name] != null
              ? int.tryParse(
                  formState.value[MedicationFields.antipyreticHowMany.name])
              : null,
      antipyreticHowMuch:
          formState.value[MedicationFields.antipyreticHowMuch.name] != null
              ? double.tryParse(
                  formState.value[MedicationFields.antipyreticHowMuch.name])
              : null,
      antipyreticReason:
          formState.value[MedicationFields.antipyreticReason.name],
      antipyreticWhat:
          formState.value[MedicationFields.antipyreticWhat.name] != null
              ? List<String>.from(
                  formState.value[MedicationFields.antipyreticWhat.name])
              : null,
    );
  }

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
  List<String>? vomit;

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

  static HydrationSectionModel? fromFormBuilder(FormBuilderState formState) {
    if (HydrationFields.values
        .every((element) => formState.value[element.name] == null)) {
      return null;
    }

    return HydrationSectionModel(
      crying: formState.value[HydrationFields.crying.name],
      diarrhea: formState.value[HydrationFields.diarrhea.name],
      drinking: formState.value[HydrationFields.drinking.name],
      lastUrination: formState.value[HydrationFields.lastUrination.name],
      skinTurgor: formState.value[HydrationFields.skinTurgor.name],
      tearsWhenCrying: formState.value[HydrationFields.tearsWhenCrying.name],
      tongue: formState.value[HydrationFields.tongue.name],
      vomit: formState.value[HydrationFields.vomit.name] != null
          ? List<String>.from(formState.value[HydrationFields.vomit.name])
          : null,
    );
  }

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

  static RespirationSectionModel? fromFormBuilder(FormBuilderState formState) {
    if (RespirationFields.values
        .every((element) => formState.value[element.name] == null)) {
      return null;
    }

    return RespirationSectionModel(
      dyspnea: formState.value[RespirationFields.dyspnea.name],
      respiratoryRate:
          formState.value[RespirationFields.respiratoryRate.name] != null
              ? double.tryParse(
                  formState.value[RespirationFields.respiratoryRate.name])
              : null,
      wheezing: formState.value[RespirationFields.wheezing.name],
    );
  }

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

  static SkinSectionModel? fromFormBuilder(FormBuilderState formState) {
    if (SkinFields.values
        .every((element) => formState.value[element.name] == null)) {
      return null;
    }

    return SkinSectionModel(
      glassTest: formState.value[SkinFields.glassTest.name],
      rash: formState.value[SkinFields.rash.name],
      skinColor: formState.value[SkinFields.skinColor.name],
    );
  }

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

  static PulseSectionModel? fromFormBuilder(FormBuilderState formState) {
    if (PulseFields.values
        .every((element) => formState.value[element.name] == null)) {
      return null;
    }

    return PulseSectionModel(
      pulse: formState.value[PulseFields.pulse.name] != null
          ? double.tryParse(formState.value[PulseFields.pulse.name])
          : null,
    );
  }

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

  static GeneralSectionModel? fromFormBuilder(FormBuilderState formState) {
    if (GeneralFields.values
        .every((element) => formState.value[element.name] == null)) {
      return null;
    }

    return GeneralSectionModel(
      awareness: formState.value[GeneralFields.awareness.name],
      exoticTrip: formState.value[GeneralFields.exoticTrip.name],
      seizure: formState.value[GeneralFields.seizure.name],
      lastTimeEating: formState.value[GeneralFields.lastTimeEating.name],
      pain: formState.value[GeneralFields.pain.name] != null
          ? List<String>.from(formState.value[GeneralFields.pain.name])
          : null,
      painfulUrination: formState.value[GeneralFields.painfulUrination.name],
      smellyUrine: formState.value[GeneralFields.smellyUrine.name],
      vaccinationHowManyHoursAgo:
          formState.value[GeneralFields.vaccinationHowManyHoursAgo.name],
      vaccinationIn14days:
          formState.value[GeneralFields.vaccinationIn14days.name],
      vaccinationWhat: formState.value[GeneralFields.vaccinationWhat.name],
      wryNeck: formState.value[GeneralFields.wryNeck.name],
    );
  }

  factory GeneralSectionModel.fromJson(Map<String, dynamic> json) =>
      _$GeneralSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralSectionModelToJson(this);
}

@JsonSerializable()
class CaregiverSectionModel {
  String? caregiverConfident;
  String? caregiverFeel;
  String? caregiverThink;

  CaregiverSectionModel({
    this.caregiverConfident,
    this.caregiverFeel,
    this.caregiverThink,
  });

  static CaregiverSectionModel? fromFormBuilder(FormBuilderState formState) {
    if (CaregiverFields.values
        .every((element) => formState.value[element.name] == null)) {
      return null;
    }

    return CaregiverSectionModel(
      caregiverConfident:
          formState.value[CaregiverFields.caregiverConfident.name],
      caregiverFeel: formState.value[CaregiverFields.caregiverFeel.name],
      caregiverThink: formState.value[CaregiverFields.caregiverThink.name],
    );
  }

  factory CaregiverSectionModel.fromJson(Map<String, dynamic> json) =>
      _$CaregiverSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CaregiverSectionModelToJson(this);
}
