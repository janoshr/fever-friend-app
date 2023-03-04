import 'package:fever_friend_app/utils/tuple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/models.dart';
import '../../../ui/widgets/form/form.dart';

class HydrationSectionForm extends StatefulWidget {
  final HydrationSectionModel? hydrationSectionModel;
  final FormActionState formActionState;

  const HydrationSectionForm({
    Key? key,
    this.hydrationSectionModel,
    this.formActionState = FormActionState.create,
  }) : super(key: key);

  @override
  _HydrationSectionFormState createState() => _HydrationSectionFormState();
}

class _HydrationSectionFormState extends State<HydrationSectionForm> {
  bool showCryingQ = false;
  bool showVomitQ = false;

  @override
  void initState() {
    super.initState();
    showCryingQ = widget.hydrationSectionModel?.crying != 'Doesn\'t cry';
    showVomitQ = widget.hydrationSectionModel != null &&
        widget.hydrationSectionModel!.vomit != null &&
        widget.hydrationSectionModel!.vomit!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    bool enabled = widget.formActionState != FormActionState.view;
    final model = widget.hydrationSectionModel;
    final loc = AppLocalizations.of(context)!;
    final formState = FormBuilder.of(context);

    return Column(
      children: [
        IRadioGroup(
          name: HydrationFields.lastUrination.name,
          label: loc.lastUrinationQ,
          answer: <Tuple>[
            Tuple('lastUrination-01-6>hours', loc.lastUrination01),
            Tuple('lastUrination-02-6<=hours<12', loc.lastUrination02),
            Tuple('lastUrination-03-12<hours', loc.lastUrination03),
          ],
          enabled: enabled,
          initialValue: model?.lastUrination,
        ),
        IRadioGroup(
          name: HydrationFields.skinTurgor.name,
          label: loc.skinTurgorQ,
          answer: <Tuple>[
            Tuple('skinTurgor-01-Normal', loc.skinTurgor01),
            Tuple('skinTurgor-02-SomewhatDecreased', loc.skinTurgor02),
            Tuple('skinTurgor-03-SeverelyDecreased', loc.skinTurgor03),
          ],
          enabled: enabled,
          initialValue: model?.skinTurgor,
        ),
        IRadioGroup(
          name: HydrationFields.crying.name,
          label: loc.cryingQ,
          answer: <Tuple>[
            Tuple('crying-01-DoesntCry', loc.crying01),
            Tuple('crying-02-NormalBoldCrying', loc.crying02),
            Tuple('crying-03-ContinuousWithUnusuallyHighPitch', loc.crying03),
            Tuple('crying-04-Weak', loc.crying04)
          ],
          enabled: enabled,
          initialValue: model?.crying,
          onChanged: (value) {
            if (value != 'crying-01-DoesntCry' && !showCryingQ) {
              setState(() {
                showCryingQ = true;
              });
            } else if (value == 'crying-01-DoesntCry' && showCryingQ) {
              formState?.fields[HydrationFields.tearsWhenCrying.name]?.reset();
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
            label: loc.tearsWhenCryingQ,
            answer: <Tuple>[
              Tuple('tearsWhenCrying-01-Yes', loc.tearsWhenCrying01),
              Tuple('tearsWhenCrying-02-NotSoMuch', loc.tearsWhenCrying02),
              Tuple('tearsWhenCrying-03-No', loc.tearsWhenCrying03),
            ],
            enabled: enabled,
            initialValue: model?.tearsWhenCrying,
          ),
        ),
        IRadioGroup(
          name: HydrationFields.tongue.name,
          label: loc.tongueQ,
          answer: <Tuple>[
            Tuple('tongue-01-Wet', loc.tongue01),
            Tuple('tongue-02-Dry', loc.tongue02),
          ],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.tongue,
        ),
        IRadioGroup(
          name: HydrationFields.drinking.name,
          label: loc.drinkingQ,
          answer: <Tuple>[
            Tuple('drinking-01-Normal', loc.drinking01),
            Tuple('drinking-02-LessThanNormal', loc.drinking02),
            Tuple('drinking-03-NotFor12Hours', loc.drinking03),
          ],
          enabled: enabled,
          initialValue: model?.drinking,
        ),
        IRadioGroup(
          name: HydrationFields.diarrhea.name,
          label: loc.diarrheaQ,
          answer: <Tuple>[
            Tuple('diarrhea-01-NoOrSlight', loc.diarrhea01),
            Tuple('diarrhea-02-Frequent', loc.diarrhea02),
            Tuple('diarrhea-03-FrequentAndBloody', loc.diarrhea03),
          ],
          enabled: enabled,
          initialValue: model?.diarrhea,
        ),
        ICheckbox(
          name: 'vomit_logic',
          label: loc.vomitQ,
          enabled: enabled,
          initialValue:
              model != null && model.vomit != null && model.vomit!.isNotEmpty,
          onChanged: (val) {
            if (val && !showVomitQ) {
              setState(() {
                showVomitQ = true;
              });
            } else if (!val && showVomitQ) {
              formState?.fields[HydrationFields.vomit.name]?.reset();

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
            label: loc.vomitQ,
            enabled: enabled,
            initialValue: model?.vomit,
            answer: <Tuple>[
              // * notice the answer 'No' has been replaced by a checkbox
              // This causes the shift in numbers
              Tuple('vomit-02-Slight', loc.vomit01),
              Tuple('vomit-03-Frequent', loc.vomit02),
              Tuple('vomit-04-Yellow', loc.vomit03),
              Tuple('vomit-05-5<hours', loc.vomit04),
            ],
            isRequired: showVomitQ,
          ),
        ),
      ],
    );
  }
}
