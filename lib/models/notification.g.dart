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
    createdAt: DateTime.parse(json['createdAt'] as String),
    scheduledAt: DateTime.parse(json['scheduledAt'] as String),
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
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['scheduledAt'] = instance.scheduledAt.toIso8601String();
  val['sent'] = instance.sent;
  return val;
}
