// INTRODUCTION DART — EXERCICE 7 : premier objet.
// dart run etape_07_classes_depart.dart
// ignore_for_file: avoid_print

class Joueur {
  final String pseudo;
  int score = 0;
  Joueur(this.pseudo);
  // TODO 1 : ajouter void ajouterPoints(int points).
  // TODO 2 : ajouter String sePresenter() : renvoyer « pseudo : score points ».
}

void main() {
  final lina = Joueur('Lina');
  final sami = Joueur('Sami');
  print('${lina.pseudo} : ${lina.score} points');
  print('${sami.pseudo} : ${sami.score} points');
  // TODO 3 : donner 10 puis 5 points à Lina, sans changer le score de Sami.
  // TODO 4 : afficher les deux présentations avec print(objet.sePresenter()).
}
