// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IUser _$IUserFromJson(Map json) {
  $checkKeys(
    json,
    requiredKeys: const ['email'],
  );
  return IUser(
    email: json['email'] as String,
    id: json['id'] as String,
    createdAt: fromTimestampToDate(json['createdAt'] as Timestamp),
    updatedAt: fromTimestampToDateNullable(json['updatedAt'] as Timestamp?),
    lang: json['lang'] as String? ?? 'en',
    participateInResearch: json['participateInResearch'] as bool? ?? true,
  );
}

Map<String, dynamic> _$IUserToJson(IUser instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', IUser.toNull(instance.id));
  val['email'] = instance.email;
  val['lang'] = instance.lang;
  val['participateInResearch'] = instance.participateInResearch;
  val['createdAt'] = fromDateToTimestamp(instance.createdAt);
  val['updatedAt'] = fromDateToTimestampNullable(instance.updatedAt);
  return val;
}
