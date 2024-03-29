import 'dart:async';

import 'package:fever_friend_app/models/models.dart';
import 'package:fever_friend_app/services/get_it.dart';
import 'package:fever_friend_app/models/notification.dart';
import 'package:fever_friend_app/services/illness_provider.dart';
import 'package:fever_friend_app/services/patient_provider.dart';
import 'package:fever_friend_app/routes.dart';
import 'package:fever_friend_app/services/firestore.dart';
import 'package:fever_friend_app/shared/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:provider/provider.dart';

import './l10n/app_localizations.dart';
import 'screens/screen_definition.dart';
import 'screens/screens.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupGetIt();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);

  runApp(
    const MyApp(),
  );
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  debugPrint("Handling a background message: ${message.messageId}");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription fcmSubscription;

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

    // TODO log notis
    fcmSubscription =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint(
            'Message also contained a notification: ${message.notification}');
      }
    });
  }

  @override
  void dispose() {
    fcmSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        String initialRoute = !snapshot.hasData
            ? ScreenDefinition.splash
            : !snapshot.data!.emailVerified
                // ? ScreenDefinition.verify
                ? ScreenDefinition.home
                : ScreenDefinition.home;

        final db = getIt.get<FirestoreService>();
        return MultiProvider(
          providers: [
            StreamProvider<List<Patient>>.value(
              value: snapshot.data != null
                  ? db.streamPatients(snapshot.data!.uid)
                  : Stream.value([]),
              initialData: const [],
            ),
            StreamProvider<List<INotification>>.value(
              value: snapshot.data != null
                  ? db.streamNotifications()
                  : Stream.value([]),
              initialData: const [],
            ),
          ],
          child: Consumer<List<Patient>>(
            builder: (context, value, child) {
              return ChangeNotifierProxyProvider<List<Patient>,
                  PatientProvider>(
                create: (context) {
                  return PatientProvider(value);
                },
                update: (context, value, previous) {
                  if (previous == null) return PatientProvider(value);
                  return previous.updatePatientList(value);
                },
                child: Consumer<PatientProvider>(
                  builder: (context, patientProvider, _) =>
                      FutureProvider<List<Illness>>.value(
                    value: db.getIllnesses(patientProvider.patient?.id),
                    initialData: const [],
                    child: Consumer<List<Illness>>(
                      builder: (context, illnesses, _) =>
                          ChangeNotifierProxyProvider<List<Illness>,
                              IllnessProvider>(
                        update: (context, value, previous) {
                          if (previous == null) return IllnessProvider(value);
                          return previous.updateIllnessList(value);
                        },
                        create: (context) => IllnessProvider(illnesses),
                        child: AppWidget(initialRoute: initialRoute),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
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
    final patientProvider = Provider.of<PatientProvider>(context);
    final primaryColor = generateMaterialColor(
        patientProvider.patient != null &&
                patientProvider.patient!.color != null
            ? patientProvider.patient!.color!
            : Colors.teal);

    return MaterialApp(
      title: 'CS310 The Fever Friend App',
      theme: ThemeData(
          primarySwatch: primaryColor,
          // Add the 5 lines from here...
          appBarTheme: AppBarTheme(
            backgroundColor: primaryColor,
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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
