import '../corrections/tache.dart';

void main() {
  final source = <Tache>[Tache(id: 1, titre: 'Lire')];
  final alias = source;
  alias.add(Tache(id: 2, titre: 'Coder'));
  print(
    'Alias : même liste = ${identical(source, alias)}, longueur = ${source.length}',
  );

  final superficielle = <Tache>[...source];
  superficielle.removeLast();
  print('Retrait : source=${source.length}, copie=${superficielle.length}');
  superficielle.first.renommer('Lire les classes');
  print('Objet partagé : ${source.first.titre}'); // Lire les classes
  print('Même liste : ${identical(source, superficielle)}'); // false
  print(
    'Même première tâche : ${identical(source.first, superficielle.first)}',
  );

  final isolee = source.map((tache) => Tache.copie(tache)).toList();
  isolee.first.terminer();
  print(
    'Copie des objets : source=${source.first.terminee}, copie=${isolee.first.terminee}',
  );

  final index = <int, Tache>{1: source.first, 2: source.last};
  final copieIndex = <int, Tache>{...index};
  copieIndex.remove(2);
  print(
    'Maps distinctes : origine=${index.length}, copie=${copieIndex.length}',
  );
  final partagee = copieIndex[1];
  if (partagee != null) {
    partagee.renommer('Titre changé via la map copiée');
  }
  print('Valeur encore partagée : ${source.first.titre}');
}
