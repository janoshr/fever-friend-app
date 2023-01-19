import 'package:flutter/material.dart';

import 'screens/screens.dart';

Map<String, WidgetBuilder> appRoutes = <String, WidgetBuilder>{
  ScreenDefinition.root: (context) => const IHomeScreen(),
  ScreenDefinition.splash: (context) => const ISplashScreen(),
  ScreenDefinition.login: (context) => const ISignInScreen(),
  ScreenDefinition.profile: (context) => const IProfileScreen(),
  ScreenDefinition.register: (context) => const IRegisterScreen(),
  ScreenDefinition.verify: (context) => const IVerifyEmailScreen(),
  ScreenDefinition.forgot: (context) => const IForgotScreen(),
  ScreenDefinition.createPatient: (context) => const ICreatePatientScreen(),
  ScreenDefinition.settings: (context) => const SettingScreen(),
  ScreenDefinition.createMeasurement: (context) =>
      const ICreateMeasurementScreen(),
};
