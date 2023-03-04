// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map json) => Patient(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: fromTimestampToDate(json['createdAt'] as Timestamp),
      dateOfBirth: fromTimestampToDate(json['dateOfBirth'] as Timestamp),
      gender: json['gender'] as String,
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      chronicDiseases: (json['chronicDiseases'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      siblings: json['siblings'] as int?,
      updatedAt: fromTimestampToDateNullable(json['updatedAt'] as Timestamp?),
      color: colorFromJson(json['color'] as int?),
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
  val['dateOfBirth'] = fromDateToTimestamp(instance.dateOfBirth);
  val['siblings'] = instance.siblings;
  val['createdAt'] = fromDateToTimestamp(instance.createdAt);
  val['updatedAt'] = fromDateToTimestampNullable(instance.updatedAt);
  val['chronicDiseases'] = instance.chronicDiseases;
  val['color'] = colorToJson(instance.color);
  return val;
}
