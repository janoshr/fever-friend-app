import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'firestore.dart';

GetIt getIt = GetIt.I;

void setupGetIt() {
  getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());
  getIt.registerSingletonAsync<PackageInfo>(
      () async => PackageInfo.fromPlatform());
}
