import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class IRadioGroup extends StatelessWidget {
  String name;
  String label;
  List<String> answer;

  IRadioGroup({
    Key? key,
    required this.name,
    required this.label,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FormBuilderRadioGroup(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        name: name,
        decoration: InputDecoration(
          label: Text(label),
        ),
        orientation: OptionsOrientation.vertical,
        options: List<FormBuilderFieldOption>.from(
            answer.map((a) => FormBuilderFieldOption(
                  value: a,
                  child: SizedBox(
                    height: 18,
                    width: double.infinity,
                    child: Text(a),
                  ),
                ))),
      ),
    );
  }
}
