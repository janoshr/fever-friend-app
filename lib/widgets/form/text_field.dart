import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ITextField extends StatelessWidget {
  final String name;
  final String label;
  final bool isRequired;

  const ITextField({
    Key? key,
    required this.name,
    required this.label,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FormBuilderTextField(
        name: name,
        decoration: InputDecoration(
          label: Text(label),
        ),
        validator: FormBuilderValidators.compose([
          if (isRequired) FormBuilderValidators.required(),
        ]),
      ),
    );
  }
}
