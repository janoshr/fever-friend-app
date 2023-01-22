import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ITextField extends StatelessWidget {
  final String name;
  final String label;
  final bool isRequired;
  final void Function(String)? onChanged;

  const ITextField({
    Key? key,
    required this.name,
    required this.label,
    this.isRequired = false,
    this.onChanged,
  }) : super(key: key);

  void changeHandler(dynamic val) {
    if (onChanged != null) {
      onChanged!(val);
    }
  }

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
        onChanged: changeHandler,
      ),
    );
  }
}
