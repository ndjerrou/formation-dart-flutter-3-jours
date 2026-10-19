// ATELIER 2 — ÉTAPE B : fonctions, listes et recherche nullable
// CORRECTION, fichier autonome.
// dart run etape_02_collections.dart
// ignore_for_file: avoid_print

// ÉTAPE 1 — Une classe pour représenter UNE tâche.
class Tache {
  // final : l'identifiant, le titre et la note ne sont pas réaffectés.
  final int id;
  final String titre;
  // Le ? autorise l'absence de note : sa valeur peut être null.
  final String? note;
  // Cet attribut peut changer : une tâche passe de « à faire » à « terminée ».
  bool terminee;

  // Les accolades définissent des paramètres NOMMÉS.
  // required impose de fournir id et titre ; les autres sont facultatifs.
  Tache({
    required this.id,
    required this.titre,
    this.note,
    this.terminee = false,
  });

  // void : la méthode change l'objet, sans renvoyer de valeur.
  void terminer() {
    terminee = true;
  }

  // print(tache) appelle cette représentation lisible de l'objet.
  @override
  String toString() {
    // ?: choisit entre deux valeurs en fonction d'une condition.
    final caseACocher = terminee ? 'x' : ' ';
    // ?? propose une valeur de remplacement UNIQUEMENT en cas de null.
    return '[$caseACocher] #$id $titre — ${note ?? 'Sans note'}';
  }
}

// ÉTAPE 2 — Le carnet gère PLUSIEURS tâches et leurs règles.
class Carnet {
  // Comme dans Deck, une liste contient les objets du carnet.
  // final interdit de remplacer la liste ; ajouter un élément reste possible.
  final List<Tache> _taches = [];
  // Le prochain identifiant évolue : ce champ n'est donc pas final.
  int _prochainId = 1;

  Tache ajouter(String titre, {String? note}) {
    // La validation appartient au carnet : même sans CLI, la règle s'applique.
    final titreNettoye = titre.trim();
    if (titreNettoye.isEmpty) {
      throw ArgumentError('Le titre est obligatoire.');
    }

    final tache = Tache(id: _prochainId, titre: titreNettoye, note: note);
    _taches.add(tache);
    _prochainId++; // L'identifiant est consommé seulement après validation.
    return tache;
  }

  // Un booléen nommé rend l'intention lisible au moment de l'appel.
  List<Tache> lister({bool seulementEnCours = false}) {
    if (seulementEnCours) {
      // where reçoit une fonction qui renvoie true pour les éléments gardés.
      // ! inverse le booléen : on garde les tâches qui ne sont PAS terminées.
      return _taches.where((tache) => !tache.terminee).toList();
    }
    // Nouvelle liste, mêmes objets Tache : ce n'est pas une copie profonde.
    return _taches.toList();
  }

  // Un résultat absent est normal : le type de retour est donc nullable.
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
    // Après le test ci-dessus, Dart sait que tache n'est pas null.
    tache.terminer();
    return true;
  }
}

// Une fonction reçoit une liste, puis affiche chacun de ses objets.
void afficherTaches(List<Tache> taches) {
  if (taches.isEmpty) {
    print('Aucune tâche à afficher.');
    return;
  }
  for (final tache in taches) {
    print(tache);
  }
}

void main() {
  final carnet = Carnet();
  carnet.ajouter('Réviser les classes');
  carnet.ajouter('Préparer Flutter', note: 'Pour mardi');
  carnet.ajouter('Faire une pause');
  print('Toutes les tâches :');
  afficherTaches(carnet.lister());

  print('Terminer #1 : ${carnet.terminer(1)}'); // true
  print('Terminer #99 : ${carnet.terminer(99)}'); // false
  print('Recherche #99 : ${carnet.chercher(99)}'); // null
  print('Tâches à faire :');
  afficherTaches(carnet.lister(seulementEnCours: true)); // #2 et #3
  print('Total inchangé : ${carnet.lister().length}'); // 3

  // map transforme chaque tâche en titre ; where filtre les tâches.
  // Lire cette ligne ensemble ; la transformation est un prolongement court.
  final titres = carnet.lister().map((tache) => tache.titre).toList();
  print('Titres seuls : $titres');

  // Le carnet protège aussi les appels qui ne viennent pas d'un menu.
  try {
    carnet.ajouter('   ');
  } on ArgumentError catch (erreur) {
    print('Ajout refusé : ${erreur.message}');
  }
}
