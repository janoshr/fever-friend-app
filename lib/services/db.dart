import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fever_friend_app/models/patient.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future getPatient(String id) async {}

  Future<IUser?> getUser() async {
    if (auth.currentUser == null) return null;
    final snap = await _db.collection('users').doc(auth.currentUser!.uid).get();
    return IUser.fromFirestore(snap);
  }

  Stream<IUser?> streamUser() {
    if (auth.currentUser == null) return Stream.value(null);
    return _db
        .collection('users')
        .doc(auth.currentUser!.uid)
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
        .doc(auth.currentUser!.uid)
        .collection('patients')
        .add(patient.toJson());
  }
}
