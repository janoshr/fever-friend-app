import 'package:fever_friend_app/models/question_model.dart';
import 'package:fever_friend_app/screens/screen_definition.dart';
import 'package:fever_friend_app/screens/screens.dart';
import 'package:fever_friend_app/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide Stepper, StepperType, Step, StepState;
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';

import '../widgets/form/IRadioGroup.dart';
import '../widgets/form/checkbox.dart';
import '../widgets/form/number_field.dart';
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
  int upperBound = 8;

  Widget buildQuestion(BaseQuestion q) {
    switch (q.type) {
      case QuestionType.number:
        q = q as NumberQuestion;
        return INumberInputField(
          name: q.name,
          label: q.label,
          max: q.max,
          min: q.min,
        );
      case QuestionType.checkbox:
        q = q as CheckboxQuestion;
        return ICheckbox(
          name: q.name,
          label: q.label,
          answer: q.answer,
        );
      case QuestionType.radio:
        q = q as RadioQuestion;
        return IRadioGroup(
          name: q.name,
          answer: q.answer,
          label: q.label,
        );
      case QuestionType.text:
        return ITextField(
          name: q.name,
          label: q.label,
        );
      default:
        return const Text('');
    }
  }

  void nextButton() {
    if (activeStep < upperBound) {
      setState(() {
        activeStep++;
      });
    }
  }

  void prevButton() {
    if (activeStep > 0) {
      setState(() {
        activeStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create New Measurement'),
      ),
      body: SafeArea(
        child: FormBuilder(
          key: _formKey,
          child: Stepper(
            currentStep: activeStep,
            type: StepperType.horizontal,
            onStepContinue: nextButton,
            onStepCancel: prevButton,
            controlsBuilder: (context, details) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
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
                isActive: activeStep == 0,
                state: StepState.complete,
                title: const Text('Fever'),
                content: Column(
                  children:
                      List.from(questionList[0].map((q) => buildQuestion(q))),
                ),
              ),
              Step(
                state: StepState.disabled,
                isActive: activeStep == 1,
                title: const Text('Medication'),
                content: Column(
                  children:
                      List.from(questionList[1].map((q) => buildQuestion(q))),
                ),
              ),
              Step(
                state: StepState.editing,
                isActive: activeStep == 2,
                title: const Text('Hydration'),
                content: Column(
                  children:
                      List.from(questionList[2].map((q) => buildQuestion(q))),
                ),
              ),
              Step(
                state: StepState.error,
                isActive: activeStep == 3,
                title: const Text('Respiration'),
                content: Column(
                  children:
                      List.from(questionList[3].map((q) => buildQuestion(q))),
                ),
              ),
              Step(
                state: StepState.indexed,
                isActive: activeStep == 4,
                title: const Text('Skin condition'),
                content: Column(
                  children:
                      List.from(questionList[4].map((q) => buildQuestion(q))),
                ),
              ),
              Step(
                isActive: activeStep == 5,
                title: const Text('Pulse'),
                content: Column(
                  children:
                      List.from(questionList[5].map((q) => buildQuestion(q))),
                ),
              ),
              Step(
                isActive: activeStep == 6,
                title: const Text('General condition'),
                content: Column(
                  children:
                      List.from(questionList[6].map((q) => buildQuestion(q))),
                ),
              ),
              Step(
                isActive: activeStep == 7,
                title: const Text('Caretaker'),
                content: Column(
                  children:
                      List.from(questionList[7].map((q) => buildQuestion(q))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<List<BaseQuestion>> questionList = [
  [
    RadioQuestion(
      name: 'thermometerUsed',
      label: 'Thermometer used?',
      answer: ['Digital', 'Chemical', 'Infra', 'Other'],
    ),
    RadioQuestion(
      name: 'measurementLocation',
      label: 'Measurement location?',
      answer: ['Forehead', 'Ear', 'Rectal', 'Oral', 'Armpit'],
    ),
    NumberQuestion(
      name: 'temperature',
      label: 'Temperature?',
      min: 34.0,
      max: 45.0,
    ),
    RadioQuestion(
      name: 'feverDuration',
      label: 'Fever duration?',
      answer: ['Less than 3 days', '3-5 days', 'More than 5 days'],
    ),
  ],
  [
    RadioQuestion(
      name: 'antipyretic',
      label:
          'Has the patient got "fever-reducing" medication in the past 24 hours?',
      answer: ['Yes', 'No'],
    ),
    RadioQuestion(
      name: 'antibiotics',
      label: 'Has the patient got antibiotics in the past 24 hours?',
      answer: ['Yes', 'No'],
    ),
  ],
  [
    RadioQuestion(
      name: 'lastUrination',
      label: 'Last urination how many hours ago?',
      answer: [
        'Less than 6 hours ago',
        '6-12 hours ago',
        'More than 12 hours ago'
      ],
    ),
    RadioQuestion(
      name: 'skinTurgor',
      label: 'Skin turgor?',
      answer: ['Normal', 'Somewhat decreased', 'Severely decreased'],
    ),
    RadioQuestion(
      name: 'crying',
      label: 'Crying?',
      answer: [
        'Doesn\' cry',
        'Normal, bold crying',
        'Continuous with unusually high pitch',
        'Weak'
      ],
    ),
    RadioQuestion(
      name: 'tearsWhenCrying',
      label: 'Tears when crying?',
      answer: ['Yes', 'Not so much', 'No'],
    ),
    RadioQuestion(
      name: 'tongue',
      label: 'Tongue?',
      answer: ['Wet', 'Dry'],
    ),
    RadioQuestion(
      name: 'drinking',
      label: 'Drinking?',
      answer: [
        'As much as normally or more',
        'Less than normal',
        'Nothing in the last 12 hours'
      ],
    ),
    RadioQuestion(
      name: 'diarrhea',
      label: 'Diarrhea for more than 12 hours?',
      answer: ['No or slight', 'Frequent', 'Frequent and bloody'],
    ),
    // TODO: refactor
    RadioQuestion(
      name: 'vomit',
      label: 'Vomiting?',
      answer: [
        'No',
        'Slight',
        'Frequent',
        'Yellow',
        'Repeatedly for more than 5 hours'
      ],
    ),
  ],
  [
    NumberQuestion(
      name: 'respiratoryRate',
      label: 'Respiratory rate?',
      min: 0,
      max: 100,
    ),
    RadioQuestion(
      name: 'stridor',
      label: 'Nature of breathing',
      answer: ['Normal', 'Slightly wheezing', 'Strong wheezing (stridor)'],
    ),
    RadioQuestion(
      name: 'dyspnea',
      label: 'Dyspnea?',
      answer: ['1', '2', '3', '4', '5'],
    ),
  ],
  [
    RadioQuestion(
      name: 'skinColor',
      label: 'Skin color?',
      answer: ['Normal or slightly pale', 'Pale', 'Grey, bluish, purplish'],
    ),
    RadioQuestion(
      name: 'rash',
      label: 'Rash?',
      answer: ['No', 'Yes'],
    ),
  ],
  [
    NumberQuestion(
      name: 'pulse',
      label: 'Pulse rate?',
      min: 40,
      max: 250,
    ),
  ],
  [
    RadioQuestion(
      name: 'lastTimeEating',
      label: 'Last time eating?',
      answer: [
        'Less than 12 hours ago',
        'More than 12, but less than 24 hours ago',
        'More than 24 hours ago'
      ],
    ),
    RadioQuestion(
      name: 'painfulUrination',
      label: 'Painful urination?',
      answer: ['No', 'Yes'],
    ),
    RadioQuestion(
      name: 'smellyUrine',
      label: 'Smelly urine?',
      answer: ['No', 'Yes'],
    ),
    RadioQuestion(
      name: 'awareness',
      label: 'Awareness?',
      answer: [
        'Normal',
        'Sleepy, odd for more than 5 hours, or having feverish nightmares',
        'No reactions, no awareness'
      ],
    ),
    RadioQuestion(
      name: 'vaccinationIn14days',
      label: 'Vacination within 14 days?',
      answer: ['No', 'Yes'],
    ),
    RadioQuestion(
      name: 'seizure',
      label: 'Feverish seizure',
      answer: ['No', 'Yes'],
    ),
    RadioQuestion(
      name: 'wryNeck',
      label: 'Stiff neck?',
      answer: ['No', 'Yes'],
    ),
    CheckboxQuestion(
      name: 'pain',
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
  [
    RadioQuestion(
      name: 'parentFeel',
      label: 'How do you feel about the progress of your patient\'s fever?',
      answer: ['Optimal', 'Not sure', 'Very worried'],
    ),
    RadioQuestion(
      name: 'parentThink',
      label: 'How severe do you think your patient\' condition is?',
      answer: ['Not severe', 'Somewhat severe', 'Very severe'],
    ),
    RadioQuestion(
      name: 'parentConfident',
      label:
          'How confident do you feel yourselves in managing the patient\'s feverish illness?',
      answer: ['Completely', 'Somewhat confident', 'Not really', 'Not at all'],
    ),
  ]
];
