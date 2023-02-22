import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class INumberInputField extends StatelessWidget {
  final String name;
  final String label;
  final double? min;
  final double? max;
  final bool isRequired;
  final String? unit;
  final void Function(num)? onChanged;
  final Icon? prefixIcon;
  final bool enabled;
  final String? initialValue;

  const INumberInputField({
    Key? key,
    required this.name,
    required this.label,
    this.max,
    this.min,
    this.isRequired = false,
    this.onChanged,
    this.unit,
    this.prefixIcon,
    this.enabled = true,
    this.initialValue,
  }) : super(key: key);

  void changeHandler(dynamic val) {
    if (onChanged == null) return;
    if (val is num) {
      onChanged!(val);
    } else if (val is String) {
      onChanged!(num.parse(val));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FormBuilderTextField(
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
          suffixText: unit,
          prefixIcon: prefixIcon,
        ),
        name: name,
        enabled: enabled,
        initialValue: initialValue,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"^\d{0,3}(\.\d{0,2})?"))
        ],
        onChanged: changeHandler,
        validator: FormBuilderValidators.compose([
          if (isRequired) FormBuilderValidators.required(),
          if (min != null) FormBuilderValidators.min(min!),
          if (max != null) FormBuilderValidators.max(max!),
        ]),
      ),
    );
  }
}
