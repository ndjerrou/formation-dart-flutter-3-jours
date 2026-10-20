import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

Future<Database> ouvrirBase() async {
  final dossier = await getApplicationSupportDirectory();
  return databaseFactoryIo.openDatabase(p.join(dossier.path, 'helpme_j3.db'));
}
