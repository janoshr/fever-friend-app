import 'package:fever_friend_app/services/patient_provider.dart';
import 'package:fever_friend_app/ui/shared/constants.dart';
import 'package:fever_friend_app/utils/tuple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../models/fever_measurement.dart';
import '../../ui/widgets/form/form.dart';
import '../../models/models.dart';

enum FormActionState {
  edit,
  create,
  view,
}

class SectionConfig {
  final String title;
  final Icon icon;
  final Type widgetType;

  const SectionConfig({
    required this.title,
    required this.icon,
    required this.widgetType,
  });
}

Map<MeasurementSections, SectionConfig> sectionConfigMap(BuildContext context) {
  final loc = AppLocalizations.of(context)!;
  return {
    MeasurementSections.fever: SectionConfig(
        title: loc.fever,
        icon: const Icon(Icons.thermostat),
        widgetType: FeverSectionForm),
    MeasurementSections.medication: SectionConfig(
        title: loc.medication,
        icon: const Icon(Icons.medication),
        widgetType: MedicationSectionForm),
    MeasurementSections.hydration: SectionConfig(
        title: loc.hydration,
        icon: const Icon(Icons.water_drop),
        widgetType: HydrationSectionForm),
    MeasurementSections.respiration: SectionConfig(
        title: loc.respiration,
        icon: const Icon(Icons.air),
        widgetType: RespirationSectionForm),
    MeasurementSections.skin: SectionConfig(
        title: loc.skin,
        icon: const Icon(Icons.face),
        widgetType: SkinSectionForm),
    MeasurementSections.pulse: SectionConfig(
        title: loc.pulse,
        icon: const Icon(Icons.monitor_heart),
        widgetType: PulseSectionForm),
    MeasurementSections.general: SectionConfig(
        title: loc.general,
        icon: const Icon(Icons.self_improvement),
        widgetType: GeneralSectionForm),
    MeasurementSections.caregiver: SectionConfig(
        title: loc.caregiver,
        icon: const Icon(Icons.volunteer_activism),
        widgetType: CaregiverSectionForm),
  };
}

class FeverSectionForm extends StatefulWidget {
  final FeverSectionModel? feverSectionModel;
  final FormActionState formActionState;

  const FeverSectionForm({
    Key? key,
    this.feverSectionModel,
    this.formActionState = FormActionState.create,
  }) : super(key: key);

  @override
  _FeverSectionFormState createState() => _FeverSectionFormState();
}

class _FeverSectionFormState extends State<FeverSectionForm> {
  List<String> disabledMeasurementLocations = [
    'measurementLocation-01-Forehead'
  ];

  @override
  Widget build(BuildContext context) {
    bool enabled = widget.formActionState != FormActionState.view;
    final model = widget.feverSectionModel;
    final loc = AppLocalizations.of(context)!;
    final formState = FormBuilder.of(context);

    return Column(
      children: [
        IRadioGroup(
          name: FeverFields.thermometerUsed.name,
          label: loc.thermometerUsedQ,
          answer: <Tuple<String, String>>[
            Tuple('thermometerUsed-01-Digital', loc.thermometerUsed01),
            Tuple('thermometerUsed-02-Chemical', loc.thermometerUsed02),
            Tuple('thermometerUsed-03-Infra', loc.thermometerUsed03),
            Tuple('thermometerUsed-04-Other', loc.thermometerUsed04)
          ],
          isRequired: true,
          enabled: enabled,
          disabled: const ['thermometerUsed-04-Other'],
          initialValue: model?.thermometerUsed,
          onChanged: (value) {
            List<String> disabledList;
            if (value == 'thermometerUsed-01-Digital' ||
                value == 'thermometerUsed-02-Chemical') {
              disabledList = [
                'measurementLocation-01-Forehead',
                'measurementLocation-02-Ear'
              ];
            } else if (value == 'thermometerUsed-03-Infra') {
              disabledList = [
                'measurementLocation-01-Forehead',
                'measurementLocation-03-Rectal',
                'measurementLocation-04-Oral',
                'measurementLocation-05-Armpit',
              ];
            } else {
              disabledList = [
                'measurementLocation-01-Forehead',
              ];
            }
            final measurementLocationRef =
                formState?.fields[FeverFields.measurementLocation.name];
            if (disabledList.contains(measurementLocationRef?.value)) {
              measurementLocationRef?.reset();
            }
            setState(() {
              disabledMeasurementLocations = disabledList;
            });
          },
        ),
        IRadioGroup(
          name: FeverFields.measurementLocation.name,
          label: loc.measurementLocationQ,
          answer: <Tuple<String, String>>[
            Tuple('measurementLocation-01-Forehead', loc.measurementLocation01),
            Tuple('measurementLocation-02-Ear', loc.measurementLocation02),
            Tuple('measurementLocation-03-Rectal', loc.measurementLocation03),
            Tuple('measurementLocation-04-Oral', loc.measurementLocation04),
            Tuple('measurementLocation-05-Armpit', loc.measurementLocation05),
          ],
          isRequired: true,
          disabled: disabledMeasurementLocations,
          enabled: enabled,
          initialValue: model?.feverMeasurementLocation,
        ),
        INumberInputField(
          name: FeverFields.temperature.name,
          label: loc.temperatureQ,
          min: TEMPERATURE_MIN,
          max: TEMPERATURE_MAX,
          isRequired: true,
          enabled: enabled,
          initialValue:
              model?.temperature != null ? model!.temperature.toString() : null,
        ),
        IRadioGroup(
          name: FeverFields.feverDuration.name,
          label: loc.feverDurationQ,
          answer: <Tuple<String, String>>[
            Tuple('feverDuration-01-3>days', loc.feverDuration01),
            Tuple('feverDuration-02-5>=days>3', loc.feverDuration02),
            Tuple('feverDuration-03-days>=5', loc.feverDuration03)
          ],
          enabled: enabled,
          initialValue: model?.feverDuration,
        )
      ],
    );
  }
}

class MedicationSectionForm extends StatefulWidget {
  final MedicationSectionModel? medicationSectionModel;
  final FormActionState formActionState;

  const MedicationSectionForm({
    Key? key,
    this.medicationSectionModel,
    this.formActionState = FormActionState.create,
  }) : super(key: key);

  @override
  _MedicationSectionFormState createState() => _MedicationSectionFormState();
}

class _MedicationSectionFormState extends State<MedicationSectionForm> {
  bool showAntipyreticQs = false;
  bool showAntibioticQs = false;

  @override
  void initState() {
    super.initState();
    showAntibioticQs =
        widget.medicationSectionModel?.antibiotics == 'antibiotics-02-Yes';
    showAntipyreticQs =
        widget.medicationSectionModel?.antipyretic == 'antipyretic-02-Yes';
  }

  @override
  Widget build(BuildContext context) {
    bool enabled = widget.formActionState != FormActionState.view;
    final model = widget.medicationSectionModel;
    final loc = AppLocalizations.of(context)!;
    final formState = FormBuilder.of(context);

    return Column(
      children: [
        IRadioGroup(
          name: MedicationFields.antipyretic.name,
          label: loc.antipyreticQ,
          answer: <Tuple>[
            Tuple('antipyretic-01-No', loc.no),
            Tuple('antipyretic-02-Yes', loc.yes)
          ],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.antipyretic,
          onChanged: (val) {
            if (val == 'antipyretic-02-Yes' && !showAntipyreticQs) {
              setState(() {
                showAntipyreticQs = true;
              });
            } else if (val == 'antipyretic-01-No' && showAntipyreticQs) {
              // Resetting fields
              final fields = formState?.fields;

              fields?[MedicationFields.antipyreticHowMany.name]?.reset();
              fields?[MedicationFields.antipyreticHowMuch.name]?.reset();
              fields?[MedicationFields.antipyreticReason.name]?.reset();
              fields?[MedicationFields.antipyreticWhat.name]?.reset();

              setState(() {
                showAntipyreticQs = false;
              });
            }
          },
        ),
        Visibility(
          visible: showAntipyreticQs,
          child: Column(
            children: [
              ICheckboxGroup(
                name: MedicationFields.antipyreticWhat.name,
                label: loc.antipyreticWhatQ,
                answer: <Tuple>[
                  Tuple(
                      'antipyreticWhat-01-Paracetamol', loc.antipyreticWhat01),
                  Tuple('antipyreticWhat-02-Ibuprofen', loc.antipyreticWhat02),
                  Tuple('antipyreticWhat-03-Aminophenason',
                      loc.antipyreticWhat03),
                  Tuple('antipyreticWhat-04-Diclofenac', loc.antipyreticWhat04),
                  Tuple('antipyreticWhat-05-Metamizol', loc.antipyreticWhat05),
                  Tuple('antipyreticWhat-06-Other', loc.antipyreticWhat06),
                ],
                enabled: enabled,
                initialValue: model?.antipyreticWhat,
                isRequired: showAntipyreticQs,
              ),
              INumberInputField(
                name: MedicationFields.antipyreticHowMany.name,
                label: loc.antipyreticHowManyQ,
                max: 6,
                min: 1,
                isRequired: showAntipyreticQs,
                enabled: enabled,
                initialValue: model?.antipyreticHowMany != null
                    ? model!.antipyreticHowMany.toString()
                    : null,
              ),
              INumberInputField(
                name: MedicationFields.antipyreticHowMuch.name,
                label: loc.antipyreticHowMuchQ,
                min: 0,
                max: 600,
                unit: 'mg',
                isRequired: showAntipyreticQs,
                enabled: enabled,
                initialValue: model?.antipyreticHowMuch != null
                    ? model!.antipyreticHowMuch.toString()
                    : null,
              ),
              IRadioGroup(
                name: MedicationFields.antipyreticReason.name,
                label: loc.antipyreticReasonQ,
                answer: <Tuple>[
                  Tuple('antipyreticReason-01-Fear', loc.antipyreticReason01),
                  Tuple(
                      'antipyreticReason-02-Comfort', loc.antipyreticReason02),
                  Tuple('antipyreticReason-03-Other', loc.antipyreticReason03)
                ],
                isRequired: showAntipyreticQs,
                enabled: enabled,
                initialValue: model?.antipyreticReason,
              ),
            ],
          ),
        ),
        IRadioGroup(
          name: MedicationFields.antibiotics.name,
          label: loc.antibioticsQ,
          answer: <Tuple>[
            Tuple('antibiotics-01-No', loc.no),
            Tuple('antibiotics-02-Yes', loc.yes),
          ],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.antibiotics,
          onChanged: (value) {
            if (value == 'antibiotics-02-Yes' && !showAntibioticQs) {
              setState(() {
                showAntibioticQs = true;
              });
            } else if (value == 'antibiotics-01-No' && showAntibioticQs) {
              // Resetting fields
              final fields = formState?.fields;

              fields?[MedicationFields.antibioticsHowMany.name]?.reset();
              fields?[MedicationFields.antibioticsHowMuch.name]?.reset();
              fields?[MedicationFields.antibioticsWhat.name]?.reset();

              setState(() {
                showAntibioticQs = false;
              });
            }
          },
        ),
        Visibility(
          visible: showAntibioticQs,
          child: Column(
            children: [
              ITextField(
                name: MedicationFields.antibioticsWhat.name,
                label: loc.antibioticsWhatQ,
                isRequired: showAntibioticQs,
                enabled: enabled,
                initialValue: model?.antibioticsWhat,
              ),
              INumberInputField(
                name: MedicationFields.antibioticsHowMany.name,
                label: loc.antibioticsHowManyQ,
                max: 6,
                min: 1,
                isRequired: showAntibioticQs,
                enabled: enabled,
                initialValue: model?.antibioticsHowMany != null
                    ? model!.antibioticsHowMany.toString()
                    : null,
              ),
              INumberInputField(
                name: MedicationFields.antibioticsHowMuch.name,
                label: loc.antibioticsHowMuchQ,
                min: 0,
                max: 600,
                unit: 'mg',
                isRequired: showAntibioticQs,
                enabled: enabled,
                initialValue: model?.antibioticsHowMuch != null
                    ? model!.antibioticsHowMuch.toString()
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HydrationSectionForm extends StatefulWidget {
  final HydrationSectionModel? hydrationSectionModel;
  final FormActionState formActionState;

  const HydrationSectionForm({
    Key? key,
    this.hydrationSectionModel,
    this.formActionState = FormActionState.create,
  }) : super(key: key);

  @override
  _HydrationSectionFormState createState() => _HydrationSectionFormState();
}

class _HydrationSectionFormState extends State<HydrationSectionForm> {
  bool showCryingQ = false;
  bool showVomitQ = false;

  @override
  void initState() {
    super.initState();
    showCryingQ = widget.hydrationSectionModel?.crying != 'Doesn\'t cry';
    showVomitQ = widget.hydrationSectionModel != null &&
        widget.hydrationSectionModel!.vomit != null &&
        widget.hydrationSectionModel!.vomit!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    bool enabled = widget.formActionState != FormActionState.view;
    final model = widget.hydrationSectionModel;
    final loc = AppLocalizations.of(context)!;
    final formState = FormBuilder.of(context);

    return Column(
      children: [
        IRadioGroup(
          name: HydrationFields.lastUrination.name,
          label: loc.lastUrinationQ,
          answer: <Tuple>[
            Tuple('lastUrination-01-6>hours', loc.lastUrination01),
            Tuple('lastUrination-02-6<=hours<12', loc.lastUrination02),
            Tuple('lastUrination-03-12<hours', loc.lastUrination03),
          ],
          enabled: enabled,
          initialValue: model?.lastUrination,
        ),
        IRadioGroup(
          name: HydrationFields.skinTurgor.name,
          label: loc.skinTurgorQ,
          answer: <Tuple>[
            Tuple('skinTurgor-01-Normal', loc.skinTurgor01),
            Tuple('skinTurgor-02-SomewhatDecreased', loc.skinTurgor02),
            Tuple('skinTurgor-03-SeverelyDecreased', loc.skinTurgor03),
          ],
          enabled: enabled,
          initialValue: model?.skinTurgor,
        ),
        IRadioGroup(
          name: HydrationFields.crying.name,
          label: loc.cryingQ,
          answer: <Tuple>[
            Tuple('crying-01-DoesntCry', loc.crying01),
            Tuple('crying-02-NormalBoldCrying', loc.crying02),
            Tuple('crying-03-ContinuousWithUnusuallyHighPitch', loc.crying03),
            Tuple('crying-04-Weak', loc.crying04)
          ],
          enabled: enabled,
          initialValue: model?.crying,
          onChanged: (value) {
            if (value != 'crying-01-DoesntCry' && !showCryingQ) {
              setState(() {
                showCryingQ = true;
              });
            } else if (value == 'crying-01-DoesntCry' && showCryingQ) {
              formState?.fields[HydrationFields.tearsWhenCrying.name]?.reset();
              setState(() {
                showCryingQ = false;
              });
            }
          },
        ),
        Visibility(
          visible: showCryingQ,
          child: IRadioGroup(
            name: HydrationFields.tearsWhenCrying.name,
            label: loc.tearsWhenCryingQ,
            answer: <Tuple>[
              Tuple('tearsWhenCrying-01-Yes', loc.tearsWhenCrying01),
              Tuple('tearsWhenCrying-02-NotSoMuch', loc.tearsWhenCrying02),
              Tuple('tearsWhenCrying-03-No', loc.tearsWhenCrying03),
            ],
            enabled: enabled,
            initialValue: model?.tearsWhenCrying,
          ),
        ),
        IRadioGroup(
          name: HydrationFields.tongue.name,
          label: loc.tongueQ,
          answer: <Tuple>[
            Tuple('tongue-01-Wet', loc.tongue01),
            Tuple('tongue-02-Dry', loc.tongue02),
          ],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.tongue,
        ),
        IRadioGroup(
          name: HydrationFields.drinking.name,
          label: loc.drinkingQ,
          answer: <Tuple>[
            Tuple('drinking-01-Normal', loc.drinking01),
            Tuple('drinking-02-LessThanNormal', loc.drinking02),
            Tuple('drinking-03-NotFor12Hours', loc.drinking03),
          ],
          enabled: enabled,
          initialValue: model?.drinking,
        ),
        IRadioGroup(
          name: HydrationFields.diarrhea.name,
          label: loc.diarrheaQ,
          answer: <Tuple>[
            Tuple('diarrhea-01-NoOrSlight', loc.diarrhea01),
            Tuple('diarrhea-02-Frequent', loc.diarrhea02),
            Tuple('diarrhea-03-FrequentAndBloody', loc.diarrhea03),
          ],
          enabled: enabled,
          initialValue: model?.diarrhea,
        ),
        ICheckbox(
          name: 'vomit_logic',
          label: loc.vomitQ,
          enabled: enabled,
          initialValue:
              model != null && model.vomit != null && model.vomit!.isNotEmpty,
          onChanged: (val) {
            if (val && !showVomitQ) {
              setState(() {
                showVomitQ = true;
              });
            } else if (!val && showVomitQ) {
              formState?.fields[HydrationFields.vomit.name]?.reset();

              setState(() {
                showVomitQ = false;
              });
            }
          },
        ),
        Visibility(
          visible: showVomitQ,
          child: ICheckboxGroup(
            name: HydrationFields.vomit.name,
            label: loc.vomitQ,
            enabled: enabled,
            initialValue: model?.vomit,
            answer: <Tuple>[
              // * notice the answer 'No' has been replaced by a checkbox
              // This causes the shift in numbers
              Tuple('vomit-02-Slight', loc.vomit01),
              Tuple('vomit-03-Frequent', loc.vomit02),
              Tuple('vomit-04-Yellow', loc.vomit03),
              Tuple('vomit-05-5<hours', loc.vomit04),
            ],
            isRequired: showVomitQ,
          ),
        ),
      ],
    );
  }
}

class RespirationSectionForm extends StatefulWidget {
  final RespirationSectionModel? respirationSectionModel;
  final FormActionState formActionState;

  const RespirationSectionForm({
    Key? key,
    this.respirationSectionModel,
    this.formActionState = FormActionState.create,
  }) : super(key: key);

  @override
  _RespirationSectionFormState createState() => _RespirationSectionFormState();
}

class _RespirationSectionFormState extends State<RespirationSectionForm> {
  @override
  Widget build(BuildContext context) {
    bool enabled = widget.formActionState != FormActionState.view;
    final model = widget.respirationSectionModel;
    final loc = AppLocalizations.of(context)!;
    final formState = FormBuilder.of(context);

    return Column(
      children: [
        INumberInputField(
          name: RespirationFields.respiratoryRate.name,
          label: loc.respiratoryRateQ,
          min: RRATE_MIN,
          max: RRATE_MAX,
          enabled: enabled,
          initialValue: model?.respiratoryRate != null
              ? model!.respiratoryRate.toString()
              : null,
        ),
        IRadioGroup(
          name: RespirationFields.wheezing.name,
          label: loc.wheezingQ,
          answer: <Tuple>[
            Tuple('wheezing-01-No', loc.wheezing01),
            Tuple('wheezing-02-SomewhatYes', loc.wheezing02),
            Tuple('wheezing-03-Stridor', loc.wheezing03),
          ],
          enabled: enabled,
          initialValue: model?.wheezing,
        ),
        IRadioGroup(
          name: RespirationFields.dyspnea.name,
          label: loc.dyspneaQ,
          answer: <Tuple>[
            Tuple('dyspnea-01-1', loc.dyspnea01),
            Tuple('dyspnea-02-2', loc.dyspnea02),
            Tuple('dyspnea-03-3', loc.dyspnea03),
            Tuple('dyspnea-04-4', loc.dyspnea04),
            Tuple('dyspnea-05-5', loc.dyspnea05),
          ],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.dyspnea,
        ),
      ],
    );
  }
}

class SkinSectionForm extends StatefulWidget {
  final SkinSectionModel? skinSectionModel;
  final FormActionState formActionState;

  const SkinSectionForm({
    Key? key,
    this.skinSectionModel,
    this.formActionState = FormActionState.create,
  }) : super(key: key);

  @override
  _SkinSectionFormState createState() => _SkinSectionFormState();
}

class _SkinSectionFormState extends State<SkinSectionForm> {
  bool showRashQ = false;

  @override
  void initState() {
    super.initState();
    showRashQ = widget.skinSectionModel?.rash == 'rash-02-Yes';
  }

  @override
  Widget build(BuildContext context) {
    bool enabled = widget.formActionState != FormActionState.view;
    final model = widget.skinSectionModel;
    final loc = AppLocalizations.of(context)!;
    final formState = FormBuilder.of(context);

    return Column(
      children: [
        IRadioGroup(
          name: SkinFields.skinColor.name,
          label: loc.skinColorQ,
          answer: <Tuple>[
            Tuple('skinColor-01-NormalSlightlyPale', loc.skinColor01),
            Tuple('skinColor-02-Pale', loc.skinColor02),
            Tuple('skinColor-03-GreyBlueCyanotic', loc.skinColor03),
          ],
          enabled: enabled,
          initialValue: model?.skinColor,
        ),
        IRadioGroup(
          name: SkinFields.rash.name,
          label: loc.rashQ,
          answer: <Tuple>[
            Tuple('rash-01-No', loc.no),
            Tuple('rash-02-Yes', loc.yes),
          ],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.rash,
          onChanged: (value) {
            if (value == 'rash-02-Yes' && !showRashQ) {
              setState(() {
                showRashQ = true;
              });
            } else if (value == 'rash-01-No' && showRashQ) {
              formState?.fields[SkinFields.glassTest.name]?.reset();

              setState(() {
                showRashQ = false;
              });
            }
          },
        ),
        Visibility(
          visible: showRashQ,
          child: IRadioGroup(
            name: SkinFields.glassTest.name,
            enabled: enabled,
            initialValue: model?.glassTest,
            label: loc.glassTestQ,
            answer: <Tuple>[
              Tuple('glassTest-01-RedDisappears', loc.glassTest01),
              Tuple('glassTest-02-RedRemains', loc.glassTest02),
            ],
            isRequired: showRashQ,
          ),
        ),
      ],
    );
  }
}

class PulseSectionForm extends StatefulWidget {
  final PulseSectionModel? pulseSectionModel;
  final FormActionState formActionState;

  const PulseSectionForm({
    Key? key,
    this.pulseSectionModel,
    this.formActionState = FormActionState.create,
  }) : super(key: key);

  @override
  _PulseSectionFormState createState() => _PulseSectionFormState();
}

class _PulseSectionFormState extends State<PulseSectionForm> {
  @override
  Widget build(BuildContext context) {
    bool enabled = widget.formActionState != FormActionState.view;
    final model = widget.pulseSectionModel;
    final loc = AppLocalizations.of(context)!;

    return Column(
      children: [
        INumberInputField(
          name: PulseFields.pulse.name,
          label: loc.pulseQ,
          min: PULSE_MIN,
          max: PULSE_MAX,
          enabled: enabled,
          initialValue: model?.pulse != null ? model!.pulse.toString() : null,
        ),
      ],
    );
  }
}

class GeneralSectionForm extends StatefulWidget {
  final GeneralSectionModel? generalSectionModel;
  final FormActionState formActionState;

  const GeneralSectionForm({
    Key? key,
    this.generalSectionModel,
    this.formActionState = FormActionState.create,
  }) : super(key: key);

  @override
  _GeneralSectionFormState createState() => _GeneralSectionFormState();
}

class _GeneralSectionFormState extends State<GeneralSectionForm> {
  bool showVaccinationQs = false;

  @override
  Widget build(BuildContext context) {
    bool enabled = widget.formActionState != FormActionState.view;
    final model = widget.generalSectionModel;
    final loc = AppLocalizations.of(context)!;

    final patientProvider = Provider.of<PatientProvider>(context);
    final daysOld =
        patientProvider.patient?.dateOfBirth.difference(DateTime.now()).inDays;
    bool olderThan18M = daysOld == null ? false : daysOld / 30 > 18;

    final formState = FormBuilder.of(context);

    debugPrint(olderThan18M.toString());

    return Column(
      children: [
        IRadioGroup(
          name: GeneralFields.lastTimeEating.name,
          label: loc.lastTimeEatingQ,
          answer: <Tuple>[
            Tuple('lastTimeEating-01-<12hours', loc.lastTimeEating01),
            Tuple('lastTimeEating-02-12<=<24hours', loc.lastTimeEating02),
            Tuple('lastTimeEating-03->24hours', loc.lastTimeEating03),
          ],
          enabled: enabled,
          initialValue: model?.lastTimeEating,
        ),
        IRadioGroup(
          name: GeneralFields.painfulUrination.name,
          label: loc.painfulUrinationQ,
          answer: <Tuple>[
            Tuple('painfulUrination-01-No', loc.no),
            Tuple('painfulUrination-02-Yes', loc.yes),
          ],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.painfulUrination,
        ),
        IRadioGroup(
          name: GeneralFields.smellyUrine.name,
          label: loc.smellyUrineQ,
          answer: <Tuple>[
            Tuple('smellyUrine-01-No', loc.no),
            Tuple('smellyUrine-02-Yes', loc.yes),
          ],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.smellyUrine,
        ),
        Visibility(
          visible: !olderThan18M,
          child: IRadioGroup(
            name: GeneralFields.bulgingFontanelleMax18MOld.name,
            label: loc.bulgingFontanelleMax18MOldQ,
            answer: <Tuple>[
              Tuple('bulgingFontanelleMax18MOld-01-No', loc.no),
              Tuple('bulgingFontanelleMax18MOld-02-Yes', loc.yes),
            ],
            orientation: OptionsOrientation.horizontal,
            enabled: enabled,
            initialValue: model?.bulgingFontanelleMax18MOld,
          ),
        ),
        IRadioGroup(
          name: GeneralFields.awareness.name,
          label: loc.awarenessQ,
          answer: <Tuple>[
            Tuple('awareness-01-Normal', loc.awareness01),
            Tuple(
                'awareness-02-SleepyOddOrFeverishNightmares', loc.awareness02),
            Tuple('awareness-03-NoReactionsNoAwareness', loc.awareness03)
          ],
          enabled: enabled,
          initialValue: model?.awareness,
        ),
        IRadioGroup(
          name: GeneralFields.vaccinationIn14days.name,
          label: loc.vaccinationIn14daysQ,
          answer: <Tuple>[
            Tuple('vaccinationIn14days-01-No', loc.no),
            Tuple('vaccinationIn14days-02-Yes', loc.yes),
          ],
          enabled: enabled,
          initialValue: model?.vaccinationIn14days,
          onChanged: (value) {
            if (value == 'vaccinationIn14days-02-Yes' && !showVaccinationQs) {
              setState(() {
                showVaccinationQs = true;
              });
            } else if (value == 'vaccinationIn14days-01-No' &&
                showVaccinationQs) {
              formState?.fields[GeneralFields.vaccinationHowManyHoursAgo.name]
                  ?.reset();
              formState?.fields[GeneralFields.vaccinationWhat.name]?.reset();

              setState(() {
                showVaccinationQs = false;
              });
            }
          },
        ),
        Visibility(
          visible: showVaccinationQs,
          child: Column(
            children: [
              IRadioGroup(
                name: GeneralFields.vaccinationHowManyHoursAgo.name,
                label: loc.vaccinationHowManyHoursAgoQ,
                answer: <Tuple>[
                  Tuple('vaccinationsHowManyHoursAgo-01-Within48h',
                      loc.vaccinationHowManyHoursAgo01),
                  Tuple('vaccinationsHowManyHoursAgo-02-Beyond48h',
                      loc.vaccinationHowManyHoursAgo02),
                ],
                isRequired: showVaccinationQs,
                enabled: enabled,
                initialValue: model?.vaccinationHowManyHoursAgo,
              ),
              ITextField(
                name: GeneralFields.vaccinationWhat.name,
                label: loc.vaccinationWhatQ,
                isRequired: showVaccinationQs,
                enabled: enabled,
                initialValue: model?.vaccinationWhat,
              ),
            ],
          ),
        ),
        IRadioGroup(
          name: GeneralFields.exoticTrip.name,
          label: loc.exoticTripQ,
          orientation: OptionsOrientation.horizontal,
          answer: <Tuple>[
            Tuple('exoticTrip-01-No', loc.no),
            Tuple('exoticTrip-02-Yes', loc.yes),
          ],
          enabled: enabled,
          initialValue: model?.exoticTrip,
        ),
        IRadioGroup(
          name: GeneralFields.seizure.name,
          label: loc.seizureQ,
          answer: <Tuple>[
            Tuple('seizure-01-No', loc.no),
            Tuple('seizure-02-Yes', loc.yes),
          ],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.seizure,
        ),
        IRadioGroup(
          name: GeneralFields.wryNeck.name,
          label: loc.wryNeckQ,
          answer: <Tuple>[
            Tuple('wryNeck-01-No', loc.no),
            Tuple('wryNeck-02-Yes', loc.yes),
          ],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.wryNeck,
        ),
        ICheckboxGroup(
          name: GeneralFields.pain.name,
          label: loc.painQ,
          answer: <Tuple>[
            Tuple('pain-01-No', loc.pain01),
            Tuple('pain-02-FeelingBad', loc.pain02),
            Tuple('pain-03-Headache', loc.pain03),
            Tuple('pain-04-SwollenPainful', loc.pain04),
            Tuple('pain-05-StrongBellyacheAche', loc.pain05),
          ],
          enabled: enabled,
          initialValue: model?.pain,
          onChanged: (values) {
            // Assuming the order of values is the order of selection
            if (values != null &&
                values.last == 'pain-01-No' &&
                values.length > 1) {
              formState?.fields[GeneralFields.pain.name]
                  ?.didChange(['pain-01-No']);
            } else if (values != null &&
                values.contains('pain-01-No') &&
                values.last != 'pain-01-No') {
              values.remove('pain-01-No');
              formState?.fields[GeneralFields.pain.name]?.didChange(values);
            }
          },
        ),
      ],
    );
  }
}

class CaregiverSectionForm extends StatefulWidget {
  final CaregiverSectionModel? caregiverSectionModel;
  final FormActionState formActionState;

  const CaregiverSectionForm({
    Key? key,
    this.caregiverSectionModel,
    this.formActionState = FormActionState.create,
  }) : super(key: key);

  @override
  _CaregiverSectionFormState createState() => _CaregiverSectionFormState();
}

class _CaregiverSectionFormState extends State<CaregiverSectionForm> {
  @override
  Widget build(BuildContext context) {
    bool enabled = widget.formActionState != FormActionState.view;
    final model = widget.caregiverSectionModel;
    final loc = AppLocalizations.of(context)!;

    return Column(
      children: [
        IRadioGroup(
          name: CaregiverFields.caregiverFeel.name,
          label: loc.caregiverFeelQ,
          answer: <Tuple>[
            Tuple('caregiverFeel-01-Optimal', loc.caregiverFeel01),
            Tuple('caregiverFeel-02-NotSure', loc.caregiverFeel02),
            Tuple('caregiverFeel-03-VeryWorried', loc.caregiverFeel03),
          ],
          enabled: enabled,
          initialValue: model?.caregiverFeel,
        ),
        IRadioGroup(
          name: CaregiverFields.caregiverThink.name,
          label: loc.caregiverThinkQ,
          answer: <Tuple>[
            Tuple('caregiverThink-01-NotSevere', loc.caregiverThink01),
            Tuple('caregiverThink-02-SomewhatSevere', loc.caregiverThink02),
            Tuple('caregiverThink-03-VerySever', loc.caregiverThink03),
          ],
          enabled: enabled,
          initialValue: model?.caregiverThink,
        ),
        IRadioGroup(
          name: CaregiverFields.caregiverConfident.name,
          label: loc.caregiverConfidentQ,
          answer: <Tuple>[
            Tuple('caregiverConfident-01-Completely', loc.caregiverConfident01),
            Tuple('caregiverConfident-02-SomewhatConfident',
                loc.caregiverConfident02),
            Tuple('caregiverConfident-03-NotReally', loc.caregiverConfident03),
            Tuple('caregiverConfident-04-NotAtAll', loc.caregiverConfident04),
          ],
          enabled: enabled,
          initialValue: model?.caregiverConfident,
        ),
      ],
    );
  }
}
