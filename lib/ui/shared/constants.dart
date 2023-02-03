// ignore_for_file: non_constant_identifier_names

import 'package:fever_friend_app/models/models.dart';
import 'package:flutter/material.dart';

Color COLOR_GOOD = Colors.lightGreenAccent[400]!;
Color COLOR_CAUTION = Colors.amber[800]!;
Color COLOR_DANGER = Colors.red;
Color COLOR_NEUTRAL = Colors.blueGrey[100]!;

Color stateToColor(PatientState? state) {
  if (state == PatientState.good) {
    return COLOR_GOOD;
  } else if (state == PatientState.caution) {
    return COLOR_CAUTION;
  } else if (state == PatientState.danger) {
    return COLOR_DANGER;
  } else {
    return COLOR_NEUTRAL;
  }
}

double TEMPERATURE_MIN = 34.0;
double TEMPERATURE_MAX = 43.0;

double PULSE_MIN = 40.0;
double PULSE_MAX = 220.0;

double RRATE_MIN = 10.0;
double RRATE_MAX = 80.0;

double WEIGHT_MIN = 2.0;
double WEIGHT_MAX = 150.0;

double HEIGHT_MIN = 50.0;
double HEIGHT_MAX = 220.0;
