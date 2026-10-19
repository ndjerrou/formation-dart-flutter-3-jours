import 'corrections/liste_taches.dart';
import 'corrections/tache.dart';

void verifier(bool condition, String message) {
  if (!condition) throw StateError(message);
}

void main() {
  final liste = ListeTaches();
  final a = liste.ajouter('  Lire  ');
  final b = liste.ajouter('Coder');
  verifier(a.id == 1 && a.titre == 'Lire', 'Création et nettoyage du titre');
  verifier(!a.terminee && b.id == 2, 'Etat et identifiants initiaux');
  verifier(liste.terminer(1) && a.terminee, 'Terminer');
  verifier(liste.rouvrir(1) && !a.terminee, 'Rouvrir');
  verifier(liste.renommer(1, '  Dart  ') && a.titre == 'Dart', 'Renommer');
  var refuse = false;
  try {
    liste.renommer(1, ' ');
  } on ArgumentError {
    refuse = true;
  }
  verifier(
    refuse && a.titre == 'Dart',
    'Renommage invalide sans perte de titre',
  );
  refuse = false;
  try {
    liste.ajouter(' ');
  } on ArgumentError {
    refuse = true;
  }
  verifier(
    refuse && liste.taches.length == 2,
    'Ajout invalide sans modification',
  );
  verifier(liste.ajouter('Tester').id == 3, 'Ajout refusé sans id consommé');
  verifier(liste.supprimer(2) && !liste.supprimer(2), 'Suppression');
  verifier(liste.ajouter('Relire').id == 4, 'Aucun id réutilisé');
  verifier(liste.chercher(999) == null, 'Recherche absente');
  verifier(
    !liste.terminer(999) && !liste.rouvrir(999),
    'Actions sur id absent',
  );
  verifier(!liste.renommer(999, 'X'), 'Renommage sur id absent');
  final instantane = liste.taches;
  refuse = false;
  try {
    instantane.clear();
  } on UnsupportedError {
    refuse = true;
  }
  verifier(refuse, 'Structure protégée');
  instantane.first.renommer('Partagée');
  verifier(a.titre == 'Partagée', 'Les objets contenus restent partagés');
  liste.ajouter('Nouvelle');
  verifier(instantane.length == 3 && liste.taches.length == 4, 'Instantané');
  final copie = Tache.copie(a);
  copie.terminer();
  verifier(!a.terminee && copie.terminee, 'Copie indépendante de la tâche');
  const original = TacheImmuable(id: 1, titre: 'Immuable');
  final suivant = original.avecStatut(true);
  verifier(!original.terminee && suivant.terminee, 'Nouvel objet immuable');
  print('Todo : vérifications réussies.');
}
