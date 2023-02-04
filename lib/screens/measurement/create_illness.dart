import 'package:fever_friend_app/screens/measurement/sections.dart';
import 'package:fever_friend_app/services/get_it.dart';
import 'package:fever_friend_app/models/models.dart';
import 'package:fever_friend_app/services/patient_provider.dart';
import 'package:fever_friend_app/services/firestore.dart';
import 'package:flutter/material.dart'
    hide Stepper, StepperType, Step, StepState;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../../ui/widgets/stepper.dart';

class ICreateMeasurementScreen extends StatefulWidget {
  const ICreateMeasurementScreen({Key? key}) : super(key: key);

  @override
  _ICreateMeasurementScreenState createState() =>
      _ICreateMeasurementScreenState();
}

class _ICreateMeasurementScreenState extends State<ICreateMeasurementScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  int activeStep = 0;
  int upperBound = MeasurementSections.values.length + 1;
  final stepperKeys = List<GlobalKey>.generate(
      MeasurementSections.values.length + 1, ((index) => GlobalKey()));

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

  void Function() onSubmit(Patient patient, Illness? illness,
          {required Function() error, required Function() success}) =>
      () async {
        if (_formKey.currentState == null) {
          error.call();
        }
        _formKey.currentState!.saveAndValidate();
        if (_formKey.currentState!.isValid) {
          final db = getIt.get<FirestoreService>();
          final measurement = MeasurementModel.fromFormBuilder(
            _formKey.currentState!,
            patient,
          );

          if (illness != null) {
            db.addMeasurement(measurement, patient.id, illness);
          } else {
            db.createFeverMeasurement(measurement, patient.id);
          }

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
    final illnessArg = ModalRoute.of(context)!.settings.arguments as Illness?;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        title: illnessArg != null
            ? const Text('Add Measurement')
            : const Text('New Illness'),
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
                isActive: activeStep == MeasurementSections.fever.index,
                state: getStepState(
                    MeasurementSections.fever.index, FeverFields.values),
                title: const Text('Fever'),
                content: FeverSectionForm(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == MeasurementSections.medication.index,
                state: getStepState(MeasurementSections.medication.index,
                    MedicationFields.values),
                title: const Text('Medication'),
                content:
                    MedicationSectionForm(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == MeasurementSections.hydration.index,
                state: getStepState(MeasurementSections.hydration.index,
                    HydrationFields.values),
                title: const Text('Hydration'),
                content: HydrationSectionForm(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == MeasurementSections.respiration.index,
                state: getStepState(MeasurementSections.respiration.index,
                    RespirationFields.values),
                title: const Text('Respiration'),
                content:
                    RespirationSectionForm(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == MeasurementSections.skin.index,
                state: getStepState(
                    MeasurementSections.skin.index, SkinFields.values),
                title: const Text('Skin condition'),
                content: SkinSectionForm(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == MeasurementSections.pulse.index,
                state: getStepState(
                    MeasurementSections.pulse.index, PulseFields.values),
                title: const Text('Pulse'),
                content: PulseSectionForm(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == MeasurementSections.general.index,
                state: getStepState(
                    MeasurementSections.general.index, GeneralFields.values),
                title: const Text('General condition'),
                content: GeneralSectionForm(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == MeasurementSections.caregiver.index,
                state: getStepState(MeasurementSections.caregiver.index,
                    CaregiverFields.values),
                title: const Text('caregiver'),
                content: CaregiverSectionForm(formState: _formKey.currentState),
              ),
              Step(
                isActive: activeStep == 8,
                title: const Text('Overview'),
                content: Column(
                  children: [
                    ElevatedButton(
                      onPressed: onSubmit(
                        patient!,
                        illnessArg,
                        error: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Something went wrong')),
                        ),
                        success: () {
                          Navigator.of(context).pop();
                        },
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

bool validateSection<T extends Enum>(
    List<T> fields, FormBuilderState formState) {
  for (final field in fields) {
    formState.fields[field.name]?.validate();
  }
  return fields.any((field) => formState.fields[field.name]?.hasError ?? false);
}
