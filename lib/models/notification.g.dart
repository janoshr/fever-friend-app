// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

INotification _$INotificationFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['title'],
  );
  return INotification(
    title: json['title'] as String,
    id: json['id'] as String,
    createdAt: fromTimestampToDate(json['createdAt'] as Timestamp),
    scheduledAt: fromTimestampToDate(json['scheduledAt'] as Timestamp),
    content: json['content'] as String? ?? '',
    sent: json['sent'] as bool? ?? true,
    patientId: json['patientId'] as String?,
  );
}

Map<String, dynamic> _$INotificationToJson(INotification instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', INotification.toNull(instance.id));
  val['title'] = instance.title;
  val['content'] = instance.content;
  val['patientId'] = instance.patientId;
  val['createdAt'] = fromDateToTimestamp(instance.createdAt);
  val['scheduledAt'] = fromDateToTimestamp(instance.scheduledAt);
  val['sent'] = instance.sent;
  return val;
}
