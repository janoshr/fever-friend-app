import 'package:fever_friend_app/services/get_it.dart';
import 'package:fever_friend_app/models/user.dart';
import 'package:fever_friend_app/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'screen_definition.dart';

final userCreatedAction =
    AuthStateChangeAction<UserCreated>(((context, state) async {
  if (!state.credential.user!.emailVerified) {
    // TODO: change to verify
    // Navigator.pushNamed(context, ScreenDefinition.home);
    Navigator.pushReplacementNamed(context, ScreenDefinition.createPatient);
  } else {
    Navigator.pushReplacementNamed(context, ScreenDefinition.createPatient);
  }
  final db = getIt.get<FirestoreService>();
  final user = IUser(
    email: state.credential.user!.email!,
    id: state.credential.user!.uid,
    createdAt: DateTime.now(),
  );

  await db.createUser(user);
}));

class ISignInScreen extends StatelessWidget {
  const ISignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      actions: [
        AuthStateChangeAction<SignedIn>(((context, state) {
          if (!state.user!.emailVerified) {
            // TODO: change to verify
            Navigator.pushNamed(context, ScreenDefinition.home);
          } else {
            Navigator.pushReplacementNamed(context, ScreenDefinition.home);
          }
        })),
        ForgotPasswordAction(((context, email) {
          Navigator.pushNamed(
            context,
            ScreenDefinition.forgot,
            arguments: {'email': email},
          );
        })),
        userCreatedAction
      ],
    );
  }
}

class IRegisterScreen extends StatelessWidget {
  const IRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseUIActions(
      actions: [
        userCreatedAction,
      ],
      child: const RegisterScreen(),
    );
  }
}

class IVerifyEmailScreen extends StatelessWidget {
  const IVerifyEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmailVerificationScreen(
      actions: [
        EmailVerifiedAction((() {
          Navigator.pushReplacementNamed(context, ScreenDefinition.home);
        })),
        AuthCancelledAction(((context) {
          FirebaseUIAuth.signOut(context: context);
          Navigator.pushReplacementNamed(context, ScreenDefinition.splash);
        }))
      ],
    );
  }
}

class IForgotScreen extends StatelessWidget {
  const IForgotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return ForgotPasswordScreen(
      email: arguments['email'],
    );
  }
}
