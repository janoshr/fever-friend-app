import 'package:fever_friend_app/services/patient_provider.dart';
import 'package:fever_friend_app/utils/tuple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/models.dart';
import '../../../widgets/form/form.dart';


class GeneralSectionForm extends StatefulWidget {
  final GeneralSectionModel? generalSectionModel;
  final FormActionState formActionState;

  const GeneralSectionForm({
    Key? key,
    this.generalSectionModel,
    this.formActionState = FormActionState.create,
  }) : super(key: key);

  @override
  _GeneralSectionFormState createState() => _GeneralSectionFormState();
}

class _GeneralSectionFormState extends State<GeneralSectionForm> {
  bool showVaccinationQs = false;

  @override
  Widget build(BuildContext context) {
    bool enabled = widget.formActionState != FormActionState.view;
    final model = widget.generalSectionModel;
    final loc = AppLocalizations.of(context)!;

    final patientProvider = Provider.of<PatientProvider>(context);
    final daysOld =
        patientProvider.patient?.dateOfBirth.difference(DateTime.now()).inDays;
    bool olderThan18M = daysOld == null ? false : daysOld / 30 > 18;

    final formState = FormBuilder.of(context);

    debugPrint(olderThan18M.toString());

    return Column(
      children: [
        IRadioGroup(
          name: GeneralFields.lastTimeEating.name,
          label: loc.lastTimeEatingQ,
          answer: <Tuple>[
            Tuple('lastTimeEating-01-<12hours', loc.lastTimeEating01),
            Tuple('lastTimeEating-02-12<=<24hours', loc.lastTimeEating02),
            Tuple('lastTimeEating-03->24hours', loc.lastTimeEating03),
          ],
          enabled: enabled,
          initialValue: model?.lastTimeEating,
        ),
        IRadioGroup(
          name: GeneralFields.painfulUrination.name,
          label: loc.painfulUrinationQ,
          answer: <Tuple>[
            Tuple('painfulUrination-01-No', loc.no),
            Tuple('painfulUrination-02-Yes', loc.yes),
          ],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.painfulUrination,
        ),
        IRadioGroup(
          name: GeneralFields.smellyUrine.name,
          label: loc.smellyUrineQ,
          answer: <Tuple>[
            Tuple('smellyUrine-01-No', loc.no),
            Tuple('smellyUrine-02-Yes', loc.yes),
          ],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.smellyUrine,
        ),
        Visibility(
          visible: !olderThan18M,
          child: IRadioGroup(
            name: GeneralFields.bulgingFontanelleMax18MOld.name,
            label: loc.bulgingFontanelleMax18MOldQ,
            answer: <Tuple>[
              Tuple('bulgingFontanelleMax18MOld-01-No', loc.no),
              Tuple('bulgingFontanelleMax18MOld-02-Yes', loc.yes),
            ],
            orientation: OptionsOrientation.horizontal,
            enabled: enabled,
            initialValue: model?.bulgingFontanelleMax18MOld,
          ),
        ),
        IRadioGroup(
          name: GeneralFields.awareness.name,
          label: loc.awarenessQ,
          answer: <Tuple>[
            Tuple('awareness-01-Normal', loc.awareness01),
            Tuple(
                'awareness-02-SleepyOddOrFeverishNightmares', loc.awareness02),
            Tuple('awareness-03-NoReactionsNoAwareness', loc.awareness03)
          ],
          enabled: enabled,
          initialValue: model?.awareness,
        ),
        IRadioGroup(
          name: GeneralFields.vaccinationIn14days.name,
          label: loc.vaccinationIn14daysQ,
          answer: <Tuple>[
            Tuple('vaccinationIn14days-01-No', loc.no),
            Tuple('vaccinationIn14days-02-Yes', loc.yes),
          ],
          enabled: enabled,
          initialValue: model?.vaccinationIn14days,
          onChanged: (value) {
            if (value == 'vaccinationIn14days-02-Yes' && !showVaccinationQs) {
              setState(() {
                showVaccinationQs = true;
              });
            } else if (value == 'vaccinationIn14days-01-No' &&
                showVaccinationQs) {
              formState?.fields[GeneralFields.vaccinationHowManyHoursAgo.name]
                  ?.reset();
              formState?.fields[GeneralFields.vaccinationWhat.name]?.reset();

              setState(() {
                showVaccinationQs = false;
              });
            }
          },
        ),
        Visibility(
          visible: showVaccinationQs,
          child: Column(
            children: [
              IRadioGroup(
                name: GeneralFields.vaccinationHowManyHoursAgo.name,
                label: loc.vaccinationHowManyHoursAgoQ,
                answer: <Tuple>[
                  Tuple('vaccinationsHowManyHoursAgo-01-Within48h',
                      loc.vaccinationHowManyHoursAgo01),
                  Tuple('vaccinationsHowManyHoursAgo-02-Beyond48h',
                      loc.vaccinationHowManyHoursAgo02),
                ],
                isRequired: showVaccinationQs,
                enabled: enabled,
                initialValue: model?.vaccinationHowManyHoursAgo,
              ),
              ITextField(
                name: GeneralFields.vaccinationWhat.name,
                label: loc.vaccinationWhatQ,
                isRequired: showVaccinationQs,
                enabled: enabled,
                initialValue: model?.vaccinationWhat,
              ),
            ],
          ),
        ),
        IRadioGroup(
          name: GeneralFields.exoticTrip.name,
          label: loc.exoticTripQ,
          orientation: OptionsOrientation.horizontal,
          answer: <Tuple>[
            Tuple('exoticTrip-01-No', loc.no),
            Tuple('exoticTrip-02-Yes', loc.yes),
          ],
          enabled: enabled,
          initialValue: model?.exoticTrip,
        ),
        IRadioGroup(
          name: GeneralFields.seizure.name,
          label: loc.seizureQ,
          answer: <Tuple>[
            Tuple('seizure-01-No', loc.no),
            Tuple('seizure-02-Yes', loc.yes),
          ],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.seizure,
        ),
        IRadioGroup(
          name: GeneralFields.wryNeck.name,
          label: loc.wryNeckQ,
          answer: <Tuple>[
            Tuple('wryNeck-01-No', loc.no),
            Tuple('wryNeck-02-Yes', loc.yes),
          ],
          orientation: OptionsOrientation.horizontal,
          enabled: enabled,
          initialValue: model?.wryNeck,
        ),
        ICheckboxGroup(
          name: GeneralFields.pain.name,
          label: loc.painQ,
          answer: <Tuple>[
            Tuple('pain-01-No', loc.pain01),
            Tuple('pain-02-FeelingBad', loc.pain02),
            Tuple('pain-03-Headache', loc.pain03),
            Tuple('pain-04-SwollenPainful', loc.pain04),
            Tuple('pain-05-StrongBellyacheAche', loc.pain05),
          ],
          enabled: enabled,
          initialValue: model?.pain,
          onChanged: (values) {
            // Assuming the order of values is the order of selection
            if (values != null &&
                values.last == 'pain-01-No' &&
                values.length > 1) {
              formState?.fields[GeneralFields.pain.name]
                  ?.didChange(['pain-01-No']);
            } else if (values != null &&
                values.contains('pain-01-No') &&
                values.last != 'pain-01-No') {
              values.remove('pain-01-No');
              formState?.fields[GeneralFields.pain.name]?.didChange(values);
            }
          },
        ),
      ],
    );
  }
}
