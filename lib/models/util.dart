import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

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

int? colorToJson(Color? color) => color?.value;

Color? colorFromJson(int? color) => color != null ? Color(color) : null;
