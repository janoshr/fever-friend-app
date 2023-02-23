import 'package:fever_friend_app/utils/tuple.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ICheckboxGroup extends StatelessWidget {
  final String name;
  final String label;
  final List<Tuple> answer;
  final bool isRequired;
  final void Function(List<String>?)? onChanged;
  final bool enabled;
  final List<String>? initialValue;

  const ICheckboxGroup({
    Key? key,
    required this.name,
    required this.label,
    required this.answer,
    this.isRequired = false,
    this.onChanged,
    this.enabled = true,
    this.initialValue,
  }) : super(key: key);

  void changeHandler(List<dynamic>? vals) {
    if (onChanged != null && vals != null) {
      onChanged!(List<String>.from(vals));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FormBuilderCheckboxGroup(
        materialTapTargetSize: MaterialTapTargetSize.padded,
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
        onChanged: changeHandler,
        options: List<FormBuilderFieldOption>.from(
          answer.map(
            (a) => FormBuilderFieldOption(
              value: a.first,
              child: SizedBox(
                width: double.infinity,
                height: 18,
                child: Text(a.second),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ICheckbox extends StatelessWidget {
  final String name;
  final String label;
  final bool isRequired;
  final void Function(bool)? onChanged;
  final bool enabled;
  final bool? initialValue;

  const ICheckbox({
    Key? key,
    required this.name,
    required this.label,
    this.isRequired = false,
    this.onChanged,
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
      child: FormBuilderCheckbox(
        name: name,
        enabled: enabled,
        initialValue: initialValue,
        decoration: const InputDecoration(
            // label: Text(label),
            ),
        title: Text(label),
        validator: FormBuilderValidators.compose([
          if (isRequired)
            (value) {
              if (value == null || !value) {
                return 'Please check the box';
              }
              return null;
            },
        ]),
        onChanged: changeHandler,
      ),
    );
  }
}
