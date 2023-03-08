import 'package:fever_friend_app/utils/tuple.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/models.dart';
import '../../../widgets/form/form.dart';

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
