import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class IRadioGroup<T> extends StatelessWidget {
  final String name;
  final String label;
  final List<T> answer;
  final bool isRequired;
  final ValueChanged<T>? onChanged;
  final List<T>? disabled;
  final OptionsOrientation orientation;

  const IRadioGroup({
    Key? key,
    required this.name,
    required this.label,
    required this.answer,
    this.isRequired = false,
    this.onChanged,
    this.disabled,
    this.orientation = OptionsOrientation.vertical,
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
      child: FormBuilderRadioGroup(
        // selectedColor: Theme.of(context).primaryColor,
        // backgroundColor: Colors.grey[100],
        materialTapTargetSize: MaterialTapTargetSize.padded,
        name: name,
        decoration: InputDecoration(
          label: Text(label),
        ),
        // orientation: OptionsOrientation.vertical,
        validator: FormBuilderValidators.compose([
          if (isRequired) FormBuilderValidators.required(),
        ]),
        onChanged: changeHandler,
        disabled: disabled,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        orientation: orientation,
        options: List<FormBuilderChipOption>.from(
          answer.map(
            (a) => FormBuilderChipOption(
              value: a,
              child: SizedBox(
                width: orientation == OptionsOrientation.horizontal
                    ? null
                    : double.infinity,
                child: Text(
                  a as String,
                  softWrap: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
