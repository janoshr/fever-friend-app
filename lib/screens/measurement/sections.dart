import 'package:fever_friend_app/services/patient_provider.dart';
import 'package:fever_friend_app/ui/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

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

Map<MeasurementSections, SectionConfig> sectionConfigMap = const {
  MeasurementSections.fever: SectionConfig(
      title: 'Fever',
      icon: Icon(Icons.thermostat),
      widgetType: FeverSectionForm),
  MeasurementSections.medication: SectionConfig(
      title: 'Medication',
      icon: Icon(Icons.medication),
      widgetType: MedicationSectionForm),
  MeasurementSections.hydration: SectionConfig(
      title: 'Hydration',
      icon: Icon(Icons.water_drop),
      widgetType: HydrationSectionForm),
  MeasurementSections.respiration: SectionConfig(
      title: 'Respiration',
      icon: Icon(Icons.air),
      widgetType: RespirationSectionForm),
  MeasurementSections.skin: SectionConfig(
      title: 'Skin condition',
      icon: Icon(Icons.face),
      widgetType: SkinSectionForm),
  MeasurementSections.pulse: SectionConfig(
      title: 'Pulse',
      icon: Icon(Icons.monitor_heart),
      widgetType: PulseSectionForm),
  MeasurementSections.general: SectionConfig(
      title: 'General',
      icon: Icon(Icons.self_improvement),
      widgetType: GeneralSectionForm),
  MeasurementSections.caregiver: SectionConfig(
      title: 'Caregiver',
      icon: Icon(Icons.volunteer_activism),
      widgetType: CaregiverSectionForm),
};

class FeverSectionForm extends StatefulWidget {
  final FormBuilderState? formState;
  final FeverSectionModel? feverSectionModel;
  final FormActionState formActionState;

  const FeverSectionForm({
    Key? key,
    required this.formState,
    this.feverSectionModel,
    this.formActionState = FormActionState.create,
  }) : super(key: key);

  @override
  _FeverSectionFormState createState() => _FeverSectionFormState();
}

class _FeverSectionFormState extends State<FeverSectionForm> {
  @override
  Widget build(BuildContext context) {
    bool enabled = widget.formActionState != FormActionState.view;
    final model = widget.feverSectionModel;

    return Column(
      children: [
        IRadioGroup(
          name: FeverFields.thermometerUsed.name,
          label: 'Thermometer used?',
          answer: const ['Digital', 'Chemical', 'Infra', 'Other'],
          isRequired: true,
          enabled: enabled,
          initialValue: model?.thermometerUsed,
        ),
        IRadioGroup(
          name: FeverFields.measurementLocation.name,
          label: 'Measurement location?',
          answer: const ['Forehead', 'Ear', 'Rectal', 'Oral', 'Armpit'],
          isRequired: true,
          disabled: const ['Forehead'],
          enabled: enabled,
          initialValue: model?.feverMeasurementLocation,
        ),
        INumberInputField(
          name: FeverFields.temperature.name,
          label: 'Temperature?',
          min: TEMPERATURE_MIN,
          max: TEMPERATURE_MAX,
          isRequired: true,
          enabled: enabled,
          initialValue:
              model?.temperature != null ? model!.temperature.toString() : null,
        ),
        IRadioGroup(
          name: FeverFields.feverDuration.name,
          label: 'Fever duration?',
          answer: const ['Less than 3 days', '3-5 days', 'More than 5 days'],
          enabled: enabled,
          initialValue: model?.feverDuration,
        )
      ],
    );
  }
}

class MedicationSectionForm extends StatefulWidget {
  final FormBuilderState? formState;
  final MedicationSectionModel? medicationSectionModel;
  final FormActionState formActionState;

  const MedicationSectionForm({
    Key? key,
    required this.formState,
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
    showAntibioticQs = widget.medicationSectionModel?.antibiotics == 'Yes';
    showAntipyreticQs = widget.medicationSectionModel?.antipyretic == 'Yes';
  }

  @override
  Widget build(BuildContext context) {
    bool enabled = widget.formActionState != FormActionState.view;
    final model = widget.medicationSectionModel;

    return Column(
      children: [
        IRadioGroup(
          name: MedicationFields.antipyretic.name,
          label:
              'Has the patient got "fever-reducing" medication in the past 24 hours?',
          answer: const ['Yes', 'No'],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.antipyretic,
          onChanged: (val) {
            if (val == 'Yes' && !showAntipyreticQs) {
              setState(() {
                showAntipyreticQs = true;
              });
            } else if (val == 'No' && showAntipyreticQs) {
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
                label: 'What?',
                answer: const [
                  'Paracetamol',
                  'Ibuprofen',
                  'Aminophenason',
                  'Diclofenac',
                  'Metamizole',
                  'Other'
                ],
                enabled: enabled,
                initialValue: model?.antipyreticWhat,
                isRequired: showAntipyreticQs,
              ),
              INumberInputField(
                name: MedicationFields.antipyreticHowMany.name,
                label: 'How many times in the past 24 hours?',
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
                label: 'How much all together in the past 24 hours (mg)?',
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
                label: 'Reason for administering?',
                answer: const ['Fear', 'For better comfort', 'Other'],
                isRequired: showAntipyreticQs,
                enabled: enabled,
                initialValue: model?.antipyreticReason,
              ),
            ],
          ),
        ),
        IRadioGroup(
          name: MedicationFields.antibiotics.name,
          label: 'Has the patient got antibiotics in the past 24 hours?',
          answer: const ['Yes', 'No'],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.antibiotics,
          onChanged: (value) {
            if (value == 'Yes' && !showAntibioticQs) {
              setState(() {
                showAntibioticQs = true;
              });
            } else if (value == 'No' && showAntibioticQs) {
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
                label: 'What?',
                isRequired: showAntibioticQs,
                enabled: enabled,
                initialValue: model?.antibioticsWhat,
              ),
              INumberInputField(
                name: MedicationFields.antibioticsHowMany.name,
                label: 'How many times in the past 24 hours?',
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
                label: 'How much all together in the past 24 hours (mg)?',
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
  final FormBuilderState? formState;
  final HydrationSectionModel? hydrationSectionModel;
  final FormActionState formActionState;

  const HydrationSectionForm({
    Key? key,
    required this.formState,
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

    return Column(
      children: [
        IRadioGroup(
          name: HydrationFields.lastUrination.name,
          label: 'Last urination how many hours ago?',
          answer: const [
            'Less than 6 hours ago',
            '6-12 hours ago',
            'More than 12 hours ago'
          ],
          enabled: enabled,
          initialValue: model?.lastUrination,
        ),
        IRadioGroup(
          name: HydrationFields.skinTurgor.name,
          label: 'Skin turgor?',
          answer: const ['Normal', 'Somewhat decreased', 'Severely decreased'],
          enabled: enabled,
          initialValue: model?.skinTurgor,
        ),
        IRadioGroup(
          name: HydrationFields.crying.name,
          label: 'Crying?',
          answer: const [
            'Doesn\'t cry',
            'Normal, bold crying',
            'Continuous with unusually high pitch',
            'Weak'
          ],
          enabled: enabled,
          initialValue: model?.crying,
          onChanged: (value) {
            if (value != 'Doesn\'t cry') {
              setState(() {
                showCryingQ = true;
              });
            } else if (showCryingQ) {
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
            label: 'Tears when crying?',
            answer: const ['Yes', 'Not so much', 'No'],
            enabled: enabled,
            initialValue: model?.tearsWhenCrying,
          ),
        ),
        IRadioGroup(
          name: HydrationFields.tongue.name,
          label: 'Tongue?',
          answer: const ['Wet', 'Dry'],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.tongue,
        ),
        IRadioGroup(
          name: HydrationFields.drinking.name,
          label: 'Drinking?',
          answer: const [
            'As much as normally or more',
            'Less than normal',
            'Nothing in the last 12 hours'
          ],
          enabled: enabled,
          initialValue: model?.drinking,
        ),
        IRadioGroup(
          name: HydrationFields.diarrhea.name,
          label: 'Diarrhea for more than 12 hours?',
          answer: const ['No or slight', 'Frequent', 'Frequent and bloody'],
          enabled: enabled,
          initialValue: model?.diarrhea,
        ),
        ICheckbox(
          name: 'vomit_logic',
          label: 'Vomiting?',
          enabled: enabled,
          initialValue:
              model != null && model.vomit != null && model.vomit!.isNotEmpty,
          onChanged: (val) {
            if (val && !showVomitQ) {
              setState(() {
                showVomitQ = true;
              });
            } else if (!val && showVomitQ) {
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
            label: 'Vomiting?',
            enabled: enabled,
            initialValue: model?.vomit,
            answer: const [
              // * notice the answer 'No' has been replaced by a checkbox
              'Slight',
              'Frequent',
              'Yellow',
              'Repeatedly for more than 5 hours'
            ],
            isRequired: showVomitQ,
          ),
        ),
      ],
    );
  }
}

class RespirationSectionForm extends StatefulWidget {
  final FormBuilderState? formState;
  final RespirationSectionModel? respirationSectionModel;
  final FormActionState formActionState;

  const RespirationSectionForm({
    Key? key,
    required this.formState,
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

    return Column(
      children: [
        INumberInputField(
          name: RespirationFields.respiratoryRate.name,
          label: 'Respiratory rate?',
          min: RRATE_MIN,
          max: RRATE_MAX,
          enabled: enabled,
          initialValue: model?.respiratoryRate != null
              ? model!.respiratoryRate.toString()
              : null,
        ),
        IRadioGroup(
          name: RespirationFields.wheezing.name,
          label: 'Nature of breathing',
          answer: const [
            'Normal',
            'Slightly wheezing',
            'Strong wheezing (stridor)'
          ],
          enabled: enabled,
          initialValue: model?.wheezing,
        ),
        IRadioGroup(
          name: RespirationFields.dyspnea.name,
          label: 'Dyspnea?',
          answer: const ['1', '2', '3', '4', '5'],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.dyspnea,
        ),
      ],
    );
  }
}

class SkinSectionForm extends StatefulWidget {
  final FormBuilderState? formState;
  final SkinSectionModel? skinSectionModel;
  final FormActionState formActionState;

  const SkinSectionForm({
    Key? key,
    required this.formState,
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
    showRashQ = widget.skinSectionModel?.rash == 'Yes';
  }

  @override
  Widget build(BuildContext context) {
    bool enabled = widget.formActionState != FormActionState.view;
    final model = widget.skinSectionModel;

    return Column(
      children: [
        IRadioGroup(
          name: SkinFields.skinColor.name,
          label: 'Skin color?',
          answer: const [
            'Normal or slightly pale',
            'Pale',
            'Grey, bluish, purplish'
          ],
          enabled: enabled,
          initialValue: model?.skinColor,
        ),
        IRadioGroup(
          name: SkinFields.rash.name,
          label: 'Rash?',
          answer: const ['No', 'Yes'],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.rash,
          onChanged: (value) {
            if (value == 'Yes' && !showRashQ) {
              setState(() {
                showRashQ = true;
              });
            } else if (value == 'No' && showRashQ) {
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
            label:
                'Glass Test: when pressing on the rash with a transparent object like glass.',
            answer: const [
              'The red disappears on pressure seen through the glass',
              'The red remains clearly demarcated and string on pressure seen through the glass'
            ],
            isRequired: showRashQ,
          ),
        ),
      ],
    );
  }
}

class PulseSectionForm extends StatefulWidget {
  final FormBuilderState? formState;
  final PulseSectionModel? pulseSectionModel;
  final FormActionState formActionState;

  const PulseSectionForm({
    Key? key,
    required this.formState,
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

    return Column(
      children: [
        INumberInputField(
          name: PulseFields.pulse.name,
          label: 'Pulse rate?',
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
  final FormBuilderState? formState;
  final GeneralSectionModel? generalSectionModel;
  final FormActionState formActionState;

  const GeneralSectionForm({
    Key? key,
    required this.formState,
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

    final patientProvider = Provider.of<PatientProvider>(context);
    final daysOld =
        patientProvider.patient?.dateOfBirth.difference(DateTime.now()).inDays;
    bool olderThan18M = daysOld == null ? false : daysOld / 30 > 18;

    return Column(
      children: [
        IRadioGroup(
          name: GeneralFields.lastTimeEating.name,
          label: 'Last time eating?',
          answer: const [
            'Less than 12 hours ago',
            'More than 12, but less than 24 hours ago',
            'More than 24 hours ago'
          ],
          enabled: enabled,
          initialValue: model?.lastTimeEating,
        ),
        IRadioGroup(
          name: GeneralFields.painfulUrination.name,
          label: 'Painful urination?',
          answer: const ['No', 'Yes'],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.painfulUrination,
        ),
        IRadioGroup(
          name: GeneralFields.smellyUrine.name,
          label: 'Smelly urine?',
          answer: const ['No', 'Yes'],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.smellyUrine,
        ),
        Visibility(
          visible: !olderThan18M,
          child: IRadioGroup(
            name: GeneralFields.bulgingFontanelleMax18MOld.name,
            label: 'Bulging fontanelle?',
            answer: const ['No', 'Yes'],
            orientation: OptionsOrientation.horizontal,
            enabled: enabled,
            initialValue: model?.bulgingFontanelleMax18MOld,
          ),
        ),
        IRadioGroup(
          name: GeneralFields.awareness.name,
          label: 'Awareness?',
          answer: const [
            'Normal',
            'Sleepy, odd for more than 5 hours, or having feverish nightmares',
            'No reactions, no awareness'
          ],
          enabled: enabled,
          initialValue: model?.awareness,
        ),
        IRadioGroup(
          name: GeneralFields.vaccinationIn14days.name,
          label: 'Vacination within 14 days?',
          answer: const ['No', 'Yes'],
          enabled: enabled,
          initialValue: model?.vaccinationIn14days,
        ),
        Visibility(
          visible: showVaccinationQs,
          child: Column(
            children: [
              IRadioGroup(
                name: GeneralFields.vaccinationHowManyHoursAgo.name,
                label: 'How many hours ago?',
                answer: const ['Within 48', 'Beyond 48 hours'],
                isRequired: showVaccinationQs,
                enabled: enabled,
                initialValue: model?.vaccinationHowManyHoursAgo,
              ),
              ITextField(
                name: GeneralFields.vaccinationWhat.name,
                label: 'What is the name of the vaccination?',
                isRequired: showVaccinationQs,
                enabled: enabled,
                initialValue: model?.vaccinationWhat,
              ),
            ],
          ),
        ),
        IRadioGroup(
          name: GeneralFields.exoticTrip.name,
          label: 'Exotic trip in the past 12 months?',
          orientation: OptionsOrientation.horizontal,
          answer: const ['No', 'Yes'],
          enabled: enabled,
          initialValue: model?.exoticTrip,
        ),
        IRadioGroup(
          name: GeneralFields.seizure.name,
          label: 'Feverish seizure',
          answer: const ['No', 'Yes'],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.seizure,
        ),
        IRadioGroup(
          name: GeneralFields.wryNeck.name,
          label: 'Stiff neck?',
          answer: const ['No', 'Yes'],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.wryNeck,
        ),
        ICheckboxGroup(
          name: GeneralFields.pain.name,
          label: 'Pain?',
          answer: const [
            'No',
            'Feeling bad, general discomfort, muscle pain',
            'Headache',
            'Swollen, painful bodyparts, patient is trying to protect it',
            'Strong belly pain for more than 12 hours'
          ],
          enabled: enabled,
          initialValue: model?.pain,
        ),
      ],
    );
  }
}

class CaregiverSectionForm extends StatefulWidget {
  final FormBuilderState? formState;
  final CaregiverSectionModel? caregiverSectionModel;
  final FormActionState formActionState;

  const CaregiverSectionForm({
    Key? key,
    required this.formState,
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

    return Column(
      children: [
        IRadioGroup(
          name: CaregiverFields.caregiverFeel.name,
          label: 'How do you feel about the progress of your patient\'s fever?',
          answer: const ['Optimal', 'Not sure', 'Very worried'],
          enabled: enabled,
          initialValue: model?.caregiverFeel,
        ),
        IRadioGroup(
          name: CaregiverFields.caregiverThink.name,
          label: 'How severe do you think your patient\' condition is?',
          answer: const ['Not severe', 'Somewhat severe', 'Very severe'],
          enabled: enabled,
          initialValue: model?.caregiverThink,
        ),
        IRadioGroup(
          name: CaregiverFields.caregiverConfident.name,
          label:
              'How confident do you feel yourselves in managing the patient\'s feverish illness?',
          answer: const [
            'Completely',
            'Somewhat confident',
            'Not really',
            'Not at all'
          ],
          enabled: enabled,
          initialValue: model?.caregiverConfident,
        ),
      ],
    );
  }
}
