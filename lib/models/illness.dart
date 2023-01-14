import 'package:cloud_firestore/cloud_firestore.dart';
import 'fever_measurement.dart';
import 'illness_review.dart';
import 'package:json_annotation/json_annotation.dart';

part 'illness.g.dart';

@JsonSerializable()
class Illness {
  @JsonKey(toJson: toNull, includeIfNull: false)
  String id;
  
  List<FeverMeasurement> feverMeasurements;
  IllnessReview? illnessReview;

  Illness({
    required this.id,
    this.feverMeasurements = const [],
    this.illnessReview,
  });

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
