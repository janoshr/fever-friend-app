// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'illness.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Illness _$IllnessFromJson(Map json) => Illness(
      id: json['id'] as String,
      feverMeasurements: (json['feverMeasurements'] as List<dynamic>?)
              ?.map((e) => MeasurementModel.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      illnessReview: json['illnessReview'] == null
          ? null
          : IllnessReview.fromJson(
              Map<String, dynamic>.from(json['illnessReview'] as Map)),
      closedAt: fromTimestampToDateNullable(json['closedAt'] as Timestamp?),
      updatedAt: fromTimestampToDateNullable(json['updatedAt'] as Timestamp?),
      createdAt: fromTimestampToDate(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$IllnessToJson(Illness instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', Illness.toNull(instance.id));
  writeNotNull('feverMeasurements', Illness.toNull(instance.feverMeasurements));
  writeNotNull('illnessReview', Illness.toNull(instance.illnessReview));
  val['createdAt'] = fromDateToTimestamp(instance.createdAt);
  val['updatedAt'] = fromDateToTimestampNullable(instance.updatedAt);
  val['closedAt'] = fromDateToTimestampNullable(instance.closedAt);
  return val;
}
