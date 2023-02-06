import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

/// Formats date like `MMM d, hh:mm`
DateFormat dateFMMMDDHmm = DateFormat('MMM d, hh:mm');

/// Formats date like `MMM d`
DateFormat dateFMMMDD = DateFormat('MMM d');

/// Formats date like `yyyy/MM/dd`
DateFormat dateFYYYYMMDD = DateFormat('yyyy/MM/dd');

Color getIconColor(String name) {
  return Color((math.Random(name.codeUnits
                  .reduce((value, element) => value + element)).nextDouble() *
              0xFFFFFF)
          .toInt())
      .withOpacity(1.0);
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    math.max(0, math.min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    math.max(0, math.min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
