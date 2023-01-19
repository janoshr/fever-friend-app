import 'package:fever_friend_app/services/firestore.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.I;

void setupGetIt() {
  getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());
}
