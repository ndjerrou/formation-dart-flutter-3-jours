import 'package:shared_preferences/shared_preferences.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:helpme_j3/data/local_store.dart';

Future<LocalStore> creerStore({
  Map<String, Object> preferences = const {},
}) async {
  SharedPreferences.setMockInitialValues(preferences);
  return LocalStore(
    await databaseFactoryMemory.openDatabase(
      'test_${DateTime.now().microsecondsSinceEpoch}',
    ),
    await SharedPreferences.getInstance(),
  );
}
