// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fever_friend_app/models/models.dart';
import 'package:fever_friend_app/models/notification.dart';
import 'package:fever_friend_app/services/advice_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'get_it.dart';
import 'model_service.dart';

const String USERS = 'users';
const String PATIENTS = 'patients';
const String ILLNESSES = 'illnesses';
const String MEASUREMENTS = 'measurements';
const String NOTIFICATIONS = 'notifications';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<IUser?> getUser() async {
    if (_auth.currentUser == null) return null;
    final snap = await _db.collection(USERS).doc(_auth.currentUser!.uid).get();
    return IUser.fromFirestore(snap);
  }

  Stream<IUser?> streamUser() {
    if (_auth.currentUser == null) return Stream.value(null);
    return _db
        .collection(USERS)
        .doc(_auth.currentUser!.uid)
        .snapshots()
        .map((snap) => IUser.fromFirestore(snap));
  }

  Future<void> updateUser(IUser updatedUser) async {
    final ref = _db.collection(USERS).doc(updatedUser.id);

    ref.update(updatedUser.toJson());
  }

  Future<void> createUser(IUser newUser) async {
    return await _db.collection(USERS).doc(newUser.id).set(newUser.toJson());
  }

  Future createPatient(Patient patient) async {
    return await _db
        .collection(USERS)
        .doc(_auth.currentUser!.uid)
        .collection(PATIENTS)
        .add(patient.toJson());
  }

  Future<Illness> createFeverMeasurement(
      Patient patient, MeasurementModel measurement, String patientId) async {
    final modelService = getIt.get<ModelService>();
    final adviceService = getIt.get<AdviceKnowledgeBase>();

    final measurementState =
        await modelService.getPatientState(patient, measurement);

    debugPrint('Model service reponded with ${measurementState.toString()}');

    measurement.state = measurementState;

    measurement.adviceKeys = adviceService.getRelevantAdviceList(
      patient,
      measurementState,
      measurement.data.feverSection.temperature,
    );

    final res = await _db.runTransaction((transaction) async {
      // First create an illness
      final illnessRef = _db
          .collection(USERS)
          .doc(_auth.currentUser!.uid)
          .collection(PATIENTS)
          .doc(patientId)
          .collection(ILLNESSES)
          .doc();
      final illness = Illness(id: illnessRef.id, createdAt: DateTime.now());
      transaction.set(illnessRef, illness.toJson());

      // Add first measurement
      final measurementRef = _db
          .collection(USERS)
          .doc(_auth.currentUser!.uid)
          .collection(PATIENTS)
          .doc(patientId)
          .collection(ILLNESSES)
          .doc(illnessRef.id)
          .collection(MEASUREMENTS)
          .doc();
      transaction.set(measurementRef, measurement.toJson());
      measurement.id = measurementRef.id;

      illness.feverMeasurements = [measurement, ...illness.feverMeasurements];

      return illness;
    });

    return res;
  }

  Future<Illness> addMeasurement(
      Patient patient,
      MeasurementModel measurementModel,
      String patientId,
      Illness illness) async {
    final modelService = getIt.get<ModelService>();
    final adviceService = getIt.get<AdviceKnowledgeBase>();

    final measurementState =
        await modelService.getPatientState(patient, measurementModel);

    debugPrint('Model service reponded with ${measurementState.toString()}');

    measurementModel.state = measurementState;

    measurementModel.adviceKeys = adviceService.getRelevantAdviceList(
      patient,
      measurementState,
      measurementModel.data.feverSection.temperature,
    );

    if (!illness.isActive) {
      throw InactiveIllnessException('in addMeasurement');
    }
    final res = await _db.runTransaction((transaction) async {
      // update timestamp
      illness.updatedAt = DateTime.now();
      final illnessRef = _db
          .collection(USERS)
          .doc(_auth.currentUser!.uid)
          .collection(PATIENTS)
          .doc(patientId)
          .collection(ILLNESSES)
          .doc(illness.id);

      transaction.update(illnessRef, illness.toJson());

      final measurementsRef = _db
          .collection(USERS)
          .doc(_auth.currentUser!.uid)
          .collection(PATIENTS)
          .doc(patientId)
          .collection(ILLNESSES)
          .doc(illness.id)
          .collection(MEASUREMENTS)
          .doc();

      transaction.set(measurementsRef, measurementModel.toJson());
      measurementModel.id = measurementsRef.id;
      illness.feverMeasurements.add(measurementModel);

      return illness;
    });

    return res;
  }

  Stream<List<Patient>> streamPatients(String id) {
    return _db.collection(USERS).doc(id).collection(PATIENTS).snapshots().map(
        (list) =>
            list.docs.map((snap) => Patient.fromFirestore(snap)).toList());
  }

  Future<Patient?> getFirstPatient() async {
    final ref = await _db
        .collection(USERS)
        .doc(_auth.currentUser!.uid)
        .collection(PATIENTS)
        .limit(1)
        .get();
    return Patient.fromFirestore(ref.docs.first);
  }

  Stream<List<INotification>> streamNotifications() {
    return _db
        .collection(USERS)
        .doc(_auth.currentUser!.uid)
        .collection(NOTIFICATIONS)
        .limit(20)
        .snapshots()
        .map((list) => list.docs
            .map((snap) => INotification.fromFirestore(snap))
            .toList());
  }

  Future<List<Illness>> getIllnesses(String? patientId) async {
    if (patientId == null) {
      return Future.value([]);
    }

    final ref = await _db
        .collection(USERS)
        .doc(_auth.currentUser!.uid)
        .collection(PATIENTS)
        .doc(patientId)
        .collection(ILLNESSES)
        .orderBy('createdAt', descending: true)
        .get();
    final illnesses =
        ref.docs.map((event) => Illness.fromFirestore(event)).toList();

    return await Future.wait(illnesses.map((il) async {
      final measurements = await _getMeasurements(patientId, il.id);
      il.feverMeasurements = measurements;
      return il;
    }).toList())
        .catchError((error) {
      debugPrint(error.toString());
      if (error is Error) {
        debugPrintStack(stackTrace: error.stackTrace);
      }
      return <Illness>[];
    });
  }

  Future<List<MeasurementModel>> _getMeasurements(
      String patientId, String illnessId) async {
    final ref = await _db
        .collection(USERS)
        .doc(_auth.currentUser!.uid)
        .collection(PATIENTS)
        .doc(patientId)
        .collection(ILLNESSES)
        .doc(illnessId)
        .collection(MEASUREMENTS)
        .orderBy('meta.createdAt', descending: true)
        .get();
    return ref.docs
        .map((snapshot) => MeasurementModel.fromFirestore(snapshot))
        .toList();
  }
}

class InactiveIllnessException implements Exception {
  final String? message;
  InactiveIllnessException(this.message);

  @override
  String toString() {
    return 'InactiveIllnessException: $message';
  }
}
