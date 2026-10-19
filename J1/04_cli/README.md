# Atelier 2 - Carnet de tâches en ligne de commande

Réutiliser les classes pour construire un programme avec un menu, des
saisies contrôlées et une opération asynchrone simulée.

| Étape | Point de départ | Correction |
| --- | --- | --- |
| A - Objets, paramètres nommés et null | [Départ](exercices/etape_00_depart.dart) | [Objets](corrections/etape_01_objets.dart) |
| B - Collection, filtre et recherche | [Départ](exercices/etape_02_collections_depart.dart) | [Collections](corrections/etape_02_collections.dart) |
| C - Menu, saisies et conversion | [Départ](exercices/etape_03_cli_depart.dart) | [Menu](corrections/etape_03_cli.dart) |
| D - Future, await et erreurs | [Départ](exercices/etape_04_async_depart.dart) | [Programme complet](corrections/etape_04_complet.dart) |

Chaque étape est un fichier autonome. Les points de départ fonctionnent
avant modification, mais certains comportements restent à compléter.

## Comportements attendus

- Le carnet attribue un identifiant à chaque nouvelle tâche.
- Une note peut être absente : `String?` et `??` traitent ce cas.
- Un titre vide est refusé sans créer de tâche.
- Une recherche absente renvoie `null` ; terminer un id absent renvoie `false`.
- Le filtre montre les tâches en cours sans supprimer les autres.
- `int.tryParse` permet de traiter une saisie non numérique.
- La sauvegarde simulée renvoie un `Future<int>` : on attend le résultat
  avec `await` et on affiche une erreur attendue avec `try/catch`.
- `finally` s'exécute en réussite comme en échec.

Depuis la racine du dépôt :

```bash
dart run J1/04_cli/exercices/etape_00_depart.dart
dart run J1/04_cli/corrections/etape_04_complet.dart
dart run J1/04_cli/corrections/verification.dart
```

Le menu final propose les choix 1 à 6 et `0` pour quitter. Essayer une
saisie invalide, un id absent, une sauvegarde réussie et une panne simulée.
Aucun fichier n'est écrit : les données disparaissent à la fermeture.
