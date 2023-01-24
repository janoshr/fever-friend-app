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
