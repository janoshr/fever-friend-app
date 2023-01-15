import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/patient.dart';

class PatientProvider with ChangeNotifier {
  Patient? _patient;

  get patient => _patient;

  void changePatient(Patient selectedPatient) {
    _patient = selectedPatient;
    notifyListeners();
  }
}
