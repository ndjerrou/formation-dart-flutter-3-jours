// Vérifications des règles du carnet et de la simulation asynchrone.
// dart run verification.dart — aucun package de test nécessaire.
// ignore_for_file: avoid_print
import 'etape_04_complet.dart';

void verifier(bool condition, String message) {
  if (!condition) throw StateError('Vérification échouée : $message');
}

Future<void> main() async {
  final carnet = Carnet();
  verifier(carnet.lister().isEmpty, 'le carnet commence vide');
  verifier(carnet.chercher(99) == null, 'un identifiant absent donne null');

  // Une entrée invalide ne doit ni créer d'objet ni consommer d'identifiant.
  var ajoutRefuse = false;
  try {
    carnet.ajouter('   ');
  } on ArgumentError {
    ajoutRefuse = true;
  }
  verifier(ajoutRefuse, 'un titre blanc est refusé');
  verifier(carnet.lister().isEmpty, 'un ajout refusé ne modifie pas le carnet');

  final premiere = carnet.ajouter('  Réviser Dart  ');
  final seconde = carnet.ajouter('Préparer Flutter', note: 'Pour mardi');
  verifier(premiere.id == 1 && seconde.id == 2, 'identifiants 1 puis 2');
  verifier(premiere.titre == 'Réviser Dart', 'espaces du titre retirés');
  verifier(premiere.note == null, 'la note est facultative');
  verifier(!premiere.terminee, 'une nouvelle tâche reste à faire');
  verifier(premiere.toString().contains('Sans note'), 'affichage du null');
  verifier(seconde.toString().contains('Pour mardi'), 'affichage de la note');

  verifier(!carnet.terminer(99), 'un identifiant absent donne false');
  verifier(carnet.terminer(1), 'la tâche 1 peut être terminée');
  verifier(
    carnet.terminer(1),
    'terminer deux fois reste sans effet supplémentaire',
  );
  verifier(premiere.terminee, 'le même objet passe à terminé');
  verifier(premiere.toString().startsWith('[x]'), 'la coche change');
  final enCours = carnet.lister(seulementEnCours: true);
  verifier(
    enCours.length == 1 && enCours.single.id == 2,
    'filtrage des tâches',
  );
  verifier(carnet.lister().length == 2, 'filtrer ne supprime aucune tâche');
  carnet.lister().clear();
  verifier(carnet.lister().length == 2, 'la liste renvoyée est une copie');

  // Le retour de Future et son erreur sont deux comportements à vérifier.
  verifier(await sauvegarder(carnet.lister()) == 2, 'résultat asynchrone');
  verifier(await sauvegarder([]) == 0, 'un carnet vide est un résultat valide');
  var panneObservee = false;
  try {
    await sauvegarder(carnet.lister(), simulerErreur: true);
  } on StateError {
    panneObservee = true;
  }
  verifier(panneObservee, 'la panne simulée produit une erreur');
  verifier(carnet.lister().length == 2, 'la panne conserve les tâches');
  print('Toutes les vérifications métier et asynchrones sont passées.');
}
