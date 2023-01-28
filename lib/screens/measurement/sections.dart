import 'package:fever_friend_app/ui/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../models/fever_measurement.dart';
import '../../ui/widgets/form/form.dart';
import '../../models/models.dart';

class FeverSectionView extends StatefulWidget {
  final FormBuilderState? formState;
  const FeverSectionView({Key? key, required this.formState}) : super(key: key);

  @override
  _FeverSectionViewState createState() => _FeverSectionViewState();
}

class _FeverSectionViewState extends State<FeverSectionView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IRadioGroup(
          name: FeverFields.thermometerUsed.name,
          label: 'Thermometer used?',
          answer: const ['Digital', 'Chemical', 'Infra', 'Other'],
          isRequired: true,
        ),
        IRadioGroup(
          name: FeverFields.measurementLocation.name,
          label: 'Measurement location?',
          answer: const ['Forehead', 'Ear', 'Rectal', 'Oral', 'Armpit'],
          isRequired: true,
          disabled: const ['Forehead'],
        ),
        INumberInputField(
          name: FeverFields.temperature.name,
          label: 'Temperature?',
          min: TEMPERATURE_MIN,
          max: TEMPERATURE_MAX,
          isRequired: true,
        ),
        IRadioGroup(
          name: FeverFields.feverDuration.name,
          label: 'Fever duration?',
          answer: const ['Less than 3 days', '3-5 days', 'More than 5 days'],
        )
      ],
    );
  }
}

class MedicationSectionView extends StatefulWidget {
  final FormBuilderState? formState;
  const MedicationSectionView({Key? key, required this.formState}) : super(key: key);

  @override
  _MedicationSectionViewState createState() => _MedicationSectionViewState();
}

class _MedicationSectionViewState extends State<MedicationSectionView> {
  bool showAntipyreticQs = false;
  bool showAntibioticQs = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IRadioGroup(
          name: MedicationFields.antipyretic.name,
          label:
              'Has the patient got "fever-reducing" medication in the past 24 hours?',
          answer: const ['Yes', 'No'],
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
                name: MedicationFields.antibioticsWhat.name,
                label: 'What?',
                answer: const [
                  'Paracetamol',
                  'Ibuprofen',
                  'Aminophenason',
                  'Diclofenac',
                  'Metamizole',
                  'Other'
                ],
                isRequired: showAntipyreticQs,
              ),
              INumberInputField(
                name: MedicationFields.antipyreticHowMany.name,
                label: 'How many times in the past 24 hours?',
                max: 6,
                min: 1,
                isRequired: showAntipyreticQs,
              ),
              INumberInputField(
                name: MedicationFields.antipyreticHowMuch.name,
                label: 'How much all together in the past 24 hours (mg)?',
                max: 0,
                min: 600,
                unit: 'mg',
                isRequired: showAntipyreticQs,
              ),
              IRadioGroup(
                name: MedicationFields.antipyreticReason.name,
                label: 'Reason for administering?',
                answer: const ['Fear', 'For better comfort', 'Other'],
                isRequired: showAntipyreticQs,
              ),
            ],
          ),
        ),
        IRadioGroup(
          name: MedicationFields.antibiotics.name,
          label: 'Has the patient got antibiotics in the past 24 hours?',
          answer: const ['Yes', 'No'],
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
              ICheckboxGroup(
                name: MedicationFields.antibioticsWhat.name,
                label: 'What?',
                answer: const [],
                isRequired: showAntibioticQs,
              ),
              INumberInputField(
                name: MedicationFields.antibioticsHowMany.name,
                label: 'How many times in the past 24 hours?',
                max: 6,
                min: 1,
                isRequired: showAntibioticQs,
              ),
              INumberInputField(
                name: MedicationFields.antibioticsHowMuch.name,
                label: 'How much all together in the past 24 hours (mg)?',
                max: 0,
                min: 600,
                unit: 'mg',
                isRequired: showAntibioticQs,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HydrationSectionView extends StatefulWidget {
  final FormBuilderState? formState;
  const HydrationSectionView({Key? key, required this.formState}) : super(key: key);

  @override
  _HydrationSectionViewState createState() => _HydrationSectionViewState();
}

class _HydrationSectionViewState extends State<HydrationSectionView> {
  bool showCryingQ = false;
  bool showVomitQ = false;

  @override
  Widget build(BuildContext context) {
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
        ),
        IRadioGroup(
          name: HydrationFields.skinTurgor.name,
          label: 'Skin turgor?',
          answer: const ['Normal', 'Somewhat decreased', 'Severely decreased'],
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
          ),
        ),
        IRadioGroup(
          name: HydrationFields.tongue.name,
          label: 'Tongue?',
          answer: const ['Wet', 'Dry'],
        ),
        IRadioGroup(
          name: HydrationFields.drinking.name,
          label: 'Drinking?',
          answer: const [
            'As much as normally or more',
            'Less than normal',
            'Nothing in the last 12 hours'
          ],
        ),
        IRadioGroup(
          name: HydrationFields.diarrhea.name,
          label: 'Diarrhea for more than 12 hours?',
          answer: const ['No or slight', 'Frequent', 'Frequent and bloody'],
        ),
        ICheckbox(
          name: 'vomit_logic',
          label: 'Vomiting?',
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

class RespirationSectionView extends StatefulWidget {
  final FormBuilderState? formState;
  const RespirationSectionView({Key? key, required this.formState}) : super(key: key);

  @override
  _RespirationSectionViewState createState() => _RespirationSectionViewState();
}

class _RespirationSectionViewState extends State<RespirationSectionView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        INumberInputField(
          name: RespirationFields.respiratoryRate.name,
          label: 'Respiratory rate?',
          min: RRATE_MIN,
          max: RRATE_MAX,
        ),
        IRadioGroup(
          name: RespirationFields.wheezing.name,
          label: 'Nature of breathing',
          answer: const ['Normal', 'Slightly wheezing', 'Strong wheezing (stridor)'],
        ),
        IRadioGroup(
          name: RespirationFields.dyspnea.name,
          label: 'Dyspnea?',
          answer: const ['1', '2', '3', '4', '5'],
          orientation: OptionsOrientation.horizontal,
        ),
      ],
    );
  }
}

class SkinSectionView extends StatefulWidget {
  final FormBuilderState? formState;
  const SkinSectionView({Key? key, required this.formState}) : super(key: key);

  @override
  _SkinSectionViewState createState() => _SkinSectionViewState();
}

class _SkinSectionViewState extends State<SkinSectionView> {
  bool showRashQ = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IRadioGroup(
          name: SkinFields.skinColor.name,
          label: 'Skin color?',
          answer: const ['Normal or slightly pale', 'Pale', 'Grey, bluish, purplish'],
        ),
        IRadioGroup(
          name: SkinFields.rash.name,
          label: 'Rash?',
          answer: const ['No', 'Yes'],
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

class PulseSectionView extends StatefulWidget {
  final FormBuilderState? formState;
  const PulseSectionView({Key? key, required this.formState}) : super(key: key);

  @override
  _PulseSectionViewState createState() => _PulseSectionViewState();
}

class _PulseSectionViewState extends State<PulseSectionView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        INumberInputField(
          name: PulseFields.pulse.name,
          label: 'Pulse rate?',
          min: PULSE_MIN,
          max: PULSE_MAX,
        ),
      ],
    );
  }
}

class GeneralSectionView extends StatefulWidget {
  final FormBuilderState? formState;
  const GeneralSectionView({Key? key, required this.formState}) : super(key: key);

  @override
  _GeneralSectionViewState createState() => _GeneralSectionViewState();
}

class _GeneralSectionViewState extends State<GeneralSectionView> {
  bool showVaccinationQs = false;

  @override
  Widget build(BuildContext context) {
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
        ),
        IRadioGroup(
          name: GeneralFields.painfulUrination.name,
          label: 'Painful urination?',
          answer: const ['No', 'Yes'],
        ),
        IRadioGroup(
          name: GeneralFields.smellyUrine.name,
          label: 'Smelly urine?',
          answer: const ['No', 'Yes'],
        ),
        IRadioGroup(
          name: GeneralFields.awareness.name,
          label: 'Awareness?',
          answer: const [
            'Normal',
            'Sleepy, odd for more than 5 hours, or having feverish nightmares',
            'No reactions, no awareness'
          ],
        ),
        IRadioGroup(
          name: GeneralFields.vaccinationIn14days.name,
          label: 'Vacination within 14 days?',
          answer: const ['No', 'Yes'],
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
              ),
              ITextField(
                name: GeneralFields.vaccinationWhat.name,
                label: 'What is the name of the vaccination?',
                isRequired: showVaccinationQs,
              ),
            ],
          ),
        ),
        IRadioGroup(
          name: GeneralFields.exoticTrip.name,
          label: 'Exotic trip in the past 12 months?',
          answer: const ['Yes', 'No'],
        ),
        IRadioGroup(
          name: GeneralFields.seizure.name,
          label: 'Feverish seizure',
          answer: const ['No', 'Yes'],
        ),
        IRadioGroup(
          name: GeneralFields.wryNeck.name,
          label: 'Stiff neck?',
          answer: const ['No', 'Yes'],
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
        ),
      ],
    );
  }
}

class CaregiverSectionView extends StatefulWidget {
  final FormBuilderState? formState;
  const CaregiverSectionView({Key? key, required this.formState}) : super(key: key);

  @override
  _CaregiverSectionViewState createState() => _CaregiverSectionViewState();
}

class _CaregiverSectionViewState extends State<CaregiverSectionView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IRadioGroup(
          name: CaregiverFields.parentFeel.name,
          label: 'How do you feel about the progress of your patient\'s fever?',
          answer: const ['Optimal', 'Not sure', 'Very worried'],
        ),
        IRadioGroup(
          name: CaregiverFields.parentThink.name,
          label: 'How severe do you think your patient\' condition is?',
          answer: const ['Not severe', 'Somewhat severe', 'Very severe'],
        ),
        IRadioGroup(
          name: CaregiverFields.parentConfident.name,
          label:
              'How confident do you feel yourselves in managing the patient\'s feverish illness?',
          answer: const [
            'Completely',
            'Somewhat confident',
            'Not really',
            'Not at all'
          ],
        ),
      ],
    );
  }
}
