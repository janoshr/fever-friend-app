// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Color COLOR_GOOD = Colors.lightGreenAccent[400]!;
Color COLOR_CAUTION = Colors.amber[800]!;
Color COLOR_DANGER = Colors.red;

Color stateToColor(String state) {
  if (state == 'good') {
    return COLOR_GOOD;
  } else if (state == 'caution') {
    return COLOR_CAUTION;
  } else if (state == 'danger') {
    return COLOR_DANGER;
  } else {
    throw Exception('State $state is not a predefined state');
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
