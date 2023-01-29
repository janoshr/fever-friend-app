import 'package:cloud_firestore/cloud_firestore.dart';
import 'fever_measurement.dart';
import 'illness_review.dart';
import 'package:json_annotation/json_annotation.dart';

import 'util.dart';

part 'illness.g.dart';

@JsonSerializable()
class Illness {
  @JsonKey(toJson: toNull, includeIfNull: false)
  String id;

  @JsonKey(toJson: toNull, includeIfNull: false)
  List<MeasurementModel> feverMeasurements;

  @JsonKey(toJson: toNull, includeIfNull: false)
  IllnessReview? illnessReview;

  @JsonKey(fromJson: fromTimestampToDate, toJson: fromDateToTimestamp)
  DateTime createdAt;

  @JsonKey(
      fromJson: fromTimestampToDateNullable,
      toJson: fromDateToTimestampNullable)
  DateTime? updatedAt;

  @JsonKey(
      fromJson: fromTimestampToDateNullable,
      toJson: fromDateToTimestampNullable)
  DateTime? closedAt;

  Illness({
    required this.id,
    this.feverMeasurements = const [],
    this.illnessReview,
    this.closedAt,
    this.updatedAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Illness.fromJson(Map<String, dynamic> json) =>
      _$IllnessFromJson(json);

  factory Illness.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;

    data['id'] = doc.id;

    return _$IllnessFromJson(data);
  }

  Map<String, dynamic> toJson() => _$IllnessToJson(this);

  static toNull(_) => null;
}
