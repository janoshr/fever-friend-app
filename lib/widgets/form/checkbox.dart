import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ICheckbox extends StatelessWidget {
  final String name;
  final String label;
  final List<String> answer;
  final bool isRequired;

  const ICheckbox({
    Key? key,
    required this.name,
    required this.label,
    required this.answer,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FormBuilderCheckboxGroup(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        name: name,
        decoration: InputDecoration(
          label: Text(label),
        ),
        validator: FormBuilderValidators.compose([
          if (isRequired)
            (values) {
              if (values == null || values.isEmpty) {
                return 'Please select one option';
              }
              return null;
            },
        ]),
        options: List<FormBuilderFieldOption>.from(
            answer.map((a) => FormBuilderFieldOption(
                  value: a,
                  child: SizedBox(
                    width: double.infinity,
                    height: 18,
                    child: Text(a),
                  ),
                ))),
      ),
    );
  }
}
