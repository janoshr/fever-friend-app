import 'package:fever_friend_app/utils/tuple.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class IRadioGroup extends StatelessWidget {
  final String name;
  final String label;
  final List<Tuple> answer;
  final bool isRequired;
  final ValueChanged<String>? onChanged;

  /// Value of the option -> first of tuple
  final List<String>? disabled;
  final OptionsOrientation orientation;
  final bool enabled;
  final String? initialValue;

  const IRadioGroup({
    Key? key,
    required this.name,
    required this.label,
    required this.answer,
    this.isRequired = false,
    this.onChanged,
    this.disabled,
    this.orientation = OptionsOrientation.vertical,
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
      child: FormBuilderRadioGroup(
        // selectedColor: Theme.of(context).primaryColor,
        // backgroundColor: Colors.grey[100],
        materialTapTargetSize: MaterialTapTargetSize.padded,
        name: name,
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
        // orientation: OptionsOrientation.vertical,
        validator: FormBuilderValidators.compose([
          if (isRequired) FormBuilderValidators.required(),
        ]),
        onChanged: changeHandler,
        disabled: disabled,
        enabled: enabled,
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        orientation: orientation,
        options: List<FormBuilderChipOption>.from(
          answer.map(
            (a) => FormBuilderChipOption(
              value: a.first,
              child: SizedBox(
                width: orientation == OptionsOrientation.horizontal
                    ? null
                    : double.infinity,
                child: Text(
                  a.second,
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
