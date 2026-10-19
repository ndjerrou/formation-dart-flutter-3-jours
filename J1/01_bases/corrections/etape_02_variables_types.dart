// INTRODUCTION DART — 02 : variables, types et premières conversions.
// CORRECTION — dart run etape_02_variables_types.dart
// ignore_for_file: avoid_print

void main() {
  // Une variable associe un nom à une référence vers un objet.
  // Pour débuter : on nomme une valeur et on respecte son type.
  String pseudo = 'Lina';
  int score = 0;
  double prix = 2.5; // Décimal : point dans le code, pas virgule.
  bool disponible = true; // Booléen : true ou false, sans guillemets.
  print('$pseudo : $score points / Prix : $prix / Disponible : $disponible');

  // = affecte ; Dart calcule d'abord l'expression à droite.
  score = score + 10;
  pseudo = 'Lina la joueuse';
  print('$pseudo : $score points, prochain palier ${score + 10}');

  // var laisse Dart déduire le type. Ici vies est de type int.
  var vies = 3;
  vies = vies - 1;
  print('Vies restantes : $vies');
  // vies = 'deux'; // Invalide : var ne signifie pas « n'importe quel type ».

  String texteScore = '10';
  // ignore: prefer_interpolation_to_compose_strings
  print(texteScore + '5'); // 105 : concaténation de deux textes.
  print(int.parse(texteScore) + 5); // 15 : conversion, puis addition.
  // parse attend ici un texte numérique valide ; tryParse viendra avec le CLI.
  print(score.toString()); // Produit le texte '10'.
  print(5 / 2); // 2.5, un double.
  // Le même affichage peut cacher des types différents :
  print(score.runtimeType); // int
  print(texteScore.runtimeType); // String

  // int est immuable : une réaffectation ne modifie pas l'objet entier initial.
  var autreScore = score;
  autreScore = autreScore + 1;
  print('Score : $score / Autre score : $autreScore'); // 10 / 11
  // Nous observerons ensuite le partage d'un objet MODIFIABLE avec les listes.
}
