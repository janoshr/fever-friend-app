import 'package:fever_friend_app/screens/illness.dart';
import 'package:fever_friend_app/ui/shared/constants.dart';
import 'package:fever_friend_app/ui/shared/utils.dart';
import 'package:flutter/material.dart';

import '../../models/illness.dart';

class IllnessList extends StatelessWidget {
  final List<Illness> illnessList;

  const IllnessList({Key? key, required this.illnessList}) : super(key: key);

  void Function() navigateToIllness(BuildContext context, Illness illness) =>
      () {
        debugPrint('Tapped ${illness.id}');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IllnessScreen(illness: illness)));
      };

  @override
  Widget build(BuildContext context) {
    // TODO add empty/loading indicator
    return ListView.separated(
      itemBuilder: (context, i) {
        final illness = illnessList[i];

        return Card(
          child: InkWell(
            onTap: navigateToIllness(context, illness),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${dateFMMMDD.format(illness.feverMeasurements.first.meta.createdAt)} - ${dateFMMMDD.format(illness.feverMeasurements.last.meta.createdAt)}'),
                  Text(
                    '${illness.feverMeasurements.first.meta.createdAt.difference(illness.feverMeasurements.last.meta.createdAt).inDays} days',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              subtitle: Row(
                  children: illness.feverMeasurements.map((m) {
                return Icon(
                  Icons.circle,
                  size: 14,
                  color: stateToColor(m.data.patientState!),
                );
              }).toList()),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 8,
        );
      },
      itemCount: illnessList.length,
    );
  }
}