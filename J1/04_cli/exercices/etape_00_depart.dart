// ATELIER 2 — Mission Dart — DÉPART ÉLÈVE.
// Exécution dans ce dossier : dart run etape_00_depart.dart
// Ce point de départ fonctionne avant toute modification.
// Copie-le dans mon_atelier.dart : ce sera TON fichier pendant la séance.
// ignore_for_file: avoid_print

// Comme Card ce matin, Tache décrit un objet du programme.
class Tache {
  final int id;
  final String titre;

  // Nouveauté à observer : les paramètres nommés entre accolades.
  Tache({required this.id, required this.titre});

  // TODO A1 : ajouter String? note et bool terminee = false.
  // Adapter le constructeur : note facultative, terminee avec valeur par défaut.
  // TODO A2 : ajouter une méthode terminer() qui change terminee en true.

  @override
  String toString() {
    // TODO A3 : afficher [ ] ou [x], et « Sans note » quand note est null.
    return '#$id $titre';
  }
}

void main() {
  const nomApplication = 'Atelier 2 — Mission Dart';
  final tache = Tache(id: 1, titre: 'Réviser les classes');
  print(nomApplication);
  print(tache);
  // TODO A4 : créer une deuxième tâche avec une note.
  // Afficher la première AVANT et APRÈS l'appel de terminer().
  // La fiche élève contient les étapes B, C, D et le défi final.
}
