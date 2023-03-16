import 'package:fever_friend_app/models/fever_measurement.dart';
import 'package:flutter/material.dart';

import '../models/illness.dart';

class IllnessProvider with ChangeNotifier {
  List<Illness>? _illnesses;

  List<Illness> get illnessList => _illnesses ?? [];

  IllnessProvider(List<Illness>? illness) {
    _illnesses = illness;
    notifyListeners();
  }

  void addMeasurement(MeasurementModel model) {
    final list = [...?_illnesses];
    list.first.feverMeasurements.insert(0, model);
    _illnesses = list;
    notifyListeners();
  }

  IllnessProvider updateIllnessList(List<Illness>? list) {
    _illnesses = list;
    notifyListeners();
    return this;
  }

  void addIllness(Illness illness) {
    final list = [illness, ...?_illnesses];
    _illnesses = list;
    notifyListeners();
  }
}
