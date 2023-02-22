import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class IDatePicker extends StatelessWidget {
  final String name;
  final String label;
  final bool isRequired;
  final void Function(String)? onChanged;
  final Icon? prefixIcon;
  final DateTime? initialDate;
  final bool pastOnly;
  final DateTime? initialValue;
  final bool enabled;

  const IDatePicker({
    super.key,
    required this.name,
    required this.label,
    this.isRequired = false,
    this.onChanged,
    this.prefixIcon,
    this.initialDate,
    this.pastOnly = false,
    this.enabled = true,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: label,
            style: DefaultTextStyle.of(context).style,
            children: [
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                )
            ],
          ),
        ),
        prefixIcon: prefixIcon,
      ),
      name: name,
      inputType: InputType.date,
      enabled: enabled,
      initialValue: initialValue,
      initialDate: initialDate,
      validator: FormBuilderValidators.compose(
        [
          if (isRequired) FormBuilderValidators.required(),
          if (pastOnly)
            (value) {
              if (value != null && DateTime.now().isBefore(value)) {
                return 'Future dates are not allowed';
              }
            },
        ],
      ),
    );
  }
}
