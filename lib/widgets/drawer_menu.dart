import 'package:fever_friend_app/models/patient.dart';
import 'package:fever_friend_app/providers/patient_provider.dart';
import 'package:fever_friend_app/screens/screen_definition.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy/MM/DD');
    final patientProvider = Provider.of<PatientProvider>(context);
    Patient? patient = patientProvider.patient;
    final patientList = patientProvider.patientList;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            accountName: Text(patient?.name ?? 'Loading...'),
            accountEmail: Text(patient?.dateOfBirth != null
                ? formatter.format(patient!.dateOfBirth)
                : 'Loading...'),
            currentAccountPicture: Icon(
              Icons.account_circle,
              color: getIconColor(patient!.name),
              size: 48,
            ),
          ),
          ...patientList
              .map((p) => ListTile(
                    dense: true,
                    subtitle: Text(formatter.format(p.dateOfBirth)),
                    leading: const Icon(Icons.account_circle),
                    title: Text(p.name),
                    iconColor: getIconColor(p.name),
                    onTap: () {
                      patientProvider.setPatientByID(p.id);
                    },
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
            applicationName: 'Warwick Fever Friend',
            applicationVersion: '1.0.25',
            applicationLegalese: '© 2023 Civil Support',
            aboutBoxChildren: [
              ///Content goes here...
            ],
            child: Text('About app'),
          ),
        ],
      ),
    );
  }

  Color getIconColor(String name) {
    return Color((math.Random(name.codeUnits
                    .reduce((value, element) => value + element)).nextDouble() *
                0xFFFFFF)
            .toInt())
        .withOpacity(1.0);
  }
}
