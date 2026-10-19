// INTRODUCTION DART — BONUS — copies de collections imbriquées.
// dart run bonus_copie_superficielle.dart
// Une copie de conteneur ne duplique pas ses éléments mutables.
// ignore_for_file: avoid_print

void main() {
  final groupes = <List<String>>[
    ['Lina'],
  ];
  final copie = List<List<String>>.of(groupes);
  print('Même liste externe : ${identical(groupes, copie)}'); // false
  print('Même sous-liste : ${identical(groupes[0], copie[0])}'); // true
  copie[0].add('Sami');
  print('Original : $groupes'); // [[Lina, Sami]]
  print('Copie : $copie'); // [[Lina, Sami]]

  final equipes = <String, List<String>>{
    'Bleue': ['Lina'],
  };
  final copieEquipes = Map<String, List<String>>.of(equipes);
  copieEquipes['Bleue']?.add('Aya');
  print('Map originale : $equipes'); // {Bleue: [Lina, Aya]}
  // La valeur List<String> est partagée même si les maps externes sont distinctes.

  // Avec des objets Card ou Tache mutables, le même principe s'applique.
  // Pour dupliquer plus profondément, reconstruire aussi les objets internes
  // selon le modèle métier ; List.of/Map.of ne le font pas automatiquement.
}
