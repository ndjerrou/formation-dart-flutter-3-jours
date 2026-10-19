// INTRODUCTION DART — 07 : regrouper des données et des actions dans un objet.
// CORRECTION — dart run etape_07_classes.dart
// ignore_for_file: avoid_print

// La CLASSE définit un modèle. Chaque Joueur créé est un OBJET distinct.
class Joueur {
  // Les attributs décrivent les données de chaque joueur.
  final String pseudo;
  int score = 0;

  // Le CONSTRUCTEUR reçoit le pseudo à la création de l'objet.
  // this.pseudo initialise l'attribut pseudo de ce nouvel objet.
  Joueur(this.pseudo);

  // Une MÉTHODE est une fonction appartenant à un objet.
  void ajouterPoints(int points) {
    score = score + points;
  }

  // Cette méthode renvoie du texte. Elle n'appelle pas print.
  String sePresenter() {
    return '$pseudo : $score points';
  }
}

void main() {
  final lina = Joueur('Lina');
  final sami = Joueur('Sami');
  // Le point permet d'accéder à un attribut ou d'appeler une méthode.
  lina.ajouterPoints(10);
  lina.ajouterPoints(5);
  print(lina.sePresenter()); // Lina : 15 points
  print(sami.sePresenter()); // Sami : 0 points, son état est indépendant.
  // final empêche lina = Joueur('Autre'), mais son score peut évoluer.
  // Card utilisera aussi des attributs initialisés par un constructeur.
}
