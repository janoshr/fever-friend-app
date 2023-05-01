# fever_friend_app

## Developing FeverFellow, a mobile application for fever management

Fevers and illnesses have always been a part of our lives, but not everyone knows how to deal with them appropriately. This project aims to develop a mobile application with Dart and Flutter, mainly for parents and carers to help them manage their children’s or patients’ fevers. The application helps by educating its users about fever and fever management. The application also determines the severity of the patient’s condition by asking a series of questions both about the patient’s condition and the carer’s confidence in handling the fever. Depending on the severity of the condition determined by machine learning models, the app would advise the carer on what to do. The app also provides visuals and analysis of the progression and history of their patient’s illnesses. The app combines some features from related applications in the industry for core functionalities but further extends it with additional features, such as a random forest learning model for assessing conditions and a rule-based expert system AI to give personalized advice to users.

## Flutter Essentials

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Generate commands

Generating localization files: `flutter gen-l10n`

Generating JSON serializatioon files: `build_runner.sh`

## Starting the project

Connect the emulator of choice to Flutter, it is recommended to use the Flutter extension for VSCode, all recommended extensions can be found in the `.vscode` folder.

Once the emulator is connected execute the following command

```bash
flutter run
```

Development versions are the following:

```
Flutter 3.7.0 • channel stable • https://github.com/flutter/flutter.git
Framework • revision b06b8b2710 (3 months ago) • 2023-01-23 16:55:55 -0800
Engine • revision b24591ed32
Tools • Dart 2.19.0 • DevTools 2.20.1
```