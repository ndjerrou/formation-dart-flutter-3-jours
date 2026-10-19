// INTRODUCTION DART — 03 : expressions booléennes et décision.
// CORRECTION — dart run etape_03_logique.dart
// ignore_for_file: avoid_print

void main() {
  int score = 20;
  bool tempsEcoule = false;
  bool abandon = false;

  // Une comparaison calcule un booléen, true ou false.
  final objectifAtteint = score >= 20;
  print('Objectif atteint : $objectifAtteint'); // true
  print('Exactement 20 : ${score == 20}'); // == compare ; = affecte.
  print('Score différent de 0 : ${score != 0}');

  // || = OU : au moins une condition vraie suffit.
  final partieTerminee = objectifAtteint || tempsEcoule || abandon;
  // && = ET : les deux conditions doivent être vraies.
  // ! = NON : inverse true et false.
  final victoire = objectifAtteint && !abandon;
  print('Partie terminée : $partieTerminee'); // true
  print('Victoire : $victoire'); // true

  // if attend une condition de type bool, pas un entier ni un texte.
  if (victoire) {
    print('Partie gagnée !');
  } else {
    print('Pas de victoire pour le moment.');
  }
  // Refaire l'essai avec score = 10, puis tempsEcoule = true.
  // Les booléens ci-dessus sont calculés lors de leur initialisation :
  // pour ce nouvel essai, modifier les valeurs de départ et RELANCER le fichier.
}
