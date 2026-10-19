# Todo list en Dart

## Objectif

Écrire un petit gestionnaire de tâches en Dart à l'aide de classes. Les données restent en mémoire pendant l'exécution du programme.

## La classe `Tache`

Une tâche possède :

- un identifiant `id`, de type `int`, qui ne change jamais ;
- un titre, de type `String`, qu'on peut lire mais pas modifier directement depuis l'extérieur de la classe ;
- un état `terminee`, de type `bool`, qui vaut `false` par défaut.

Le constructeur utilise des paramètres nommés. L'identifiant et le titre sont obligatoires.

Il faut aussi prévoir :

- `terminer()` : marque la tâche comme terminée ;
- `rouvrir()` : la remet en cours ;
- `renommer(String nouveauTitre)` : change le titre ;
- `decrire()` : renvoie une ligne de texte décrivant la tâche, avec son état, son identifiant et son titre.

Un titre vide, ou composé uniquement d'espaces, est refusé.

## La classe `ListeTaches`

Une liste de tâches gère une collection de `Tache`. Elle doit proposer :

- `ajouter(String titre)` : crée une tâche avec un identifiant automatique et la renvoie ;
- `chercher(int id)` : renvoie la tâche correspondante, ou `null` si elle n'existe pas ;
- `terminer(int id)`, `rouvrir(int id)` et `renommer(int id, String titre)` : renvoient `true` si la tâche existe, `false` sinon ;
- `supprimer(int id)` : retire la tâche et renvoie `true` si elle existait, `false` sinon ;
- `taches` : la liste de toutes les tâches, sans permettre d'ajouter ou de retirer des éléments depuis l'extérieur ;
- `enCours` : la liste des tâches non terminées ;
- `nombreEnCours` : le nombre de tâches non terminées.

Les identifiants ne doivent jamais être réutilisés, même après une suppression.

## Programme de test

Votre programme doit fonctionner avec ce `main` :

```dart
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
```

## Pour aller plus loin (facultatif)

- Ajouter une méthode qui affiche les tâches en cours sous forme de liste numérotée.
- Ajouter un menu en ligne de commande qui permet d'ajouter, terminer et supprimer des tâches à partir du clavier.
