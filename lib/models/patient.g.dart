// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      gender: json['gender'] as String,
      height: json['height'] as String,
      weight: json['weight'] as String,
      chronicDiseases: (json['chronicDiseases'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      siblings: json['siblings'] as int?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PatientToJson(Patient instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', Patient.toNull(instance.id));
  val['name'] = instance.name;
  val['weight'] = instance.weight;
  val['height'] = instance.height;
  val['gender'] = instance.gender;
  val['dateOfBirth'] = instance.dateOfBirth.toIso8601String();
  val['siblings'] = instance.siblings;
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['updatedAt'] = instance.updatedAt?.toIso8601String();
  val['chronicDiseases'] = instance.chronicDiseases;
  return val;
}
