import 'package:flutter/material.dart';

import '../models/patient.dart';

class PatientProvider with ChangeNotifier {
  Patient? _patient;
  List<Patient> _patients = [];

  Patient? get patient => _patient;

  set patient(Patient? patient) {
    _patient = patient;
    notifyListeners();
  }

  List<Patient> get patientList => _patients;

  PatientProvider updatePatientList(List<Patient> list) {
    _patients = list;
    if (list.isNotEmpty && _patient == null) {
      _patient = list.first;
    }
    notifyListeners();
    return this;
  }

  PatientProvider(List<Patient>? patients) {
    _patients = patients ?? [];
    if (patients != null && patients.isNotEmpty) {
      _patient = patients.first;
      notifyListeners();
    }
  }

  void setPatientByID(String id) {
    final res = _patients.where((element) => element.id == id).toList().first;

    _patient = res;
    notifyListeners();
  }

  void addPatient(Patient newPatient) {
    _patient = newPatient;
    _patients.add(newPatient);
    notifyListeners();
  }
}
