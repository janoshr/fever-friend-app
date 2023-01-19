import 'package:fever_friend_app/get_it.dart';
import 'package:fever_friend_app/models/patient.dart';
import 'package:fever_friend_app/providers/patient_provider.dart';
import 'package:fever_friend_app/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> independentServices = [
  StreamProvider.value(
    value: FirebaseAuth.instance.authStateChanges(),
    initialData: null,
  ),
];
List<SingleChildWidget> dependentServices = [
  // option 1
  StreamProvider<List<Patient>>(
    create: (context) {
      final user = Provider.of<User>(context, listen: false);
      print('Create Stream Provider called with | ${user.toString()}');
      return getIt.get<FirestoreService>().streamPatients(user.uid);
    },
    initialData: const [],
  ),
  ChangeNotifierProvider(create: (context) {
    final patients = Provider.of<List<Patient>>(context, listen: false);
    print('PATIENT LIST HERE: ${patients.toString()}');
    return PatientProvider(patients);
  })

  // option 2
  // StreamProvider.value(
  //     value: FirebaseAuth.instance.authStateChanges().asyncExpand((event) =>
  //         event != null
  //             ? getIt.get<FirestoreService>().streamPatients(event.uid)
  //             : Stream.value([])),
  //     initialData: const [])
];

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices
];
