import 'package:fever_friend_app/utils/tuple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/models.dart';
import '../../../widgets/form/form.dart';


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
