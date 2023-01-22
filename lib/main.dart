import 'package:fever_friend_app/get_it.dart';
import 'package:fever_friend_app/models/patient.dart';
import 'package:fever_friend_app/providers.dart';
import 'package:fever_friend_app/providers/patient_provider.dart';
import 'package:fever_friend_app/routes.dart';
import 'package:fever_friend_app/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'screens/screen_definition.dart';
import 'screens/screens.dart';
import 'firebase_options.dart';

Future<void> main() async {
  setupGetIt();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          String initialRoute = !snapshot.hasData
              ? ScreenDefinition.splash
              : !snapshot.data!.emailVerified
                  ? ScreenDefinition.verify
                  : ScreenDefinition.root;

          return StreamProvider<List<Patient>>.value(
            value: snapshot.data != null
                ? getIt
                    .get<FirestoreService>()
                    .streamPatients(snapshot.data!.uid)
                : Stream.value([]),
            initialData: const [],
            child: Consumer<List<Patient>>(
              builder: (context, value, child) {
                return ChangeNotifierProxyProvider<List<Patient>,
                    PatientProvider>(
                  create: (context) {
                    return PatientProvider(value);
                  },
                  update: (context, value, previous) {
                    if (previous == null) PatientProvider(value);
                    return previous!.updatePatientList(value);
                  },
                  child: AppWidget(initialRoute: initialRoute),
                );
              },
            ),
          );
        });
  }
}

class AppWidget extends StatelessWidget {
  const AppWidget({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CS310 The Fever Friend App',
      theme: ThemeData(
          primarySwatch: Colors.orange,
          // Add the 5 lines from here...
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: UnderlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32)),
              // borderSide: BorderSide(
              //   style: BorderStyle.none,
              //   width: 0.0,
              // ),
            ),
            filled: true,
            fillColor: Colors.white,
            
          )),
      initialRoute: initialRoute,
      routes: appRoutes,
    );
  }
}
