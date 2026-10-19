import '../corrections/tache.dart';

void main() {
  const a = TacheImmuable(id: 1, titre: 'Lire');
  final b = const TacheImmuable(id: 1, titre: 'Lire');
  print('a et b, mêmes objets constants : ${identical(a, b)}'); // true
  const copieDeA = a;
  print('Constante dérivée de a : ${copieDeA.titre}');
  // const copieDeB = b; // Invalide : b est une variable final.

  var actuelle = const TacheImmuable(id: 2, titre: 'Coder');
  final originale = actuelle;
  actuelle = actuelle.avecStatut(true);
  print('Originale : ${originale.terminee} ; actuelle : ${actuelle.terminee}');
  print('Même objet après remplacement : ${identical(originale, actuelle)}');

  final runtimeA = TacheImmuable(id: 1, titre: 'Lire');
  final runtimeB = TacheImmuable(id: 1, titre: 'Lire');
  print(
    'Deux appels sans const, même objet : ${identical(runtimeA, runtimeB)}',
  );
  // runtimeA.terminee = true; // Invalide : le champ est final même sans const.
}
