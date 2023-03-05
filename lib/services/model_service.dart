import 'dart:convert';

import 'package:fever_friend_app/models/enums.dart';
import 'package:fever_friend_app/models/fever_measurement.dart';
import 'package:flutter/foundation.dart';
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
      final map = PatientState.values.asNameMap();

      return MeasurementModelState(
        feverState: map[data['fever']],
        caregiverState: map[data['caregiver']],
        generalState: map[data['general']],
        hydrationState: map[data['hydration']],
        medicationState: map[data['medication']],
        patientState: map[data['patientState']],
        pulseState: map[data['pulse']],
        respirationState: map[data['respiration']],
        skinState: map[data['skin']],
      );
    } catch (e) {
      debugPrint(res.body);
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
