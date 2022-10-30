import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'screens/screen_definition.dart';
import 'screens/screens.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static get initialRoute {
    final auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      return ScreenDefinition.splash;
    } else if (!auth.currentUser!.emailVerified &&
        auth.currentUser!.email != null) {
      return ScreenDefinition.verify;
    }
    return ScreenDefinition.root;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the const from here
      title: 'CS310 The Fever Friend App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        // Add the 5 lines from here...
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: initialRoute,
      routes: {
        ScreenDefinition.root: (context) => const IHomeScreen(),
        ScreenDefinition.splash: (context) => const ISplashScreen(),
        ScreenDefinition.login: (context) => const ISignInScreen(),
        ScreenDefinition.profile: (context) => const IProfileScreen(),
        ScreenDefinition.register: (context) => const IRegisterScreen(),
        ScreenDefinition.verify: (context) => const IVerifyEmailScreen(),
        ScreenDefinition.forgot: (context) => const IForgotScreen(),
        ScreenDefinition.createPatient: (context) =>
            const ICreatePatientScreen(),
      },
    );
  }
}
