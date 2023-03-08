import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ITextField extends StatelessWidget {
  final String name;
  final String label;
  final bool isRequired;
  final void Function(String)? onChanged;
  final Icon? prefixIcon;
  final String? suffixText;
  final bool enabled;
  final String? initialValue;

  const ITextField({
    Key? key,
    required this.name,
    required this.label,
    this.isRequired = false,
    this.onChanged,
    this.prefixIcon,
    this.suffixText,
    this.enabled = true,
    this.initialValue,
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
        autovalidateMode: AutovalidateMode.onUserInteraction,
        name: name,
        enabled: enabled,
        initialValue: initialValue,
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
          suffixText: suffixText,
        ),
        validator: FormBuilderValidators.compose([
          if (isRequired) FormBuilderValidators.required(),
        ]),
        onChanged: changeHandler,
      ),
    );
  }
}
