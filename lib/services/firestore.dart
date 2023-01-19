import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fever_friend_app/models/patient.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<IUser?> getUser() async {
    if (_auth.currentUser == null) return null;
    final snap =
        await _db.collection('users').doc(_auth.currentUser!.uid).get();
    return IUser.fromFirestore(snap);
  }

  Stream<IUser?> streamUser() {
    if (_auth.currentUser == null) return Stream.value(null);
    return _db
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .snapshots()
        .map((snap) => IUser.fromFirestore(snap));
  }

  Future<void> updateUser(IUser updatedUser) async {
    final ref = _db.collection('users').doc(updatedUser.id);

    ref.update(updatedUser.toJson());
  }

  Future<void> createUser(IUser newUser) async {
    return await _db.collection('users').doc(newUser.id).set(newUser.toJson());
  }

  Future createPatient(Patient patient) async {
    return await _db
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('patients')
        .add(patient.toJson());
  }

  Stream<List<Patient>> streamPatients(String id) {
    return _db
        .collection('users')
        .doc(id)
        .collection('patients')
        .snapshots()
        .map((list) =>
            list.docs.map((snap) => Patient.fromFirestore(snap)).toList());
  }

  Future<Patient?> getFirstPatient() async {
    final ref = await _db
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('patients')
        .limit(1)
        .get();
    return Patient.fromFirestore(ref.docs.first);
  }
}
