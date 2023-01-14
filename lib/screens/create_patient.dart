import 'package:fever_friend_app/models/patient.dart';
import 'package:fever_friend_app/services/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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
                    style: TextStyle(color: Theme.of(context).errorColor),
                  )
                ],
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    label: Text('Name *'),
                    prefixIcon: Icon(Icons.face),
                  ),
                  name: 'name',
                  initialValue: '',
                  validator: FormBuilderValidators.required(),
                ),
                const SizedBox(height: 12),
                FormBuilderDateTimePicker(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        label: Text('Date of Birth *'),
                        prefixIcon: Icon(Icons.cake)),
                    name: 'dateOfBirth',
                    inputType: InputType.date,
                    initialDate: DateTime.now(),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      (value) {
                        if (value != null && DateTime.now().isBefore(value)) {
                          return 'Future dates are not allowed';
                        }
                      },
                    ])),
                const SizedBox(height: 12),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    label: Text('Height *'),
                    prefixIcon: Icon(Icons.height),
                    suffixText: 'cm',
                  ),
                  name: 'height',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r"^\d{0,3}(\.\d{0,2})?"))
                  ],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.min(0),
                    FormBuilderValidators.max(250),
                  ]),
                ),
                const SizedBox(height: 12),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    label: Text('Weight *'),
                    prefixIcon: Icon(Icons.scale),
                    suffixText: 'kg',
                  ),
                  name: 'weight',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r"^\d{0,3}(\.\d{0,2})?"))
                  ],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.min(0),
                    FormBuilderValidators.max(250),
                  ]),
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
                  onPressed: () => onSubmit(context, () {
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

  Future onSubmit(BuildContext context, VoidCallback onSuccess) async {
    if (_formKey.currentState == null) return;
    _formKey.currentState!.validate();

    if (_formKey.currentState!.isValid) {
      final db = FirestoreService();
      final fields = _formKey.currentState!.fields;

      try {
        await db.createPatient(Patient(
            id: '',
            name: fields['name']!.value,
            createdAt: DateTime.now(),
            dateOfBirth: fields['dateOfBirth']!.value,
            gender: fields['gender']!.value,
            height: fields['height']!.value,
            weight: fields['weight']!.value));
        onSuccess.call();
      } catch (e) {
        print(e);
        _error = 'Something went wrong';
      }
    }
  }
}
