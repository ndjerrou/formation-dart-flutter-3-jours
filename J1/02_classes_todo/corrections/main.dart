import 'liste_taches.dart';

void main() {
  final liste = ListeTaches();

  liste.ajouter('Préparer le cours');
  liste.ajouter('Faire les exercices');
  liste.ajouter('Tester mon code');

  liste.terminer(2);
  liste.renommer(3, 'Tester les imports');
  liste.supprimer(1);
  liste.ajouter('Relire le cours');

  for (final tache in liste.taches) {
    print(tache.decrire());
  }
  print('Tâches en cours : ${liste.nombreEnCours}');
  print('Terminer 999 : ${liste.terminer(999)}');
}
