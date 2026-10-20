import 'package:sembast_web/sembast_web.dart';

Future<Database> ouvrirBase() =>
    databaseFactoryWeb.openDatabase('helpme_j3.db');
