import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fever_friend_app/models/util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class IUser {
  @JsonKey(toJson: toNull, includeIfNull: false)
  final String id;

  @JsonKey(required: true)
  final String email;

  String lang;

  bool participateInResearch;

  @JsonKey(fromJson: fromTimestampToDate, toJson: fromDateToTimestamp)
  DateTime createdAt;

  @JsonKey(
      fromJson: fromTimestampToDateNullable,
      toJson: fromDateToTimestampNullable)
  DateTime? updatedAt;

  IUser({
    required this.email,
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.lang = 'en',
    this.participateInResearch = true,
  });

  static toNull(_) => null;

  factory IUser.fromJson(Map<String, dynamic> json) => _$IUserFromJson(json);

  factory IUser.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;

    data['id'] = doc.id;

    return _$IUserFromJson(data);
  }

  Map<String, dynamic> toJson() => _$IUserToJson(this);
}
