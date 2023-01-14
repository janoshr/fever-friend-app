import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientProvider with ChangeNotifier {
  String? _id;

  get patientId => _id;

  void changePatient(String id) {
    _id = id;
    notifyListeners();
  }
}
