// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'illness.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Illness _$IllnessFromJson(Map<String, dynamic> json) => Illness(
      id: json['id'] as String,
      feverMeasurements: (json['feverMeasurements'] as List<dynamic>?)
              ?.map((e) => FeverMeasurement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      illnessReview: json['illnessReview'] == null
          ? null
          : IllnessReview.fromJson(
              json['illnessReview'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IllnessToJson(Illness instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', Illness.toNull(instance.id));
  val['feverMeasurements'] = instance.feverMeasurements;
  val['illnessReview'] = instance.illnessReview;
  return val;
}
