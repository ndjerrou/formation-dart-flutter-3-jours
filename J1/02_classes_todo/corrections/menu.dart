import 'dart:io';

import 'liste_taches.dart';
import 'tache.dart';

void main() {
  lancerMenu();
}

void lancerMenu() {
  final liste = ListeTaches();
  print('TODO LIST — les données restent en mémoire pendant cette session.');

  while (true) {
    print('\n1 Ajouter | 2 Afficher | 3 Terminer | 4 Rouvrir');
    print('5 Renommer | 6 Supprimer | 7 En cours | 0 Quitter');
    stdout.write('Choix : ');
    final choix = stdin.readLineSync();
    // null signifie fin d'entrée, ce n'est pas une chaîne vide.
    if (choix == null || choix.trim() == '0') {
      print('Au revoir.');
      return;
    }

    switch (choix.trim()) {
      case '1':
        stdout.write('Titre : ');
        final titre = stdin.readLineSync();
        if (titre == null) {
          return;
        }
        try {
          final tache = liste.ajouter(titre);
          print('Ajout : ${tache.decrire()}');
        } on ArgumentError catch (erreur) {
          print(erreur.message);
        }
        break;
      case '2':
        afficherTaches(liste.taches);
        print('Tâches en cours : ${liste.nombreEnCours}');
        break;
      case '3':
      case '4':
      case '5':
      case '6':
        stdout.write('Identifiant : ');
        final saisieId = stdin.readLineSync();
        if (saisieId == null) {
          return;
        }
        // tryParse renvoie null pour une saisie invalide ; pas d'exception.
        final id = int.tryParse(saisieId.trim());
        if (id == null || id < 1) {
          print('Entrez un entier positif.');
          break;
        }
        if (liste.chercher(id) == null) {
          print('Tâche introuvable.');
          break;
        }
        if (choix.trim() == '3') {
          liste.terminer(id);
          print('Tâche terminée.');
        } else if (choix.trim() == '4') {
          liste.rouvrir(id);
          print('Tâche rouverte.');
        } else if (choix.trim() == '5') {
          stdout.write('Nouveau titre : ');
          final titre = stdin.readLineSync();
          if (titre == null) {
            return;
          }
          try {
            liste.renommer(id, titre);
            print('Tâche renommée.');
          } on ArgumentError catch (erreur) {
            print(erreur.message);
          }
        } else {
          liste.supprimer(id);
          print('Tâche supprimée.');
        }
        break;
      case '7':
        afficherTaches(liste.enCours);
        break;
      default:
        print('Choix inconnu.');
    }
  }
}

void afficherTaches(List<Tache> taches) {
  if (taches.isEmpty) {
    print('Aucune tâche.');
    return;
  }
  for (final tache in taches) {
    print(tache.decrire());
  }
}
