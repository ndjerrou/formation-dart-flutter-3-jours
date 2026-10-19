// INTRODUCTION DART — EXERCICE 5 : prédire avant de lancer.
// dart run etape_05_references_depart.dart
// ignore_for_file: avoid_print

void main() {
  final cartes = <String>['cœur', 'pique'];
  final autreNom = cartes;
  autreNom.add('trèfle');
  print('Cartes : $cartes');
  // TODO 1 : prédire puis expliquer le résultat. Y a-t-il une ou deux listes ?
  // TODO 2 : créer copie avec List<String>.of(cartes), retirer 'pique' de copie.
  // Afficher les deux listes : cartes doit rester inchangée par ce retrait.

  final scores = <String, int>{'Lina': 10};
  final autreScores = scores;
  autreScores['Lina'] = 20;
  print('Scores : $scores');
  // TODO 3 : faire une copie Map<String, int>.of(scores), lui donner Lina = 99.
  // Afficher les deux : l'original doit rester à 20.
  // TODO 4 : expliquer pourquoi les modifications ci-dessus sont possibles
  // malgré final. Que changerait const sur le littéral initial ?
}
