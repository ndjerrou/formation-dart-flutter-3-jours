// INTRODUCTION DART — 04 : List, Map et paramètres de type.
// CORRECTION — dart run etape_04_collections_generiques.dart
// ignore_for_file: avoid_print

void main() {
  // List<E> est un type générique : E désigne le type des éléments.
  // Ici E est remplacé par String : cette liste accepte des textes.
  List<String> enseignes = ['cœur', 'carreau', 'trèfle'];
  enseignes.add('pique');
  print('Enseignes : $enseignes');
  print('Nombre : ${enseignes.length}'); // 4
  print('Première : ${enseignes[0]}'); // L'index commence à zéro.
  enseignes[0] = 'Cœur'; // Modifier un élément à un index existant.
  enseignes.remove('trèfle'); // Retirer par valeur.
  for (final enseigne in enseignes) {
    print('Enseigne : $enseigne');
  }
  // enseignes.add(42); // Invalide : le générique impose String.

  // Map<K, V> associe des clés K à des valeurs V.
  // Ici, les clés sont des textes et les valeurs des entiers.
  Map<String, int> scores = {'Lina': 10, 'Sami': 0};
  print('Score de Lina : ${scores['Lina']}');
  scores['Lina'] = 15; // Clé existante : remplacer sa valeur.
  scores['Aya'] = 5; // Nouvelle clé : ajouter une entrée.
  scores.remove('Sami');
  print('Scores : $scores'); // {Lina: 15, Aya: 5}
  print('Nora présente : ${scores.containsKey('Nora')}'); // false
  // Une clé absente donne null : les valeurs absentes seront approfondies au CLI.
  print('Score de Nora : ${scores['Nora']}'); // null
  // scores['Lina'] = '15'; // Invalide : la valeur doit être un int.

  // Autre écriture : les types peuvent être précisés sur le littéral.
  var points = <int>[10, 20]; // Le type inféré est List<int>.
  var equipes = <String, int>{'Bleue': 2}; // Map<String, int>.
  print('Points : $points / Équipes : $equipes');
  // À l'atelier 1 : List<Card>. Au CLI : List<Tache> et Future<int>.
  // Les génériques décrivent les types, pas le nombre d'éléments.
}
