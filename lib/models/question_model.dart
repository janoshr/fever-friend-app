import 'package:flutter/material.dart';

enum QuestionType { radio, text, number, checkbox }

abstract class BaseQuestion {
  final String name;
  final String label;
  final bool isRequired;
  final QuestionType type;

  BaseQuestion({
    required this.name,
    required this.label,
    required this.type,
    this.isRequired = false,
  });
}

class RadioQuestion extends BaseQuestion {
  final List<String> answer;

  RadioQuestion({
    required super.name,
    required super.label,
    super.isRequired = false,
    required this.answer,
  }) : super(type: QuestionType.radio);
}

class CheckboxQuestion extends BaseQuestion {
  final List<String> answer;

  CheckboxQuestion({
    required super.name,
    required super.label,
    super.isRequired = false,
    required this.answer,
  }) : super(type: QuestionType.checkbox);
}

class TextQuestion extends BaseQuestion {
  TextQuestion({
    required super.name,
    required super.label,
    super.isRequired = false,
  }) : super(type: QuestionType.text);
}

class NumberQuestion extends BaseQuestion {
  final double min;
  final double max;

  NumberQuestion({
    required super.name,
    required super.label,
    super.isRequired = false,
    required this.min,
    required this.max,
  }) : super(type: QuestionType.number);
}
