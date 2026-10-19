// INTRODUCTION DART — 01 : exécuter, afficher, lire une expression.
// CORRECTION — dart run etape_01_print.dart
// Chaque fichier est autonome ; il peut aussi être copié dans DartPad.
// ignore_for_file: avoid_print

// main est le point d'entrée : les instructions s'exécutent dans cet ordre.
void main() {
  // Les guillemets indiquent du texte. Ils ne sont pas affichés.
  print('Bonjour les élèves !');
  // Sans guillemets, Dart calcule l'expression avant de passer sa valeur à print.
  print(2 + 3); // 5 : une valeur numérique.
  print('2 + 3'); // 2 + 3 : du texte, sans calcul.
  // Une expression produit une valeur. Une instruction effectue une action.
  // Ici 2 + 3 est une expression ; print(2 + 3); est une instruction.
  print(2 + 3 * 4); // 14 : la multiplication est prioritaire.
  print((2 + 3) * 4); // 20 : les parenthèses changent le regroupement.
  // Le point-virgule termine l'instruction. // commence un commentaire.
}
