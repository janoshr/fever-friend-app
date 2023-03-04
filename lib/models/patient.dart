import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'util.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  @JsonKey(toJson: toNull, includeIfNull: false)
  String id;

  String name;
  double weight;
  double height;
  String gender;

  @JsonKey(fromJson: fromTimestampToDate, toJson: fromDateToTimestamp)
  DateTime dateOfBirth;

  int? siblings;

  @JsonKey(fromJson: fromTimestampToDate, toJson: fromDateToTimestamp)
  DateTime createdAt;

  @JsonKey(
      fromJson: fromTimestampToDateNullable,
      toJson: fromDateToTimestampNullable)
  DateTime? updatedAt;

  List<String> chronicDiseases;

  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color? color;

  Patient({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.dateOfBirth,
    required this.gender,
    required this.height,
    required this.weight,
    this.chronicDiseases = const [],
    this.siblings,
    this.updatedAt,
    this.color,
  });

  static toNull(_) => null;

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  factory Patient.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;

    data['id'] = doc.id;

    return _$PatientFromJson(data);
  }

  double get ageInMonths =>
      dateOfBirth.difference(DateTime.now()).inDays.abs() / 30;

  Map<String, dynamic> toJson() => _$PatientToJson(this);

  @override
  String toString() {
    return 'Patient<id: $id, name: $name>';
  }
}
