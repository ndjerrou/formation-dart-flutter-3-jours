// ATELIER 2 — ÉTAPE A : objet, paramètres nommés, null
// CORRECTION, fichier autonome.
// dart run etape_01_objets.dart
// ignore_for_file: avoid_print

// ÉTAPE 1 — Une classe pour représenter UNE tâche.
class Tache {
  // final : l'identifiant, le titre et la note ne sont pas réaffectés.
  final int id;
  final String titre;
  // Le ? autorise l'absence de note : sa valeur peut être null.
  final String? note;
  // Cet attribut peut changer : une tâche passe de « à faire » à « terminée ».
  bool terminee;

  // Les accolades définissent des paramètres NOMMÉS.
  // required impose de fournir id et titre ; les autres sont facultatifs.
  Tache({
    required this.id,
    required this.titre,
    this.note,
    this.terminee = false,
  });

  // void : la méthode change l'objet, sans renvoyer de valeur.
  void terminer() {
    terminee = true;
  }

  // print(tache) appelle cette représentation lisible de l'objet.
  @override
  String toString() {
    // ?: choisit entre deux valeurs en fonction d'une condition.
    final caseACocher = terminee ? 'x' : ' ';
    // ?? propose une valeur de remplacement UNIQUEMENT en cas de null.
    return '[$caseACocher] #$id $titre — ${note ?? 'Sans note'}';
  }
}

// Prédire les deux affichages avant d'exécuter.
void main() {
  const nomApplication = 'Atelier 2 — Mission Dart';
  final premiere = Tache(id: 1, titre: 'Réviser les classes');
  final seconde = Tache(id: 2, titre: 'Préparer Flutter', note: 'Pour mardi');
  print(nomApplication);
  print(premiere); // [ ] #1 Réviser les classes — Sans note
  print(seconde); // [ ] #2 Préparer Flutter — Pour mardi
  // final interdit premiere = uneAutreTache, mais l'objet reste modifiable.
  premiere.terminer();
  print(premiere); // [x] #1 Réviser les classes — Sans note
}
