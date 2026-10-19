// CONSOLIDATION — Une fonction reçoit une COPIE de la référence.
// dart run bonus_passage_arguments.dart
// ignore_for_file: avoid_print

void ajouterCarte(List<String> cartes) {
  // On modifie l'objet partagé avec l'appelant.
  cartes.add('pique');
}

void remplacerLocalement(List<String> cartes) {
  // On réaffecte seulement le paramètre local : le nom de l'appelant reste intact.
  cartes = <String>['trèfle'];
  print('Dans remplacerLocalement : $cartes');
}

void ajouterPoint(Map<String, int> scores) {
  // Une lecture de clé peut être absente : ?? fournit la valeur de départ.
  scores['Lina'] = (scores['Lina'] ?? 0) + 1;
}

void main() {
  final mainDuJoueur = <String>['cœur'];
  ajouterCarte(mainDuJoueur);
  print('Après mutation : $mainDuJoueur'); // [cœur, pique]
  remplacerLocalement(mainDuJoueur);
  print('Après réaffectation locale : $mainDuJoueur'); // [cœur, pique]
  final scores = <String, int>{'Lina': 10};
  ajouterPoint(scores);
  print('Score partagé : $scores'); // {Lina: 11}
}
