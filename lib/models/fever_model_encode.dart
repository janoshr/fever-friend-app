import 'package:fever_friend_app/models/models.dart';

enum _OrdinalCategories {
  antibiotics,
  antibioticsHowMany,
  antibioticsHowMuch,
  antipyretic,
  antipyreticHowMany,
  antipyreticHowMuch,
  bulgingFontanelleMax18MOld,
  diarrhea,
  crying,
  drinking,
  dyspnea,
  exoticTrip,
  seizure,
  feverDuration,
  glassTest,
  lastTimeEating,
  lastUrination,
  painfulUrination,
  rash,
  skinColor,
  skinTurgor,
  smellyUrine,
  tearsWhenCrying,
  tongue,
  vaccinationIn14days,
  vaccinationHowManyHoursAgo,
  wheezing,
  wryNeck,
}

const _ordinalCategories = {
  _OrdinalCategories.antibiotics: {
    'antibiotics': 0,
    'antibiotics-01-No': 0,
    'antibiotics-02-Yes': 1,
  },
  _OrdinalCategories.antibioticsHowMany: {
    'antibioticsHowMany': 0,
    'antibioticsHowManyTimes01-1': 1,
    'antibioticsHowManyTimes02-2': 2,
    'antibioticsHowManyTimes03-3': 3,
    'antibioticsHowManyTimes04-4': 4,
    'antibioticsHowManyTimes05-5': 5,
    'antibioticsHowManyTimes06-MoreThan5': 6,
  },
  _OrdinalCategories.antibioticsHowMuch: {
    'antibioticsHowMuch': 0,
    'antibioticsHowMuch01-50mg': 50,
    'antibioticsHowMuch02-75mg': 75,
    'antibioticsHowMuch03-100mg': 100,
    'antibioticsHowMuch04-125mg': 125,
    'antibioticsHowMuch05-150mg': 150,
    'antibioticsHowMuch06-175mg': 175,
    'antibioticsHowMuch07-200mg': 200,
    'antibioticsHowMuch08-225mg': 225,
    'antibioticsHowMuch09-250mg': 250,
    'antibioticsHowMuch10-300mg': 300,
    'antibioticsHowMuch11-350mg': 350,
    'antibioticsHowMuch12-400mg': 400,
    'antibioticsHowMuch13-450mg': 450,
    'antibioticsHowMuch14-500mg': 500,
    'antibioticsHowMuch15-MoreThan500': 600,
  },
  _OrdinalCategories.antipyretic: {
    'antipyretic': 0,
    'antipyreticMedication-01-No': 0,
    'antipyreticMedication-02-Yes': 1,
  },
  _OrdinalCategories.antipyreticHowMany: {
    'antipyreticHowMany': 0,
    'antipyreticMedicationHowManyTimes01-1': 1,
    'antipyreticMedicationHowManyTimes02-2': 2,
    'antipyreticMedicationHowManyTimes03-3': 3,
    'antipyreticMedicationHowManyTimes04-4': 4,
    'antipyreticMedicationHowManyTimes05-5': 5,
    'antipyreticMedicationHowManyTimes06-MoreThan5': 6,
  },
  _OrdinalCategories.antipyreticHowMuch: {
    'antipyreticHowMuch': 0,
    'antipyreticMedicationHowMuch01-50mg': 50,
    'antipyreticMedicationHowMuch02-75mg': 75,
    'antipyreticMedicationHowMuch03-100mg': 100,
    'antipyreticMedicationHowMuch04-125mg': 125,
    'antipyreticMedicationHowMuch05-150mg': 150,
    'antipyreticMedicationHowMuch06-175mg': 175,
    'antipyreticMedicationHowMuch07-200mg': 200,
    'antipyreticMedicationHowMuch08-225mg': 225,
    'antipyreticMedicationHowMuch09-250mg': 250,
    'antipyreticMedicationHowMuch10-300mg': 300,
    'antipyreticMedicationHowMuch11-350mg': 350,
    'antipyreticMedicationHowMuch12-400mg': 400,
    'antipyreticMedicationHowMuch13-450mg': 450,
    'antipyreticMedicationHowMuch14-500mg': 500,
    'antipyreticMedicationHowMuch15-MoreThan500': 600,
  },
  _OrdinalCategories.bulgingFontanelleMax18MOld: {
    'bulgingFontanelleMax18MOld': 0,
    'bulgingFontanelleMax18MOld-01-No': 0,
    'bulgingFontanelleMax18MOld-02-Yes': 1,
  },
  _OrdinalCategories.diarrhea: {
    'diarrhea': 0,
    'diarrhea-01-NoOrSlight': 0,
    'diarrhea-02-Frequent': 1,
    'diarrhea-03-FrequentAndBloody': 2,
  },
  _OrdinalCategories.crying: {
    'crying': 0,
    'crying-01-DoesntCry': 0,
    'crying-02-NormalBoldCrying': 1,
    'crying-03-ContinuousWithUnusuallyHighPitch': 2,
    'crying-04-Weak': 3,
  },
  _OrdinalCategories.drinking: {
    'drinking': 0,
    'drinking-01-Normal': 0,
    'drinking-02-LessThanNormal': 1,
    'drinking-03-NotFor12Hours': 3,
  },
  _OrdinalCategories.dyspnea: {
    'dyspnea': 1,
    'dyspnea-01-1': 1,
    'dyspnea-02-2': 2,
    'dyspnea-03-3': 3,
    'dyspnea-04-4': 4,
    'dyspnea-05-5': 5,
  },
  _OrdinalCategories.exoticTrip: {
    'exoticTrip': 0,
    'exoticTrip-01-No': 0,
    'exoticTrip-02-Yes': 1,
  },
  _OrdinalCategories.seizure: {
    'seizure': 0,
    'seizure-01-No': 0,
    'seizure-02-Yes': 1,
  },
  _OrdinalCategories.feverDuration: {
    'feverDuration': 1,
    'feverDuration-01-3>days': 1,
    'feverDuration-02-5>=days>3': 3,
    'feverDuration-03-days>=5': 5,
  },
  _OrdinalCategories.glassTest: {
    'glassTest': 0,
    'glassTest-01-RedDisappears': 0,
    'glassTest-02-RedRemains': 1,
  },
  _OrdinalCategories.lastTimeEating: {
    'lastTimeEating': 0,
    'lastTimeEating-01-<12hours': 0,
    'lastTimeEating-02-12<=<24hours': 12,
    'lastTimeEating-03->24hours': 24,
  },
  _OrdinalCategories.lastUrination: {
    'lastUrination': 0,
    'lastUrination-01-6>hours': 0,
    'lastUrination-02-6<=hours<12': 6,
    'lastUrination-03-12<hours':
        12, // ! error corrected in key was `lastUrination-01-12<hours`
  },
  _OrdinalCategories.painfulUrination: {
    'painfulUrination': 0,
    'painfulUrination-01-No': 0,
    'painfulUrination-02-Yes': 1,
  },
  _OrdinalCategories.rash: {
    'rash': 0,
    'rash-01-No': 0,
    'rash-02-Yes': 1,
  },
  _OrdinalCategories.skinColor: {
    'skinColor': 0,
    'skinColor-01-NormalSlightlyPale': 0,
    'skinColor-02-Pale': 1,
    'skinColor-03-GreyBlueCyanotic': 2,
  },
  _OrdinalCategories.skinTurgor: {
    'skinTurgor': 0,
    'skinTurgor-01-Normal': 0,
    'skinTurgor-02-SomewhatDecreased': 1,
    'skinTurgor-03-SeverelyDecreased': 2,
  },
  _OrdinalCategories.smellyUrine: {
    'smellyUrine': 0,
    'smellyUrine-01-No': 0,
    'smellyUrine-02-Yes': 1,
  },
  _OrdinalCategories.tearsWhenCrying: {
    'tearsWhenCrying': 0,
    'tearsWhenCrying-01-Yes': 0,
    'tearsWhenCrying-02-NotSoMuch': 1,
    'tearsWhenCrying-03-No': 2,
  },
  _OrdinalCategories.tongue: {
    'tongue': 0,
    'tongue-01-Wet': 0,
    'tongue-02-Dry': 1,
  },
  _OrdinalCategories.vaccinationIn14days: {
    'vaccinationIn14days': 0,
    'vaccinationIn14days-01-No': 0,
    'vaccinationIn14days-02-Yes': 1,
  },
  _OrdinalCategories.vaccinationHowManyHoursAgo: {
    'vaccinationHowManyHoursAgo': 0,
    'vaccinationsHowManyHoursAgo-01-Within48h': 1,
    'vaccinationsHowManyHoursAgo-02-Beyond48h': 2,
  },
  _OrdinalCategories.wheezing: {
    'wheezing': 0,
    'wheezing-01-No': 0,
    'wheezing-02-SomewhatYes': 1,
    'wheezing-03-Stridor': 2,
  },
  _OrdinalCategories.wryNeck: {
    'wryNeck': 0,
    'wryNeck-01-No': 0,
    'wryNeck-02-Yes': 1,
  }
};

enum _OneHotCategories {
  pain,
  awareness,
  patientState,
  vomit,
}

const _oneHotCategories = {
  _OneHotCategories.pain: [
    'pain-01-No',
    'pain-02-FeelingBad',
    'pain-03-Headache',
    'pain-04-SwollenPainful',
    'pain-05-StrongBellyacheAche'
  ],
  // Excluded because irrelevant
  // 'antipyreticWhat': [
  //     'antipyreticMedicationWhat-01-Paracetamol',
  //     'antipyreticMedicationWhat-02-Ibuprofen',
  //     'antipyreticMedicationWhat-03-Aminophenason',
  //     'antipyreticMedicationWhat-04-Diclofenac',
  //     'antipyreticMedicationWhat-05-Metamizol',
  //     'antipyreticMedicationWhat-06-Other',
  // ],
  _OneHotCategories.awareness: [
    'awareness-01-Normal',
    'awareness-02-SleepyOddOrFeverishNightmares',
    'awareness-03-NoReactionsNoAwareness',
  ],
  _OneHotCategories.patientState: [
    'good',
    'caution',
    'danger',
  ],
  _OneHotCategories.vomit: [
    'vomit-01-No',
    'vomit-02-Slight',
    'vomit-03-Frequent',
    'vomit-04-Yellow',
    'vomit-05-5<hours',
  ]
};

Map<String, num> _oneHotEncoder(_OneHotCategories category, String? data) {
  final res = <String, num>{};
  final cols = _oneHotCategories[category];
  for (final col in cols!) {
    res[col] = col == data ? 1 : 0;
  }
  if (res.values.every((element) => element == 0)) {
    // setting default if all are null
    res[cols.first] = 1;
  }
  return res;
}

Map<String, num> _oneHotArrayEncoder(_OneHotCategories category, List<String>? data) {
  final res = <String, num>{};
  final cols = _oneHotCategories[category];
  for (final col in cols!) {
    final has = data?.contains(col);
    res[col] = has != null && has ? 1 : 0;
  }
  if (res.values.every((element) => element == 0) || data == null) {
    res[cols.first] = 1;
  }
  return res;
}

int _ordinalEncoder(_OrdinalCategories category, String? data) {
  final vals = _ordinalCategories[category]!;
  if (vals.containsKey(data)) {
    return vals[data]!;
  } else {
    return vals[category.name]!;
  }
}

Map<String, num> encodeMeasurement(MeasurementModelData modelData) {
  Map<String, num> res = {};
  if (modelData.respirationSection == null ||
      modelData.respirationSection!.respiratoryRate == null) {
    throw Exception('Model error: missing respiratory rate');
  } else if (modelData.pulseSection == null ||
      modelData.pulseSection!.pulse == null) {
    throw Exception('Model error: missing pulse');
  }
  Map<String, num> ordinalMapping = {
    'feverDuration': _ordinalEncoder(_OrdinalCategories.feverDuration,
        modelData.feverSection?.feverDuration),
    'temperature': modelData.feverSection!.temperatureAdjusted!,
    'antibiotics': _ordinalEncoder(_OrdinalCategories.antibiotics,
        modelData.medicationSection?.antibiotics),
    'antibioticsHowMany': modelData.medicationSection?.antibioticsHowMany ?? 0,
    'antibioticsHowMuch': modelData.medicationSection?.antibioticsHowMuch ?? 0,
    'antipyretic': _ordinalEncoder(_OrdinalCategories.antipyretic,
        modelData.medicationSection?.antipyretic),
    'antipyreticHowMany': modelData.medicationSection?.antipyreticHowMany ?? 0,
    'antipyreticHowMuch': modelData.medicationSection?.antipyreticHowMuch ?? 0,
    'crying': _ordinalEncoder(
        _OrdinalCategories.crying, modelData.hydrationSection?.crying),
    'diarrhea': _ordinalEncoder(
        _OrdinalCategories.diarrhea, modelData.hydrationSection?.diarrhea),
    'drinking': _ordinalEncoder(
        _OrdinalCategories.drinking, modelData.hydrationSection?.drinking),
    'lastUrination': _ordinalEncoder(_OrdinalCategories.lastUrination,
        modelData.hydrationSection?.lastUrination),
    'skinTurgor': _ordinalEncoder(
        _OrdinalCategories.skinTurgor, modelData.hydrationSection?.skinTurgor),
    'tearsWhenCrying': _ordinalEncoder(_OrdinalCategories.tearsWhenCrying,
        modelData.hydrationSection?.tearsWhenCrying),
    'tongue': _ordinalEncoder(
        _OrdinalCategories.tongue, modelData.hydrationSection?.tongue),
    'dyspnea': _ordinalEncoder(
        _OrdinalCategories.dyspnea, modelData.respirationSection?.dyspnea),
    'respiratoryRate':
        modelData.respirationSection!.respiratoryRate!, // throws if missing
    'wheezing': _ordinalEncoder(
        _OrdinalCategories.wheezing, modelData.respirationSection?.wheezing),
    'glassTest': _ordinalEncoder(
        _OrdinalCategories.glassTest, modelData.skinSection?.glassTest),
    'rash':
        _ordinalEncoder(_OrdinalCategories.rash, modelData.skinSection?.rash),
    'skinColor': _ordinalEncoder(
        _OrdinalCategories.skinColor, modelData.skinSection?.skinColor),
    'pulse': modelData.pulseSection!.pulse!, // throws if missing
    'bulgingFontanelleMax18MOld': _ordinalEncoder(
        _OrdinalCategories.bulgingFontanelleMax18MOld,
        modelData.generalSection?.bulgingFontanelleMax18MOld),
    'exoticTrip': _ordinalEncoder(
        _OrdinalCategories.exoticTrip, modelData.generalSection?.exoticTrip),
    'lastTimeEating': _ordinalEncoder(_OrdinalCategories.lastTimeEating,
        modelData.generalSection?.lastTimeEating),
    'painfulUrination': _ordinalEncoder(_OrdinalCategories.painfulUrination,
        modelData.generalSection?.painfulUrination),
    'seizure': _ordinalEncoder(
        _OrdinalCategories.seizure, modelData.generalSection?.seizure),
    'smellyUrine': _ordinalEncoder(
        _OrdinalCategories.smellyUrine, modelData.generalSection?.smellyUrine),
    'vaccinationIn14days': _ordinalEncoder(
        _OrdinalCategories.vaccinationIn14days,
        modelData.generalSection?.vaccinationIn14days),
    'vaccinationHowManyHoursAgo': _ordinalEncoder(
        _OrdinalCategories.vaccinationHowManyHoursAgo,
        modelData.generalSection?.vaccinationHowManyHoursAgo),
    'wryNeck': _ordinalEncoder(
        _OrdinalCategories.wryNeck, modelData.generalSection?.wryNeck),
  };
  res = {
    ...ordinalMapping,
    ..._oneHotArrayEncoder(
        _OneHotCategories.pain, modelData.generalSection?.pain),
    ..._oneHotEncoder(
        _OneHotCategories.awareness, modelData.generalSection?.awareness),
    ..._oneHotArrayEncoder(
        _OneHotCategories.vomit, modelData.hydrationSection?.vomit),
  };
  return res;
}
