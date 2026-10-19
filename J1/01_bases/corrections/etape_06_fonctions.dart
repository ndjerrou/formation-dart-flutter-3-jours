// INTRODUCTION DART — 06 : recevoir des paramètres, renvoyer une valeur.
// CORRECTION — dart run etape_06_fonctions.dart
// ignore_for_file: avoid_print

// Une fonction est déclarée une fois et peut être appelée plusieurs fois.
// Le premier int est le TYPE DU RÉSULTAT. Les paramètres ont aussi un type.
int calculerScore(int bonnesReponses, int pointsParReponse) {
  // return transmet un résultat à l'appelant ; cette ligne n'affiche rien.
  return bonnesReponses * pointsParReponse;
}

// void indique qu'aucune valeur de résultat n'est renvoyée à l'appelant.
void afficherScore(String pseudo, int score) {
  // Cette fonction a un effet visible : elle affiche une ligne.
  print('$pseudo : $score points');
}

void main() {
  // La déclaration ci-dessus ne lance pas la fonction : il faut l'appeler.
  // 3 et 10 sont les ARGUMENTS, transmis aux PARAMÈTRES de la fonction.
  final scoreLina = calculerScore(3, 10);
  final scoreSami = calculerScore(2, 10);
  // Une valeur renvoyée peut être stockée, calculée, comparée ou affichée.
  afficherScore('Lina', scoreLina); // Lina : 30 points
  afficherScore('Sami', scoreSami); // Sami : 20 points
  print('Total : ${scoreLina + scoreSami}'); // Total : 50
  // bonnesReponses appartient à calculerScore : ce nom n'existe pas dans main.
}
