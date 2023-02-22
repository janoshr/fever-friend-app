import 'dart:convert';

import 'package:fever_friend_app/models/enums.dart';
import 'package:fever_friend_app/models/fever_measurement.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

const kAndroidLocal = 'http://10.0.2.2:5000/';
const kIOSLocal = 'http://127.0.0.1:5000';
const kLocal = 'http://127.0.0.1:5000';

class ModelService {
  Future<PatientState> getPatientState(
      MeasurementModel measurementModel) async {
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

    final body = {'row': measurementModel.data.modelData};

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
      return _$PatientStateEnumMap[data['patientState']]!;
    } catch (e) {
      debugPrint(res.body);
      debugPrint(e.toString());
      return PatientState.good;
    }
  }
}

const _$PatientStateEnumMap = {
  'good': PatientState.good,
  'caution': PatientState.caution,
  'danger': PatientState.danger,
};
