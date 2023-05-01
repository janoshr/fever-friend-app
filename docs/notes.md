# Notes

Logs and changes, problems that occurred and fixes for them.

## 2023.01.20 Scrolling and Stepper

First for implementing a stepper I used `im_stepper` because it provides a lot of costumization for the stepper's look and has automatic scrolling. It turned out that it does not implement the handling of the step changes so it has to be done manually. The example solution for this in the docs of the package show a `switch-case` solution however this removes and readds widgets causing errors and warnings with the form. Which is why I decided to use the Flutter's built in solution although it provides less costumization it handles step changes better.

Flutter's built in stepper breaks if the horizontal type is used and it overflows. [Github Issue](https://github.com/flutter/flutter/issues/40601).

The proposed solution is to make a copy of the original code and modify the `_buildHorizontal` method so that it is scrollable. [Here](https://github.com/flutter/flutter/issues/40601#issuecomment-1261806752) is the example on how to.

However, when the user is stepping through the sections the header does not scroll with it. So I modified the stepper to take a list of keys for the headers and in the stepping control functions implemented scrolling to the current header. [Here](https://diamantidis.github.io/2021/10/10/exploring-flutter-scrollable-ensurevisible) is how the scrolling works in detail.

## 2023.01.22 Fever Measurement Sections

- GetIt global package info added to be accessible everywhere
- `FeverMeasurement` class factory added to create from `FormBuilderState`
- Unused state variables removed from FeverMeasurement class
- Steps/Sections separated from main Widget using enums for names to make it easier

## 2023.01.24 Basic Home Screen

- Refactor file structure for maintainability
- Basic Home Screen added with dummy data for testing design ideas

## 2023.01.26 Push notification handlers

Very basic push notification handlers have been added. The Android emulator can now receive push notifications both when it is in the foreground or when it is in the background.
Configurations and keys have been added so that iOS devices can also receive notifications. Due to lack of iOS device I cannot test this.

Notification model added; Notifications must have an id, title, content, createdAt, scheduledAt and sent properties.
It can also include a patientId to connect it to one of the patients.

All notifications stored in the Cloud Firestore database are visible in the app. The number of new notifications should be visible on the home page and all details can be seen on their dedicated screen.

## 2023.02.03 Fever Measurement added

Creating a new illness with a fever measurement added. Illness is active calculation added, if the illness is not closed (closedAt is null) and either the creation date or the updated date is within 48 hours the illness is considered to be active. Only active illnesses can be updated with a new measurement.
