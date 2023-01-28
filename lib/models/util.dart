import 'package:cloud_firestore/cloud_firestore.dart';

DateTime fromTimestampToDate(Timestamp ts) =>
    DateTime.fromMillisecondsSinceEpoch(ts.millisecondsSinceEpoch);
Timestamp fromDateToTimestamp(DateTime time) =>
    Timestamp.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);

DateTime? fromTimestampToDateNullable(Timestamp? ts) => ts == null
    ? null
    : DateTime.fromMillisecondsSinceEpoch(ts.millisecondsSinceEpoch);
Timestamp? fromDateToTimestampNullable(DateTime? time) => time == null
    ? null
    : Timestamp.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
