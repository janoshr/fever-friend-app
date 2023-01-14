import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'illness_review.g.dart';

@JsonSerializable()
class IllnessReview {
  @JsonKey(toJson: toNull, includeIfNull: false)
  String id;
  DateTime createdAt;
  DateTime? updatedAt;

  String illnessState;

  String? patientIllnessState;
  String? gotToDoctorReview;
  String? antipyreticMedicationReview;
  String? antibioticsMedicationReview;
  String? gotToDoctorHowReview;

  IllnessReview({
    required this.createdAt,
    required this.id,
    required this.illnessState,
    this.antibioticsMedicationReview,
    this.antipyreticMedicationReview,
    this.gotToDoctorHowReview,
    this.gotToDoctorReview,
    this.patientIllnessState,
    this.updatedAt,
  });

  factory IllnessReview.fromJson(Map<String, dynamic> json) =>
      _$IllnessReviewFromJson(json);

  factory IllnessReview.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;

    data['id'] = doc.id;

    return _$IllnessReviewFromJson(data);
  }

  Map<String, dynamic> toJson() => _$IllnessReviewToJson(this);

  static toNull(_) => null;
}
