import 'package:fever_friend_app/screens/screen_definition.dart';
import 'package:fever_friend_app/services/get_it.dart';
import 'package:fever_friend_app/models/patient.dart';
import 'package:fever_friend_app/services/firestore.dart';
import 'package:fever_friend_app/shared/constants.dart';
import 'package:fever_friend_app/widgets/form/form.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../l10n/app_localizations.dart';

class ICreatePatientScreen extends StatefulWidget {
  const ICreatePatientScreen({Key? key}) : super(key: key);

  @override
  _ICreatePatientScreenState createState() => _ICreatePatientScreenState();
}

class _ICreatePatientScreenState extends State<ICreatePatientScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? _error;
  Color screenPickerColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(loc.newPatient),
      ),
      body: SafeArea(
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_error != null) ...[
                  Text(
                    _error!,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  )
                ],
                ITextField(
                  name: 'name',
                  label: loc.name,
                  prefixIcon: const Icon(Icons.face),
                  isRequired: true,
                ),
                const SizedBox(height: 12),
                IDatePicker(
                  name: 'dateOfBirth',
                  label: loc.dateOfBirth,
                  isRequired: true,
                  pastOnly: true,
                  prefixIcon: const Icon(Icons.cake),
                  initialDate: DateTime.now(),
                ),
                const SizedBox(height: 12),
                INumberInputField(
                  name: 'height',
                  label: loc.height,
                  isRequired: true,
                  prefixIcon: const Icon(Icons.height),
                  unit: 'cm',
                  min: HEIGHT_MIN,
                  max: HEIGHT_MAX,
                ),
                const SizedBox(height: 12),
                INumberInputField(
                  name: 'weight',
                  label: loc.weight,
                  max: WEIGHT_MAX,
                  min: WEIGHT_MIN,
                  isRequired: true,
                  unit: 'kg',
                  prefixIcon: const Icon(Icons.scale),
                ),
                const SizedBox(height: 12),
                FormBuilderChoiceChip<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(border: InputBorder.none),
                  name: 'gender',
                  selectedColor: Theme.of(context).primaryColor,
                  alignment: WrapAlignment.spaceAround,
                  labelPadding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                  options: [
                    FormBuilderChipOption(
                      value: 'male',
                      avatar: Icon(Icons.male),
                      child: Text(loc.male),
                    ),
                    FormBuilderChipOption(
                      value: 'female',
                      avatar: const Icon(Icons.female),
                      child: Text(loc.female),
                    ),
                    FormBuilderChipOption(
                      value: 'other',
                      avatar: const Icon(Icons.transgender),
                      child: Text(loc.otherGender),
                    )
                  ],
                  validator: FormBuilderValidators.required(),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide()),
                  ),
                  child: ColorPicker(
                    // Use the screenPickerColor as start color.
                    enableShadesSelection: false,
                    pickersEnabled: const {
                      ColorPickerType.accent: false,
                      ColorPickerType.wheel: false,
                      ColorPickerType.both: false,
                      ColorPickerType.primary: true,
                    },
                    color: screenPickerColor,
                    // Update the screenPickerColor using the callback.
                    onColorChanged: (Color color) =>
                        setState(() => screenPickerColor = color),
                    width: 44,
                    height: 44,
                    borderRadius: 22,
                    heading: Text(
                      loc.selectColor,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () => onSubmit(context, (Patient patient) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(ScreenDefinition.home, (route) => false);
                  }),
                  child: Text(loc.createPatient),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future onSubmit(BuildContext context, Function onSuccess) async {
    if (_formKey.currentState == null) return;
    _formKey.currentState!.validate();

    if (_formKey.currentState!.isValid) {
      final db = getIt.get<FirestoreService>();
      final fields = _formKey.currentState!.fields;

      try {
        Patient patient = Patient(
          id: '',
          name: fields['name']!.value,
          createdAt: DateTime.now(),
          dateOfBirth: fields['dateOfBirth']!.value,
          gender: fields['gender']!.value,
          height: double.parse(fields['height']!.value),
          weight: double.parse(fields['weight']!.value),
          color: screenPickerColor,
        );
        await db.createPatient(patient);
        onSuccess.call(patient);
      } catch (e) {
        debugPrint(e.toString());
        _error = 'Something went wrong';
      }
    }
  }
}
