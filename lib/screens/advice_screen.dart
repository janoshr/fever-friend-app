import 'package:fever_friend_app/models/fever_measurement.dart';
import 'package:fever_friend_app/services/advice_service.dart';
import 'package:fever_friend_app/services/get_it.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class AdviceScreen extends StatelessWidget {
  final MeasurementModel measurementModel;

  const AdviceScreen({
    Key? key,
    required this.measurementModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adviceService = getIt.get<AdviceKnowledgeBase>();
    final loc = AppLocalizations.of(context);
    final adviceList = adviceService.getAdviceList(measurementModel.adviceKeys);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc!.adviceScreenTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: adviceList.isEmpty
            ? Center(
                child: Text(loc.emptyAdvice),
              )
            : ListView.builder(
                itemCount: adviceList.length,
                itemBuilder: (context, i) {
                  final advice = adviceList[i];

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(advice.title),
                        subtitle: Text(advice.content),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
