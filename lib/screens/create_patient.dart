import 'package:fever_friend_app/services/get_it.dart';
import 'package:fever_friend_app/models/patient.dart';
import 'package:fever_friend_app/services/patient_provider.dart';
import 'package:fever_friend_app/services/firestore.dart';
import 'package:fever_friend_app/ui/shared/constants.dart';
import 'package:fever_friend_app/ui/widgets/form/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class ICreatePatientScreen extends StatefulWidget {
  const ICreatePatientScreen({Key? key}) : super(key: key);

  @override
  _ICreatePatientScreenState createState() => _ICreatePatientScreenState();
}

class _ICreatePatientScreenState extends State<ICreatePatientScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('New Patient'),
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
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  )
                ],
                const ITextField(
                  name: 'name',
                  label: 'Name *',
                  prefixIcon: Icon(Icons.face),
                  isRequired: true,
                ),
                const SizedBox(height: 12),
                IDatePicker(
                  name: 'dateOfBirth',
                  label: 'Date of Birth *',
                  isRequired: true,
                  pastOnly: true,
                  prefixIcon: const Icon(Icons.cake),
                  initialDate: DateTime.now(),
                ),
                const SizedBox(height: 12),
                INumberInputField(
                  name: 'height',
                  label: 'Height *',
                  isRequired: true,
                  prefixIcon: const Icon(Icons.height),
                  unit: 'cm',
                  min: HEIGHT_MIN,
                  max: HEIGHT_MAX,
                ),
                const SizedBox(height: 12),
                INumberInputField(
                  name: 'weight',
                  label: 'Weight *',
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
                  options: const [
                    FormBuilderChipOption(
                      value: 'male',
                      avatar: Icon(Icons.male),
                      child: Text('Male'),
                    ),
                    FormBuilderChipOption(
                      value: 'female',
                      avatar: Icon(Icons.female),
                      child: Text('Female'),
                    )
                  ],
                  validator: FormBuilderValidators.required(),
                ),
                //const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () => onSubmit(context, (Patient patient) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }),
                  child: const Text('Create Patient'),
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
          height: fields['height']!.value,
          weight: fields['weight']!.value,
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
