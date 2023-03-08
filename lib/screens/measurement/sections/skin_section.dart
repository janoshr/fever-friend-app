import 'package:fever_friend_app/utils/tuple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/models.dart';
import '../../../widgets/form/form.dart';


class SkinSectionForm extends StatefulWidget {
  final SkinSectionModel? skinSectionModel;
  final FormActionState formActionState;

  const SkinSectionForm({
    Key? key,
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
    showRashQ = widget.skinSectionModel?.rash == 'rash-02-Yes';
  }

  @override
  Widget build(BuildContext context) {
    bool enabled = widget.formActionState != FormActionState.view;
    final model = widget.skinSectionModel;
    final loc = AppLocalizations.of(context)!;
    final formState = FormBuilder.of(context);

    return Column(
      children: [
        IRadioGroup(
          name: SkinFields.skinColor.name,
          label: loc.skinColorQ,
          answer: <Tuple>[
            Tuple('skinColor-01-NormalSlightlyPale', loc.skinColor01),
            Tuple('skinColor-02-Pale', loc.skinColor02),
            Tuple('skinColor-03-GreyBlueCyanotic', loc.skinColor03),
          ],
          enabled: enabled,
          initialValue: model?.skinColor,
        ),
        IRadioGroup(
          name: SkinFields.rash.name,
          label: loc.rashQ,
          answer: <Tuple>[
            Tuple('rash-01-No', loc.no),
            Tuple('rash-02-Yes', loc.yes),
          ],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.rash,
          onChanged: (value) {
            if (value == 'rash-02-Yes' && !showRashQ) {
              setState(() {
                showRashQ = true;
              });
            } else if (value == 'rash-01-No' && showRashQ) {
              formState?.fields[SkinFields.glassTest.name]?.reset();

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
            label: loc.glassTestQ,
            answer: <Tuple>[
              Tuple('glassTest-01-RedDisappears', loc.glassTest01),
              Tuple('glassTest-02-RedRemains', loc.glassTest02),
            ],
            isRequired: showRashQ,
          ),
        ),
      ],
    );
  }
}

