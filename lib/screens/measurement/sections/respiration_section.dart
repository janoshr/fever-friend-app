import 'package:fever_friend_app/ui/shared/constants.dart';
import 'package:fever_friend_app/utils/tuple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/models.dart';
import '../../../ui/widgets/form/form.dart';


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
