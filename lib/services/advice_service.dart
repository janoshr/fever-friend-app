import 'package:csv/csv.dart';
import 'package:fever_friend_app/models/enums.dart';
import 'package:fever_friend_app/models/fever_measurement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/advice_model.dart';
import '../models/patient.dart';

extension on PatientState {
  bool operator <(PatientState other) {
    return index < other.index;
  }

  bool operator <=(PatientState other) {
    return index <= other.index;
  }

  bool operator >(PatientState other) {
    return index > other.index;
  }

  bool operator >=(PatientState other) {
    return index >= other.index;
  }
}

const List<String> kNumericFields = ['ageInMonths', 'temperature'];

class AdviceKnowledgeBase {
  ServiceStatus status = ServiceStatus.loading;
  late Set<AdviceModel> _knowledgeBase;

  AdviceKnowledgeBase() {
    _init();
  }

  /// Private constructor to get an instance
  AdviceKnowledgeBase._();

  /// Async constructor for the class
  static Future<AdviceKnowledgeBase> create() async {
    final res = AdviceKnowledgeBase._();
    await res._init();
    return res;
  }

  /// Retrieves a single advice given its key
  AdviceModel? getAdvice(String key) {
    return _knowledgeBase.firstWhere((element) => element.key == key);
  }

  /// Retrieves a list of advice given their keys
  List<AdviceModel> getAdviceList(List<String> keys) {
    final list =
        _knowledgeBase.where((element) => keys.contains(element.key)).toList();
    list.sort((a, b) => b.importance - a.importance);
    return list;
  }

  /// Given the patient and the measurement state it returns all relevant advices
  /// sorted descending by the importance value
  List<String> getRelevantAdviceList(
      Patient patient, MeasurementModelState modelState, double temperature) {
    Map<String, dynamic> modelMap = Map.from(modelState.toMap());
    modelMap['ageInMonths'] = patient.ageInMonths;
    modelMap['temperature'] = temperature;

    List<AdviceModel> res = _knowledgeBase
        .where(
          (advice) => advice.conditions.every(
            (condition) {
              if (condition.value == null ||
                  modelMap[condition.field] == null) {
                return false;
              }
              try {
                if (kNumericFields.contains(condition.field)) {
                  num currentState = modelMap[condition.field];
                  num conditionValue = condition.value;
                  return _compareNumeric(
                      condition.op, currentState, conditionValue);
                } else {
                  PatientState currentState = modelMap[condition.field];
                  PatientState conditionValue =
                      PatientState.values.byName(condition.value);
                  return _compareState(
                      condition.op, currentState, conditionValue);
                }
              } catch (e) {
                debugPrint(
                    'ERROR: condition checking failed with value: ${modelMap[condition.field]} for condition: ${condition.toString()}');
                debugPrint(e.toString());
                if (e is Error) {
                  debugPrintStack(stackTrace: e.stackTrace);
                }
                return false;
              }
            },
          ),
        )
        .toList();

    res.sort((a, b) => b.importance - a.importance);

    return res.map((e) => e.key).toList();
  }

  /// Comparing numeric values given a String operator `op`
  bool _compareNumeric(String op, num currentState, num conditionValue) {
    switch (op) {
      case '==':
        {
          return currentState == conditionValue;
        }
      case '>':
        {
          return currentState > conditionValue;
        }
      case '<':
        {
          return currentState < conditionValue;
        }
      case '>=':
        {
          return currentState >= conditionValue;
        }
      case '<=':
        {
          return currentState <= conditionValue;
        }
      case '!=':
        {
          return currentState != conditionValue;
        }
      default:
        {
          throw Exception('Condition operator $op is not recognized');
        }
    }
  }

  /// Comparing `PatientState` values given a String operator `op`
  bool _compareState(
      String op, PatientState currentState, PatientState conditionValue) {
    switch (op) {
      case '==':
        {
          return currentState == conditionValue;
        }
      case '>':
        {
          return Enum.compareByIndex(currentState, conditionValue) > 0;
        }
      case '<':
        {
          return Enum.compareByIndex(currentState, conditionValue) < 0;
        }
      case '>=':
        {
          return Enum.compareByIndex(currentState, conditionValue) >= 0;
        }
      case '<=':
        {
          return Enum.compareByIndex(currentState, conditionValue) <= 0;
        }
      case '!=':
        {
          return currentState != conditionValue;
        }
      default:
        {
          throw Exception('Condition operator $op is not recognized');
        }
    }
  }

  /// Initialize the class by loading the knowledge base from csv files
  Future<void> _init() async {
    debugPrint('AdviceKnowledgeBase loading...');
    try {
      // load csv files
      List<Map<String, dynamic>> advices = await rootBundle.loadStructuredData(
          'assets/advice/advice.csv', _parseCSV);
      List<Map<String, dynamic>> conditions = await rootBundle
          .loadStructuredData('assets/advice/conditions.csv', _parseCSV);
      // create classes from maps
      Iterable<AdviceModel> adviceList = advices.map((row) {
        return AdviceModel(
          key: row['key'],
          importance: row['importance'],
          content: row['content'],
          title: row['title'],
        );
      });
      Iterable<ConditionModel> conditionList = conditions.map((row) {
        return ConditionModel(
            adviceKey: row['key'],
            field: row['field'],
            op: row['operator'],
            value: row['value']);
      });

      List<AdviceModel> resultList = [];

      for (final advice in adviceList) {
        // connect advices with conditions
        final conditions = conditionList
            .where((condition) => condition.adviceKey == advice.key);
        advice.addConditionList(conditions);
        resultList.add(advice);
      }

      _knowledgeBase = resultList.toSet();

      debugPrint(
          'AdviceKnowledgeBase loaded with ${advices.length} advices and ${conditions.length} conditions');

      status = ServiceStatus.ready;
    } catch (e) {
      status = ServiceStatus.error;
      debugPrint('AdviceKnowledgeBase failed to load:');

      debugPrint(e.toString());
      if (e is Error) {
        debugPrintStack(stackTrace: e.stackTrace);
      }
    }
  }

  /// Parse csv String to a list of maps.
  /// Each row is a map entry in the list where the header is determined by the
  /// first row of the csv.
  Future<List<Map<String, dynamic>>> _parseCSV(String data) async {
    // separate full text into rows
    final rows = const CsvToListConverter().convert(data);
    // get the header of the csv
    final header = rows.first;

    List<Map<String, dynamic>> res = List.from(rows.skip(1).map((items) {
      // sanity check
      if (items.length != header.length) {
        return null;
      }
      final rowMap = <String, dynamic>{};
      for (int i = 0; i < items.length; i++) {
        // for each header add the value
        dynamic item = items[i];
        dynamic head = header[i];
        if (item is String) {
          item = item.trim();
        }
        if (head is String) {
          head = head.trim();
        }
        rowMap[head] = item;
      }
      return rowMap;
    }).where((element) => element != null));
    // filter for rows that failed sanity check

    return res;
  }
}
