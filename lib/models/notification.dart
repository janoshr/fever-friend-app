import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable(explicitToJson: true)
class INotification {
  @JsonKey(toJson: toNull, includeIfNull: false)
  final String id;

  @JsonKey(required: true)
  final String title;

  final String content;

  final String? patientId;

  final DateTime createdAt;

  final DateTime scheduledAt;

  final bool sent;

  INotification({
    required this.title,
    required this.id,
    required this.createdAt,
    required this.scheduledAt,
    this.content = '',
    this.sent = true,
    this.patientId,
  });

  static toNull(_) => null;

  factory INotification.fromJson(Map<String, dynamic> json) =>
      _$INotificationFromJson(json);

  factory INotification.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;

    data['id'] = doc.id;

    return _$INotificationFromJson(data);
  }

  Map<String, dynamic> toJson() => _$INotificationToJson(this);
}
