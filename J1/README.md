# J1 - Les bases de Dart

Le but de cette journée est de comprendre comment représenter des données,
écrire des fonctions puis réunir données et comportements dans des objets.

## Parcours

| Étape | Support | Ce que l'on travaille |
| --- | --- | --- |
| 1 | [Bases du langage](01_bases/README.md) | `print`, types, expressions, booléens, fonctions, listes et maps |
| 2 | [Classes et todo list](02_classes_todo/README.md) | Instances, constructeurs, méthodes, `final`, `const` et imports |
| 3 | [QCM classes](qcm_classes.md) | Prédire le résultat d'un code et justifier sa réponse |
| 4 | [Atelier 1 - Deck](03_deck/README.md) | Composition, collection d'objets, filtre et distribution |
| 5 | [Atelier 2 - CLI](04_cli/README.md) | Saisie, menu, nullabilité, erreurs et asynchrone |

[Relire le résumé de la journée](recap.md).

## Lancer une version complète

Ces commandes se lancent depuis la racine du dépôt. Les fichiers sont
indépendants, sauf les modules de la todo list reliés par des imports.

```bash
dart run J1/02_classes_todo/corrections/main.dart
dart run J1/03_deck/corrections/atelier_1.dart
dart run J1/04_cli/corrections/etape_04_complet.dart
```

Le dernier programme attend tes choix dans le terminal. Utiliser `0` pour quitter.

## A savoir expliquer

- La différence entre une classe et une instance.
- Ce que prépare un constructeur et ce que signifie `this.champ`.
- La différence entre un champ, un paramètre et une variable locale.
- La différence entre `return` et `print`.
- Ce que protège `final` et ce que produit `const`.
- La différence entre un alias et une copie de liste ou de map.
- Pourquoi une copie de collection peut encore partager ses objets.
- La raison d'un type nullable comme `Tache?`.
- Le rôle d'un import et de la confidentialité avec `_`.
- Ce qu'une fonction `async` renvoie et ce que fait `await`.
