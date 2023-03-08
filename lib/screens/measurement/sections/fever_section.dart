import 'package:flutter/material.dart';
import 'package:fever_friend_app/shared/constants.dart';
import 'package:fever_friend_app/utils/tuple.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/models.dart';
import '../../../widgets/form/form.dart';

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
