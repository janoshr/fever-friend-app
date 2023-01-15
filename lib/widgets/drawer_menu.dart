import 'package:fever_friend_app/models/patient.dart';
import 'package:fever_friend_app/providers/patient_provider.dart';
import 'package:fever_friend_app/screens/screen_definition.dart';
import 'package:fever_friend_app/services/db.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final db = FirestoreService();
    final formatter = DateFormat('YYYY/MM/DD');

    return Drawer(
      child: StreamBuilder<List<Patient>>(
        stream: db.streamPatients(),
        builder: (context, snapshot) {
          final patients = snapshot.data;
          final patientProvider = Provider.of<PatientProvider>(context);
          if (patientProvider.patient == null &&
              patients != null &&
              patients.isNotEmpty) {
            patientProvider.changePatient(patients.first);
          }
          Patient patient = context.read<PatientProvider>().patient;

          return ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                accountName: Text(patient.name),
                accountEmail: Text(
                  user.email ?? 'email not found',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                currentAccountPicture: const FlutterLogo(),
              ),
              if (patients != null)
                ...patients
                    .map((e) => ListTile(
                          dense: true,
                          subtitle: Text(formatter.format(e.dateOfBirth)),
                          leading: const Icon(Icons.account_circle),
                          title: Text(e.name),
                          iconColor: Color((math.Random(e.name.codeUnits.reduce(
                                          (value, element) =>
                                              value + element)).nextDouble() *
                                      0xFFFFFF)
                                  .toInt())
                              .withOpacity(1.0),
                          // TODO: handle patient select
                          onTap: () {},
                        ))
                    .toList(),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home page'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_circle_outline),
                title: const Text('Add Patient'),
                onTap: () {
                  Navigator.pushNamed(context, ScreenDefinition.createPatient);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pushNamed(context, ScreenDefinition.settings);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log out'),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/splash', ((route) => false));
                },
              ),
              const AboutListTile(
                // <-- SEE HERE
                icon: Icon(
                  Icons.info,
                ),
                applicationIcon: Icon(
                  Icons.local_play,
                ),
                applicationName: 'My Cool App',
                applicationVersion: '1.0.25',
                applicationLegalese: '© 2023 Civil Support',
                aboutBoxChildren: [
                  ///Content goes here...
                ],
                child: Text('About app'),
              ),
            ],
          );
        },
      ),
    );
  }
}
