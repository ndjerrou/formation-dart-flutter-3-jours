import 'tache.dart';

class ListeTaches {
  // final empêche de remplacer la liste ; ajouter / retirer reste possible.
  final List<Tache> _taches = <Tache>[];
  int _prochainId = 1;

  Tache ajouter(String titre) {
    final tache = Tache(id: _prochainId, titre: titre);
    _taches.add(tache);
    // Une création refusée n'atteint pas cette ligne : pas d'id consommé.
    _prochainId += 1;
    return tache;
  }

  Tache? chercher(int id) {
    for (final tache in _taches) {
      if (tache.id == id) {
        return tache;
      }
    }
    return null;
  }

  bool terminer(int id) {
    final tache = chercher(id);
    if (tache == null) {
      return false;
    }
    tache.terminer();
    return true;
  }

  bool rouvrir(int id) {
    final tache = chercher(id);
    if (tache == null) {
      return false;
    }
    tache.rouvrir();
    return true;
  }

  bool renommer(int id, String titre) {
    final tache = chercher(id);
    if (tache == null) {
      return false;
    }
    tache.renommer(titre);
    return true;
  }

  bool supprimer(int id) {
    final avant = _taches.length;
    _taches.removeWhere((tache) => tache.id == id);
    return _taches.length < avant;
  }

  // Instantané de la structure, pas copie des objets Tache contenus.
  List<Tache> get taches => List<Tache>.unmodifiable(_taches);

  // where sélectionne ; toList matérialise une nouvelle liste.
  List<Tache> get enCours => _taches.where((tache) => !tache.terminee).toList();

  // Résultat calculé à la demande plutôt qu'un compteur à synchroniser.
  int get nombreEnCours => enCours.length;
}
