// ATELIER 2 — DÉPART ÉLÈVE B : trois méthodes à compléter
// SQUELETTE ÉLÈVE : ajout et liste complète déjà fournis.
// dart run etape_02_collections_depart.dart
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
    // TODO B1 : si seulementEnCours vaut true, filtrer les tâches non terminées.
    // Pour le moment, la liste complète est renvoyée dans tous les cas.
    return _taches.toList();
  }

  Tache? chercher(int id) {
    // TODO B2 : parcourir _taches et retourner l'objet qui possède cet ID.
    // Si aucune tâche ne correspond, retourner null.
    return null;
  }

  bool terminer(int id) {
    // TODO B3 : appeler chercher(id). Si le résultat est null : false.
    // Sinon, terminer l'objet trouvé et retourner true.
    return false;
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

// Les commentaires ci-dessous indiquent les RÉSULTATS CIBLES après les TODO.
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
