// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fever_friend_app/models/models.dart';
import 'package:fever_friend_app/models/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String USERS = 'users';
const String PATIENTS = 'patients';
const String ILLNESSES = 'illnesses';
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

  Future createFeverMeasurement(
      MeasurementModel measurement, String patientId) async {
    // TODO connect measurement to illness
    return await _db
        .collection(USERS)
        .doc(_auth.currentUser!.uid)
        .collection(PATIENTS)
        .doc(patientId)
        .collection(ILLNESSES)
        .add(measurement.toJson());
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
}
