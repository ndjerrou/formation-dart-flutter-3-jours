import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/demande.dart';
import 'database_io.dart' if (dart.library.js_interop) 'database_web.dart';

class LocalStore {
  LocalStore(this.db, this.preferences);
  final Database db;
  final SharedPreferences preferences;
  final _demandes = stringMapStoreFactory.store('demandes');
  final _cache = stringMapStoreFactory.store('cache');
  static Future<LocalStore> ouvrir() async =>
      LocalStore(await ouvrirBase(), await SharedPreferences.getInstance());
  Set<int> lireFavoris() =>
      (preferences.getStringList('favoris') ?? []).map(int.parse).toSet();
  Future<void> sauverFavoris(Set<int> ids) async {
    await preferences.setStringList('favoris', ids.map((id) => '$id').toList());
  }

  String get langue => preferences.getString('langue') ?? 'fr';
  Future<void> sauverLangue(String langue) async {
    await preferences.setString('langue', langue);
  }

  Future<List<Demande>> lireDemandes() async =>
      (await _demandes.find(db)).map((r) => Demande.fromJson(r.value)).toList();
  Future<void> sauverDemande(Demande demande) async {
    // Un identifiant par demande : ne pas écraser la précédente.
    await _demandes.record('unique').put(db, demande.toJson());
  }

  Future<void> transitionDemande(String id, StatutDemande statut) =>
      db.transaction((tx) async {
        final json = await _demandes.record(id).get(tx);
        if (json == null || json['statut'] != 'pending') {
          throw StateError('Déjà traitée');
        }
        await _demandes.record(id).put(tx, {...json, 'statut': statut.name});
      });
  Future<void> sauverCatalogue(List<Map<String, dynamic>> json) async {
    await _cache.record('catalogue').put(db, {'items': json});
  }

  Future<List<dynamic>?> lireCatalogue() async =>
      (await _cache.record('catalogue').get(db))?['items'] as List<dynamic>?;
  Future<void> fermer() => db.close();
}
