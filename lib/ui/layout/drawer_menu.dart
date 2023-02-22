import 'package:fever_friend_app/l10n/app_localizations.dart';
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
    final loc = AppLocalizations.of(context)!;

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: patient?.color ?? getIconColor(patient?.name ?? 'n/a'),
            ),
            accountName: Text(patient?.name ?? loc.loading),
            accountEmail: Text(patient?.dateOfBirth != null
                ? dateFYYYYMMDD.format(patient!.dateOfBirth)
                : loc.loading),
            currentAccountPicture: const Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 48,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ...patientList
                    .map(
                      (p) => ListTile(
                        dense: true,
                        subtitle: Text(dateFYYYYMMDD.format(p.dateOfBirth)),
                        leading: const Icon(Icons.account_circle),
                        title: Text(p.name),
                        iconColor: p.color ?? getIconColor(p.name),
                        onTap: () {
                          patientProvider.setPatientByID(p.id);
                        },
                      ),
                    )
                    .toList(),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: Text(loc.homePage),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_add),
                  title: Text(loc.addPatient),
                  onTap: () {
                    Navigator.pushNamed(
                        context, ScreenDefinition.createPatient);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(loc.settings),
                  onTap: () {
                    Navigator.pushNamed(context, ScreenDefinition.settings);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(loc.signOut),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        ScreenDefinition.splash, ((route) => false));
                  },
                ),
                AboutListTile(
                  // <-- SEE HERE
                  icon: const Icon(Icons.info),
                  applicationIcon: const Icon(Icons.info),
                  applicationName: pi.appName,
                  applicationVersion: pi.version,
                  applicationLegalese: '© 2023 Civil Support',
                  aboutBoxChildren: [
                    const Text('Developer: Janos Hajdu Rafis'),
                    TextButton(
                      onPressed: () {},
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  content: SelectableText(
                                      'Patient ID: ${patient?.id}'),
                                ));
                      },
                      child: const Text('ID info'),
                    ),
                  ],
                  child: Text(loc.aboutApp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
