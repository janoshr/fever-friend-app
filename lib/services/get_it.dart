import 'package:fever_friend_app/services/advice_service.dart';
import 'package:fever_friend_app/services/model_service.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'firestore.dart';

GetIt getIt = GetIt.I;

void setupGetIt() {
  getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());
  getIt.registerSingletonAsync<PackageInfo>(
      () async => PackageInfo.fromPlatform());
  getIt.registerLazySingleton<ModelService>(() => ModelService());
  getIt.registerSingletonAsync<AdviceKnowledgeBase>(() => AdviceKnowledgeBase.create());
}
