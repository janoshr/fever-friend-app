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
