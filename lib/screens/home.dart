import 'package:fever_friend_app/models/models.dart';
import 'package:fever_friend_app/models/notification.dart';
import 'package:fever_friend_app/screens/screen_definition.dart';
import 'package:fever_friend_app/services/firestore.dart';
import 'package:fever_friend_app/services/patient_provider.dart';
import 'package:fever_friend_app/ui/widgets/illness_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/get_it.dart';
import '../ui/layout/drawer_menu.dart';
import '../ui/widgets/illness_card.dart';

// TODO remove dummy data
final illness = Illness(id: 'asdf', feverMeasurements: [
  MeasurementModel(
    id: 'num1',
    data: MeasurementModelData(
      feverSection: FeverSectionModel(
        temperature: 37.8,
      ),
      patientState: PatientState.caution,
    ),
    meta: MeasurementModelMeta(
      createdAt: DateTime.now(),
      numberOfQuestions: 3,
    ),
  ),
  MeasurementModel(
    id: 'num1',
    data: MeasurementModelData(
      feverSection: FeverSectionModel(
        temperature: 37.8,
      ),
      patientState: PatientState.danger,
    ),
    meta: MeasurementModelMeta(
      createdAt: DateTime.now(),
      numberOfQuestions: 3,
    ),
  ),
  MeasurementModel(
    id: 'num1',
    data: MeasurementModelData(
      feverSection: FeverSectionModel(
        temperature: 37.8,
      ),
      patientState: PatientState.caution,
    ),
    meta: MeasurementModelMeta(
      createdAt: DateTime.now(),
      numberOfQuestions: 3,
    ),
  ),
]);

final illnesses = <Illness>[
  Illness(id: 'asdf', feverMeasurements: [
    MeasurementModel(
      id: 'num1',
      data: MeasurementModelData(
        feverSection: FeverSectionModel(
          temperature: 37.8,
        ),
        hydrationSection: HydrationSectionModel(),
        caregiverSection: CaregiverSectionModel(),
        medicationSection: MedicationSectionModel(),
        respirationSection: RespirationSectionModel(),
        generalSection: GeneralSectionModel(),
        skinSection: SkinSectionModel(),
        pulseSection: PulseSectionModel(),
        patientState: PatientState.good,
      ),
      meta: MeasurementModelMeta(
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        numberOfQuestions: 3,
      ),
    ),
    MeasurementModel(
      id: 'num1',
      data: MeasurementModelData(
        feverSection: FeverSectionModel(
          temperature: 37.8,
        ),
        patientState: PatientState.good,
      ),
      meta: MeasurementModelMeta(
        createdAt: DateTime.now().subtract(const Duration(days: 6)),
        numberOfQuestions: 3,
      ),
    ),
  ]),
  Illness(id: 'asdf2', feverMeasurements: [
    MeasurementModel(
      id: 'num1',
      data: MeasurementModelData(
        feverSection: FeverSectionModel(
          temperature: 37.8,
        ),
        patientState: PatientState.caution,
      ),
      meta: MeasurementModelMeta(
        createdAt: DateTime.now().subtract(const Duration(days: 22)),
        numberOfQuestions: 3,
      ),
    ),
    MeasurementModel(
      id: 'num1',
      data: MeasurementModelData(
        feverSection: FeverSectionModel(
          temperature: 37.8,
        ),
        patientState: PatientState.good,
      ),
      meta: MeasurementModelMeta(
        createdAt: DateTime.now().subtract(const Duration(days: 22)),
        numberOfQuestions: 3,
      ),
    ),
    MeasurementModel(
      id: 'num1',
      data: MeasurementModelData(
        feverSection: FeverSectionModel(
          temperature: 37.8,
        ),
        patientState: PatientState.caution,
      ),
      meta: MeasurementModelMeta(
        createdAt: DateTime.now().subtract(const Duration(days: 24)),
        numberOfQuestions: 3,
      ),
    ),
    MeasurementModel(
      id: 'num1',
      data: MeasurementModelData(
        feverSection: FeverSectionModel(
          temperature: 37.8,
        ),
        patientState: PatientState.caution,
      ),
      meta: MeasurementModelMeta(
        createdAt: DateTime.now().subtract(const Duration(days: 25)),
        numberOfQuestions: 3,
      ),
    ),
  ]),
  Illness(id: 'asdf3', feverMeasurements: [
    MeasurementModel(
      id: 'num1',
      data: MeasurementModelData(
        feverSection: FeverSectionModel(
          temperature: 37.8,
        ),
        patientState: PatientState.good,
      ),
      meta: MeasurementModelMeta(
        createdAt: DateTime.now().subtract(const Duration(days: 56)),
        numberOfQuestions: 3,
      ),
    ),
    MeasurementModel(
      id: 'num1',
      data: MeasurementModelData(
        feverSection: FeverSectionModel(
          temperature: 37.8,
        ),
        patientState: PatientState.danger,
      ),
      meta: MeasurementModelMeta(
        createdAt: DateTime.now().subtract(const Duration(days: 57)),
        numberOfQuestions: 3,
      ),
    ),
    MeasurementModel(
      id: 'num1',
      data: MeasurementModelData(
        feverSection: FeverSectionModel(
          temperature: 37.8,
        ),
        patientState: PatientState.caution,
      ),
      meta: MeasurementModelMeta(
        createdAt: DateTime.now().subtract(const Duration(days: 58)),
        numberOfQuestions: 3,
      ),
    ),
  ]),
];

class IHomeScreen extends StatefulWidget {
  const IHomeScreen({Key? key}) : super(key: key);

  @override
  _IHomeScreenState createState() => _IHomeScreenState();
}

class _IHomeScreenState extends State<IHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final notis = Provider.of<List<INotification>>(context);
    final patient = Provider.of<PatientProvider>(context).patient;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CS310 Fever Friend App'),
        actions: <Widget>[
          Badge(
            label: Text(notis.length.toString()),
            alignment: AlignmentDirectional.topEnd,
            child: IconButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(ScreenDefinition.notification),
              icon: const Icon(Icons.notifications),
            ),
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      body: Consumer<List<Illness>>(
        builder: (context, value, _) {
          if (value.isEmpty) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Column(
                    children: const [
                      Icon(Icons.info_outline),
                      Text('No measruements to display')
                    ],
                  ),
                ),
              ),
            );
          }

          return SafeArea(
            child: Column(children: [
              if (value.first.isActive)
                IllnessCard(
                  illness: value.first,
                ),
              Expanded(
                child: IllnessList(
                  illnessList: value.skip(1).toList(),
                ),
              ),
            ]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ScreenDefinition.createMeasurement);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
