import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:im_stepper/stepper.dart';

class ICreatePatientScreen extends StatefulWidget {
  const ICreatePatientScreen({Key? key}) : super(key: key);

  @override
  _ICreatePatientScreenState createState() => _ICreatePatientScreenState();
}

class _ICreatePatientScreenState extends State<ICreatePatientScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  int activeStep = 0;
  final stepCount = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Patient'),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: DotStepper(
                activeStep: activeStep,
                dotCount: stepCount,
                dotRadius: 10,
                spacing: 12,
                fixedDotDecoration: FixedDotDecoration(
                  strokeWidth: 0,
                  strokeColor: Colors.grey,
                  color: Colors.grey,
                ),
                indicatorDecoration: IndicatorDecoration(
                  strokeWidth: 0,
                  strokeColor: Colors.teal,
                  color: Colors.teal,
                ),
                indicator: Indicator.slide,
              ),
            ),
            steps(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [previousButton(), nextButton()],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column steps() {
    switch (activeStep) {
      case 0:
        return Column(
          children: [Text('0')],
        );
      case 1:
        return Column(
          children: [Text('1')],
        );
      case 2:
        return Column(
          children: [Text('2')],
        );
      default:
        return Column(
          children: [
            Text('Sanity check'),
          ],
        );
    }
  }

  /// Returns the next button widget.
  Widget nextButton() {
    return ElevatedButton(
      child: const Text('Next'),
      onPressed: () {
        /// ACTIVE STEP MUST BE CHECKED FOR (dotCount - 1) AND NOT FOR dotCount To PREVENT Overflow ERROR.
        if (activeStep < stepCount - 1) {
          setState(() {
            activeStep++;
          });
        }
      },
    );
  }

  /// Returns the previous button widget.
  Widget previousButton() {
    return ElevatedButton(
      child: const Text('Prev'),
      onPressed: () {
        // activeStep MUST BE GREATER THAN 0 TO PREVENT OVERFLOW.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
    );
  }
}
