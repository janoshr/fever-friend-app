import 'package:flutter/material.dart';

import '../models/illness.dart';

class IllnessProvider with ChangeNotifier {
  Illness? _illness;

  Illness? get illness => _illness;
  bool get isActive =>
      _illness != null &&
      ((_illness!.createdAt.difference(DateTime.now()).inHours < 48) ||
          (_illness!.updatedAt != null &&
              _illness!.updatedAt!.difference(DateTime.now()).inHours < 48));

  set illness(Illness? illness) {
    _illness = illness;
    notifyListeners();
  }

  IllnessProvider update(Illness illness) {
    _illness = illness;
    return this;
  }

  IllnessProvider(Illness? illness) {
    _illness = illness;
  }
}
