import 'dart:convert';

import 'package:fever_friend_app/models/enums.dart';
import 'package:fever_friend_app/models/fever_measurement.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

import '../models/patient.dart';

const kAndroidLocal = 'http://10.0.2.2:5000/';
const kIOSLocal = 'http://127.0.0.1:5000';
const kLocal = 'http://127.0.0.1:5000';

class ModelService {
  Future<MeasurementModelState> getPatientState(
      Patient patient, MeasurementModel measurementModel) async {
    String url;
    if (kReleaseMode) {
      throw UnimplementedError();
    }

    if (Platform.isAndroid) {
      url = kAndroidLocal;
    } else if (Platform.isIOS) {
      url = kIOSLocal;
    } else {
      url = kLocal;
    }

    final body = {
      'row': {
        'ageInMonths': patient.ageInMonths,
        ...measurementModel.data.modelData
      }
    };

    debugPrint('calling api $kLocal');
    debugPrint('data ${jsonEncode(body)}');

    final res = await http.post(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode(body),
    );
    try {
      final data = jsonDecode(res.body);
      // return _$PatientStateEnumMap[data['patientState']]!;
      return MeasurementModelState(
        feverState: _$PatientStateEnumMap.containsKey(data['fever'])
            ? _$PatientStateEnumMap[data['fever']]
            : null,
        caregiverState: _$PatientStateEnumMap.containsKey(data['caregiver'])
            ? _$PatientStateEnumMap[data['caregiver']]
            : null,
        generalState: _$PatientStateEnumMap.containsKey(data['general'])
            ? _$PatientStateEnumMap[data['general']]
            : null,
        hydrationState: _$PatientStateEnumMap.containsKey(data['hydration'])
            ? _$PatientStateEnumMap[data['hydration']]
            : null,
        medicationState: _$PatientStateEnumMap.containsKey(data['medication'])
            ? _$PatientStateEnumMap[data['medication']]
            : null,
        patientState: _$PatientStateEnumMap.containsKey(data['patientState'])
            ? _$PatientStateEnumMap[data['patientState']]
            : null,
        pulseState: _$PatientStateEnumMap.containsKey(data['pulse'])
            ? _$PatientStateEnumMap[data['pulse']]
            : null,
        respirationState: _$PatientStateEnumMap.containsKey(data['respiration'])
            ? _$PatientStateEnumMap[data['respiration']]
            : null,
        skinState: _$PatientStateEnumMap.containsKey(data['skin'])
            ? _$PatientStateEnumMap[data['skin']]
            : null,
      );
    } catch (e) {
      debugPrint(res.body);
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}

const _$PatientStateEnumMap = {
  'good': PatientState.good,
  'caution': PatientState.caution,
  'danger': PatientState.danger,
};
