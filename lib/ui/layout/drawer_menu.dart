import 'package:fever_friend_app/services/get_it.dart';
import 'package:fever_friend_app/models/patient.dart';
import 'package:fever_friend_app/services/patient_provider.dart';
import 'package:fever_friend_app/screens/screen_definition.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:fever_friend_app/ui/shared/utils.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);
    Patient? patient = patientProvider.patient;
    final patientList = patientProvider.patientList;
    PackageInfo pi = getIt.get<PackageInfo>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            accountName: Text(patient?.name ?? 'Loading...'),
            accountEmail: Text(patient?.dateOfBirth != null
                ? dateFYYYYMMDD.format(patient!.dateOfBirth)
                : 'Loading...'),
            currentAccountPicture: Icon(
              Icons.account_circle,
              color: getIconColor(patient?.name ?? 'n/a'),
              size: 48,
            ),
          ),
          ...patientList
              .map(
                (p) => ListTile(
                  dense: true,
                  subtitle: Text(dateFYYYYMMDD.format(p.dateOfBirth)),
                  leading: const Icon(Icons.account_circle),
                  title: Text(p.name),
                  iconColor: getIconColor(p.name),
                  onTap: () {
                    patientProvider.setPatientByID(p.id);
                  },
                ),
              )
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
          AboutListTile(
            // <-- SEE HERE
            icon: const Icon(
              Icons.info,
            ),
            applicationIcon: const Icon(
              Icons.info,
            ),
            applicationName: pi.appName,
            applicationVersion: pi.version,
            applicationLegalese: '© 2023 Civil Support',
            aboutBoxChildren: const [
              Text('Developer: Janos Hajdu Rafis'),
            ],
            child: const Text('About app'),
          ),
        ],
      ),
    );
  }
}
