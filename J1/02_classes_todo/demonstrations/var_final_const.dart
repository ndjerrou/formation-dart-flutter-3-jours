import '../corrections/tache.dart';

void main() {
  var remplacable = Tache(id: 1, titre: 'Ancienne');
  remplacable = Tache(id: 2, titre: 'Nouvelle');
  print('var réaffecté : ${remplacable.titre}');
  // remplacable = 'Bonjour'; // Erreur d'analyse : le type reste Tache.

  final t = Tache(id: 3, titre: 'Lire');
  t.terminer();
  print('final, objet mutable : ${t.decrire()}');
  // t = Tache(id: 4, titre: 'Autre'); // Erreur d'analyse : t est final.

  final titresMutables = <String>['Lire'];
  titresMutables.add('Coder');
  print('final + liste mutable : $titresMutables');

  var titresRemplacables = const <String>['Lire'];
  titresRemplacables = <String>['Coder'];
  print('var + première valeur const, réaffectée : $titresRemplacables');

  final titresConstants = const <String>['Lire'];
  try {
    titresConstants.add('Coder');
  } on UnsupportedError {
    print('final + liste const : add refusé à l\'exécution, erreur attrapée.');
  }
  // const autre = titresConstants; // Invalide : variable final, pas const.

  const limite = 10;
  final maintenant = DateTime.now();
  print(
    'const limite : $limite ; final date calculée : ${maintenant.toIso8601String()}',
  );
  // const date = DateTime.now(); // Erreur d'analyse : appel non constant.
}
