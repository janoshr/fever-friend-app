import 'package:fever_friend_app/get_it.dart';
import 'package:fever_friend_app/models/models.dart';
import 'package:fever_friend_app/providers/patient_provider.dart';
import 'package:fever_friend_app/services/firestore.dart';
import 'package:flutter/material.dart'
    hide Stepper, StepperType, Step, StepState;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../widgets/form/checkbox.dart';
import '../widgets/form/number_field.dart';
import '../widgets/form/radio_group.dart';
import '../widgets/form/text_field.dart';
import '../widgets/stepper.dart';

class ICreateMeasurementScreen extends StatefulWidget {
  const ICreateMeasurementScreen({Key? key}) : super(key: key);

  @override
  _ICreateMeasurementScreenState createState() =>
      _ICreateMeasurementScreenState();
}

class _ICreateMeasurementScreenState extends State<ICreateMeasurementScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  int activeStep = 0;
  int upperBound = FormSteps.values.length + 1;
  final stepperKeys = List<GlobalKey>.generate(
      FormSteps.values.length + 1, ((index) => GlobalKey()));

  void nextButton() {
    _formKey.currentState?.saveAndValidate();
    if (activeStep < upperBound) {
      int nextStep = activeStep + 1;
      scrollToStep(nextStep);
      setState(() {
        activeStep = nextStep;
      });
    }
  }

  void prevButton() {
    if (activeStep > 0) {
      int nextStep = activeStep - 1;
      scrollToStep(nextStep);
      setState(() {
        activeStep = nextStep;
      });
    }
  }

  void stepTapped(int step) {
    scrollToStep(step);
    setState(() {
      activeStep = step;
    });
  }

  void scrollToStep(int nextStep) {
    if (stepperKeys[nextStep].currentContext != null) {
      Scrollable.ensureVisible(
        stepperKeys[nextStep].currentContext!,
        duration: const Duration(milliseconds: 500),
        alignment: 0.05,
      );
    }
  }

  void Function() onSubmit(Patient patient,
          {required Function() error, required Function() success}) =>
      () async {
        if (_formKey.currentState == null) {
          error.call();
        }
        _formKey.currentState!.saveAndValidate();
        if (_formKey.currentState!.isValid) {
          final db = getIt.get<FirestoreService>();
          final measurement = FeverMeasurement.fromFormBuilder(
            _formKey.currentState!,
            patient,
          );

          success.call();
        }
      };

  StepState getStepState<T extends Enum>(int stepNumber, List<T> values) {
    if (stepNumber == activeStep) {
      return StepState.editing;
    }

    if (values.any((element) =>
        _formKey.currentState?.fields[element.name]?.hasError ?? false)) {
      return StepState.error;
    }

    if (activeStep > stepNumber) {
      return StepState.complete;
    }

    return StepState.indexed;
  }

  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<PatientProvider>(context).patient;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create New Measurement'),
      ),
      body: SafeArea(
        child: FormBuilder(
          key: _formKey,
          child: Stepper(
            headerKeys: stepperKeys,
            currentStep: activeStep,
            type: StepperType.horizontal,
            onStepTapped: stepTapped,
            onStepContinue: nextButton,
            onStepCancel: prevButton,
            controlsBuilder: (context, details) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed:
                        details.currentStep == 0 ? null : details.onStepCancel,
                    child: const Text('Back'),
                  ),
                  ElevatedButton(
                    onPressed: details.currentStep == upperBound - 1
                        ? null
                        : details.onStepContinue,
                    child: const Text('Next'),
                  )
                ],
              );
            },
            steps: <Step>[
              Step(
                isActive: activeStep == FormSteps.fever.index,
                state: getStepState(FormSteps.fever.index, FeverFields.values),
                title: const Text('Fever'),
                content: StepFever(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == FormSteps.medication.index,
                state: getStepState(
                    FormSteps.medication.index, MedicationFields.values),
                title: const Text('Medication'),
                content: StepMedication(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == FormSteps.hydration.index,
                state: getStepState(
                    FormSteps.hydration.index, HydrationFields.values),
                title: const Text('Hydration'),
                content: StepHydration(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == FormSteps.respiration.index,
                state: getStepState(
                    FormSteps.respiration.index, RespirationFields.values),
                title: const Text('Respiration'),
                content: StepRespiration(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == FormSteps.skin.index,
                state: getStepState(FormSteps.skin.index, SkinFields.values),
                title: const Text('Skin condition'),
                content: StepSkin(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == FormSteps.pulse.index,
                state: getStepState(FormSteps.pulse.index, PulseFields.values),
                title: const Text('Pulse'),
                content: StepPulse(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == FormSteps.general.index,
                state:
                    getStepState(FormSteps.general.index, GeneralFields.values),
                title: const Text('General condition'),
                content: StepGeneral(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == FormSteps.caregiver.index,
                state: getStepState(
                    FormSteps.caregiver.index, CaregiverFields.values),
                title: const Text('caregiver'),
                content: Stepcaregiver(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == 8,
                title: const Text('Overview'),
                content: Column(
                  children: [
                    ElevatedButton(
                      onPressed: onSubmit(
                        patient!,
                        error: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Something went wrong')),
                        ),
                        success: () {},
                      ),
                      child: const Text('Submit'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StepFever extends StatefulWidget {
  final FormBuilderState? formState;
  const StepFever({Key? key, required this.formState}) : super(key: key);

  @override
  _StepFeverState createState() => _StepFeverState();
}

class _StepFeverState extends State<StepFever> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IRadioGroup(
          name: FeverFields.thermometerUsed.name,
          label: 'Thermometer used?',
          answer: ['Digital', 'Chemical', 'Infra', 'Other'],
          isRequired: true,
        ),
        IRadioGroup(
          name: FeverFields.measurementLocation.name,
          label: 'Measurement location?',
          answer: ['Forehead', 'Ear', 'Rectal', 'Oral', 'Armpit'],
          isRequired: true,
          disabled: ['Forehead'],
        ),
        INumberInputField(
          name: FeverFields.temperature.name,
          label: 'Temperature?',
          min: 34.0,
          max: 45.0,
          isRequired: true,
        ),
        IRadioGroup(
          name: FeverFields.feverDuration.name,
          label: 'Fever duration?',
          answer: ['Less than 3 days', '3-5 days', 'More than 5 days'],
        )
      ],
    );
  }
}

class StepMedication extends StatefulWidget {
  final FormBuilderState? formState;
  const StepMedication({Key? key, required this.formState}) : super(key: key);

  @override
  _StepMedicationState createState() => _StepMedicationState();
}

class _StepMedicationState extends State<StepMedication> {
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
          answer: ['Yes', 'No'],
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
                answer: ['Fear', 'For better comfort', 'Other'],
                isRequired: showAntipyreticQs,
              ),
            ],
          ),
        ),
        IRadioGroup(
          name: MedicationFields.antibiotics.name,
          label: 'Has the patient got antibiotics in the past 24 hours?',
          answer: ['Yes', 'No'],
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

class StepHydration extends StatefulWidget {
  final FormBuilderState? formState;
  const StepHydration({Key? key, required this.formState}) : super(key: key);

  @override
  _StepHydrationState createState() => _StepHydrationState();
}

class _StepHydrationState extends State<StepHydration> {
  bool showCryingQ = false;
  bool showVomitQ = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IRadioGroup(
          name: HydrationFields.lastUrination.name,
          label: 'Last urination how many hours ago?',
          answer: [
            'Less than 6 hours ago',
            '6-12 hours ago',
            'More than 12 hours ago'
          ],
        ),
        IRadioGroup(
          name: HydrationFields.skinTurgor.name,
          label: 'Skin turgor?',
          answer: ['Normal', 'Somewhat decreased', 'Severely decreased'],
        ),
        IRadioGroup(
          name: HydrationFields.crying.name,
          label: 'Crying?',
          answer: [
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
            answer: ['Yes', 'Not so much', 'No'],
          ),
        ),
        IRadioGroup(
          name: HydrationFields.tongue.name,
          label: 'Tongue?',
          answer: ['Wet', 'Dry'],
        ),
        IRadioGroup(
          name: HydrationFields.drinking.name,
          label: 'Drinking?',
          answer: [
            'As much as normally or more',
            'Less than normal',
            'Nothing in the last 12 hours'
          ],
        ),
        IRadioGroup(
          name: HydrationFields.diarrhea.name,
          label: 'Diarrhea for more than 12 hours?',
          answer: ['No or slight', 'Frequent', 'Frequent and bloody'],
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
            answer: [
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

class StepRespiration extends StatefulWidget {
  final FormBuilderState? formState;
  const StepRespiration({Key? key, required this.formState}) : super(key: key);

  @override
  _StepRespirationState createState() => _StepRespirationState();
}

class _StepRespirationState extends State<StepRespiration> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        INumberInputField(
          name: RespirationFields.respiratoryRate.name,
          label: 'Respiratory rate?',
          min: 0,
          max: 100,
        ),
        IRadioGroup(
          name: RespirationFields.stridor.name,
          label: 'Nature of breathing',
          answer: ['Normal', 'Slightly wheezing', 'Strong wheezing (stridor)'],
        ),
        IRadioGroup(
          name: RespirationFields.dyspnea.name,
          label: 'Dyspnea?',
          answer: ['1', '2', '3', '4', '5'],
          orientation: OptionsOrientation.horizontal,
        ),
      ],
    );
  }
}

class StepSkin extends StatefulWidget {
  final FormBuilderState? formState;
  const StepSkin({Key? key, required this.formState}) : super(key: key);

  @override
  _StepSkinState createState() => _StepSkinState();
}

class _StepSkinState extends State<StepSkin> {
  bool showRashQ = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IRadioGroup(
          name: SkinFields.skinColor.name,
          label: 'Skin color?',
          answer: ['Normal or slightly pale', 'Pale', 'Grey, bluish, purplish'],
        ),
        IRadioGroup(
          name: SkinFields.rash.name,
          label: 'Rash?',
          answer: ['No', 'Yes'],
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
            answer: [
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

class StepPulse extends StatefulWidget {
  final FormBuilderState? formState;
  const StepPulse({Key? key, required this.formState}) : super(key: key);

  @override
  _StepPulseState createState() => _StepPulseState();
}

class _StepPulseState extends State<StepPulse> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        INumberInputField(
          name: PulseFields.pulse.name,
          label: 'Pulse rate?',
          min: 40,
          max: 250,
        ),
      ],
    );
  }
}

class StepGeneral extends StatefulWidget {
  final FormBuilderState? formState;
  const StepGeneral({Key? key, required this.formState}) : super(key: key);

  @override
  _StepGeneralState createState() => _StepGeneralState();
}

class _StepGeneralState extends State<StepGeneral> {
  bool showVaccinationQs = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IRadioGroup(
          name: GeneralFields.lastTimeEating.name,
          label: 'Last time eating?',
          answer: [
            'Less than 12 hours ago',
            'More than 12, but less than 24 hours ago',
            'More than 24 hours ago'
          ],
        ),
        IRadioGroup(
          name: GeneralFields.painfulUrination.name,
          label: 'Painful urination?',
          answer: ['No', 'Yes'],
        ),
        IRadioGroup(
          name: GeneralFields.smellyUrine.name,
          label: 'Smelly urine?',
          answer: ['No', 'Yes'],
        ),
        IRadioGroup(
          name: GeneralFields.awareness.name,
          label: 'Awareness?',
          answer: [
            'Normal',
            'Sleepy, odd for more than 5 hours, or having feverish nightmares',
            'No reactions, no awareness'
          ],
        ),
        IRadioGroup(
          name: GeneralFields.vaccinationIn14days.name,
          label: 'Vacination within 14 days?',
          answer: ['No', 'Yes'],
        ),
        Visibility(
          visible: showVaccinationQs,
          child: Column(
            children: [
              IRadioGroup(
                name: GeneralFields.vaccinationIn14daysHowManyHoursAgo.name,
                label: 'How many hours ago?',
                answer: ['Within 48', 'Beyond 48 hours'],
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
          answer: ['Yes', 'No'],
        ),
        IRadioGroup(
          name: GeneralFields.seizure.name,
          label: 'Feverish seizure',
          answer: ['No', 'Yes'],
        ),
        IRadioGroup(
          name: GeneralFields.wryNeck.name,
          label: 'Stiff neck?',
          answer: ['No', 'Yes'],
        ),
        ICheckboxGroup(
          name: GeneralFields.pain.name,
          label: 'Pain?',
          answer: [
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

class Stepcaregiver extends StatefulWidget {
  final FormBuilderState? formState;
  const Stepcaregiver({Key? key, required this.formState}) : super(key: key);

  @override
  _StepcaregiverState createState() => _StepcaregiverState();
}

class _StepcaregiverState extends State<Stepcaregiver> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IRadioGroup(
          name: CaregiverFields.parentFeel.name,
          label: 'How do you feel about the progress of your patient\'s fever?',
          answer: ['Optimal', 'Not sure', 'Very worried'],
        ),
        IRadioGroup(
          name: CaregiverFields.parentThink.name,
          label: 'How severe do you think your patient\' condition is?',
          answer: ['Not severe', 'Somewhat severe', 'Very severe'],
        ),
        IRadioGroup(
          name: CaregiverFields.parentConfident.name,
          label:
              'How confident do you feel yourselves in managing the patient\'s feverish illness?',
          answer: [
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
