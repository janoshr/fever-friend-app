import 'package:fever_friend_app/ui/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/models.dart';
import '../../../ui/widgets/form/form.dart';


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
