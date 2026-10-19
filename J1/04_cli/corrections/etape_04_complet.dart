// ATELIER 2 — Mission Dart : un carnet de tâches en ligne de commande.
// CORRECTION FINALE — programme complet.
// Exécution : dart run etape_04_complet.dart (depuis ce dossier).
// Aucun package à installer. Les tâches restent en mémoire.
// ignore_for_file: avoid_print

// dart:io fournit le clavier (stdin) et la sortie du terminal (stdout).
// Cette version interactive se lance dans un terminal, pas dans DartPad.
import 'dart:io';

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

// ÉTAPE 3 — Fonctions d'affichage et de saisie : l'interface du programme.
void afficherTaches(List<Tache> taches) {
  if (taches.isEmpty) {
    print('Aucune tâche à afficher.');
    return;
  }
  for (final tache in taches) {
    print(tache);
  }
}

String? lire(String question) {
  // write laisse le curseur sur la même ligne, contrairement à print.
  stdout.write(question);
  // readLineSync peut renvoyer null si le flux d'entrée est fermé.
  // ?. appelle trim uniquement si une chaîne a été obtenue.
  return stdin.readLineSync()?.trim();
}

void ajouterDepuisClavier(Carnet carnet) {
  final titre = lire('Titre : ');
  if (titre == null) return; // Fin de saisie : on abandonne cet ajout.
  final note = lire('Note facultative (Entrée pour passer) : ');
  if (note == null) return;

  try {
    // Une ligne vide est une chaîne vide, pas null : conversion volontaire.
    final tache = carnet.ajouter(titre, note: note.isEmpty ? null : note);
    print('Ajoutée : $tache');
  } on ArgumentError catch (erreur) {
    print('Ajout refusé : ${erreur.message}');
  }
}

void terminerDepuisClavier(Carnet carnet) {
  final saisie = lire('Identifiant à terminer : ');
  if (saisie == null) return;
  // tryParse renvoie null si le texte n'est pas un entier, sans exception.
  final id = int.tryParse(saisie);
  if (id == null) {
    print('Saisie invalide : entre un nombre entier.');
    return;
  }
  final trouvee = carnet.terminer(id);
  print(trouvee ? 'Tâche #$id terminée.' : 'Tâche #$id introuvable.');
}

// ÉTAPE 4 — Une opération asynchrone renvoie UN résultat futur.
// Simulation pédagogique : aucun fichier, aucun serveur, aucune persistance.
Future<int> sauvegarder(
  List<Tache> taches, {
  bool simulerErreur = false,
}) async {
  // const : cet objet Duration est une constante connue à la compilation.
  // await suspend cette fonction ; il ne bloque pas tout le moteur Dart.
  await Future<void>.delayed(const Duration(seconds: 1));
  if (simulerErreur) {
    throw StateError('Service de sauvegarde indisponible.');
  }
  return taches.length;
}

Future<void> sauvegarderDepuisMenu(
  Carnet carnet, {
  bool simulerErreur = false,
}) async {
  print('Sauvegarde simulée en cours…');
  try {
    // On attend le résultat avant d'afficher le message de réussite.
    final nombre = await sauvegarder(
      carnet.lister(),
      simulerErreur: simulerErreur,
    );
    print('Simulation réussie : $nombre tâche(s) traitée(s).');
  } on StateError catch (erreur) {
    // Une panne attendue est présentée sans faire quitter le programme.
    print('Échec de la simulation : ${erreur.message}');
  } finally {
    // Ce bloc s'exécute en cas de réussite ET d'échec.
    print('Fin de la tentative. Retour au menu.');
  }
}

// main devient async car certains choix du menu utilisent await.
Future<void> main() async {
  const nomApplication = 'Atelier 2 — Mission Dart';
  final carnet = Carnet();
  carnet.ajouter('Réviser les classes');
  carnet.ajouter('Préparer Flutter', note: 'Pour mardi');

  print(nomApplication);
  print('Données en mémoire ; la sauvegarde proposée est une simulation.');

  // La boucle laisse l'utilisateur enchaîner plusieurs actions.
  while (true) {
    print('\n1. Tout afficher');
    print('2. Ajouter une tâche');
    print('3. Terminer une tâche');
    print('4. Afficher les tâches à faire');
    print('5. Simuler une sauvegarde réussie');
    print('6. Simuler une sauvegarde en panne');
    print('0. Quitter');
    final choix = lire('Ton choix : ');

    // null = fin du flux ; '0' = choix explicite de quitter.
    if (choix == null || choix == '0') {
      print('À bientôt ! Les données en mémoire ne sont pas conservées.');
      return;
    }

    // switch sélectionne une action en fonction du texte saisi.
    switch (choix) {
      case '1':
        afficherTaches(carnet.lister());
      case '2':
        ajouterDepuisClavier(carnet);
      case '3':
        terminerDepuisClavier(carnet);
      case '4':
        afficherTaches(carnet.lister(seulementEnCours: true));
      case '5':
        await sauvegarderDepuisMenu(carnet);
      case '6':
        await sauvegarderDepuisMenu(carnet, simulerErreur: true);
      default:
        print('Choix inconnu : utilise un numéro du menu.');
    }
  }
}
