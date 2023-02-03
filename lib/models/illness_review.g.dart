// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'illness_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IllnessReview _$IllnessReviewFromJson(Map json) => IllnessReview(
      createdAt: DateTime.parse(json['createdAt'] as String),
      id: json['id'] as String,
      illnessState: json['illnessState'] as String,
      antibioticsMedicationReview:
          json['antibioticsMedicationReview'] as String?,
      antipyreticMedicationReview:
          json['antipyreticMedicationReview'] as String?,
      gotToDoctorHowReview: json['gotToDoctorHowReview'] as String?,
      gotToDoctorReview: json['gotToDoctorReview'] as String?,
      patientIllnessState: json['patientIllnessState'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$IllnessReviewToJson(IllnessReview instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', IllnessReview.toNull(instance.id));
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['updatedAt'] = instance.updatedAt?.toIso8601String();
  val['illnessState'] = instance.illnessState;
  val['patientIllnessState'] = instance.patientIllnessState;
  val['gotToDoctorReview'] = instance.gotToDoctorReview;
  val['antipyreticMedicationReview'] = instance.antipyreticMedicationReview;
  val['antibioticsMedicationReview'] = instance.antibioticsMedicationReview;
  val['gotToDoctorHowReview'] = instance.gotToDoctorHowReview;
  return val;
}
