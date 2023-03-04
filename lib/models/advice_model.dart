class AdviceModel {
  final String key;
  final int importance;
  final String title;
  final String? link;
  final String content;
  List<ConditionModel> conditions = [];

  AdviceModel({
    required this.key,
    required this.importance,
    required this.content,
    required this.title,
    this.link,
  });

  void addCondition(ConditionModel condition) {
    conditions.add(condition);
  }

  void addConditionList(Iterable<ConditionModel> list) {
    conditions.addAll(list);
  }

  void removeCondition(ConditionModel condition) {
    conditions.remove(condition);
  }

  @override
  String toString() {
    return 'Advice<key: $key, importance: $importance, title: $title, condition#: ${conditions.length}>';
  }
}

class ConditionModel {
  final String adviceKey;
  final String field;
  final String op;
  final dynamic value;

  const ConditionModel({
    required this.adviceKey,
    required this.field,
    required this.op,
    required this.value,
  });

  @override
  String toString() {
    return 'Condition<adviceKey: $adviceKey, field: $field, op: $op, value: $value>';
  }
}