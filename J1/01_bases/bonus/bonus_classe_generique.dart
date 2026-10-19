// INTRODUCTION DART — BONUS — classe générique.
// dart run bonus_classe_generique.dart
// ignore_for_file: avoid_print

// T est un paramètre de TYPE, choisi quand on utilise cette classe.
// On écrit une seule classe et l'analyseur vérifie le type de chaque utilisation.
class Boite<T> {
  final T valeur;
  Boite(this.valeur);
}

void main() {
  final texte = Boite<String>('Bonjour');
  final nombre = Boite<int>(42);
  print(texte.valeur); // String
  print(nombre.valeur); // int
  // Boite<int>('42'); // Erreur : un texte ne remplace pas un int.
  // List<E>, Map<K, V> et Future<T> suivent ce principe de type paramétré.
}
