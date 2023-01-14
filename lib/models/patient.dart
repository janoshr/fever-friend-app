import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  @JsonKey(toJson: toNull, includeIfNull: false)
  String id;

  String name;
  String weight;
  String height;
  String gender;
  DateTime dateOfBirth;
  int? siblings;
  DateTime createdAt;
  DateTime? updatedAt;
  List<String> chronicDiseases;

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
  });

  static toNull(_) => null;

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  factory Patient.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;

    data['id'] = doc.id;

    return _$PatientFromJson(data);
  }

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
