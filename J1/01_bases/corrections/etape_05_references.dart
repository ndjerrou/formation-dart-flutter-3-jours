// INTRODUCTION DART — 05 : références partagées, copies, var/final/const.
// CORRECTION — dart run etape_05_references.dart
// Exécuter après chaque petit bloc pour prédire les résultats.
// ignore_for_file: avoid_print

void main() {
  // 1. AFFECTATION : copier une référence, sans dupliquer la liste.
  final original = <String>['cœur', 'pique'];
  final alias = original;
  print('Même liste : ${identical(original, alias)}'); // true
  alias.add('trèfle');
  print('Original après alias.add : $original'); // [cœur, pique, trèfle]

  // 2. COPIE : un nouveau conteneur, initialisé avec les mêmes éléments.
  final copie = List<String>.of(original);
  print('Copie identique : ${identical(original, copie)}'); // false
  copie.remove('pique');
  print('Original : $original'); // [cœur, pique, trèfle]
  print('Copie : $copie'); // [cœur, trèfle]

  // 3. Même raisonnement pour une Map.
  final scores = <String, int>{'Lina': 10};
  final aliasScores = scores;
  aliasScores['Lina'] = 20;
  print('Scores après alias : $scores'); // {Lina: 20}
  final copieScores = Map<String, int>.of(scores);
  copieScores['Lina'] = 99;
  print('Scores : $scores / Copie : $copieScores'); // 20 / 99

  // 4. RÉAFFECTER un nom ne MODIFIE PAS l'objet précédemment référencé.
  var cible = original;
  cible = <String>['carreau'];
  print('Original après réaffectation : $original'); // Inchangé.
  print('Nouvelle cible : $cible'); // [carreau]
  // original = <String>[]; // Invalide : original est final.
  // original.add(...) était permis : la liste, elle, est modifiable.

  // 5. const rend ici la référence non réaffectable ET la liste immuable.
  const fixes = <String>['cœur', 'pique'];
  print('Liste constante : $fixes');
  // Ce try/catch est fourni pour observer l'échec sans arrêter la démo.
  // La gestion d'erreur sera enseignée au CLI, inutile de la recopier ici.
  try {
    fixes.add('trèfle');
  } on UnsupportedError {
    print('Ajout refusé : une liste const est immuable.');
  }
  // var n'implique pas que l'objet est modifiable :
  var mobile = const <String>['cœur'];
  mobile = <String>['pique']; // Réaffectation autorisée, nouvel objet.
  print('Variable var réaffectée : $mobile');
}
