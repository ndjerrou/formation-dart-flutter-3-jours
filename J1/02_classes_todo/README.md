# Classes et todo list

Construire un petit programme qui ajoute, termine, rouvre, renomme et
supprime des tâches. Le [point de départ](exercices/main.dart) ne contient
que `void main() {}`. Les consignes sont regroupées ici.

[Consigne de l'exercice todo list](consignes.md).

## 1. Représenter une tâche

Définir une classe `Tache`. Chaque instance possède un identifiant `int`,
un titre `String` et un état terminé/non terminé. Donner l'identifiant et
le titre au constructeur ; une nouvelle tâche n'est pas terminée par défaut.
Garder l'identifiant `final`. Créer deux tâches et ne terminer que la première.

## 2. Ajouter des comportements

Ecrire `terminer()`, `rouvrir()`, `renommer(String titre)` et
`String decrire()`. La description a la forme `[ ] 1 - Lire` ou
`[x] 1 - Lire`. `decrire()` renvoie un texte ; le `main` décide de l'afficher.
Refuser les titres vides, y compris ceux composés uniquement d'espaces.

## 3. Gérer plusieurs tâches

Créer une classe `ListeTaches` qui contient les tâches et attribue les
identifiants. Prévoir les opérations suivantes :

| Opération | Résultat attendu |
| --- | --- |
| `ajouter(String titre)` | La nouvelle `Tache` |
| `chercher(int id)` | Une `Tache?`, `null` si absente |
| `terminer(int id)`, `rouvrir(int id)` | `true` si trouvée, `false` sinon |
| `renommer(int id, String titre)` | `true` si trouvée, `false` sinon |
| `supprimer(int id)` | `true` si retirée, `false` sinon |
| Getter `taches` | Un instantané de liste dont la structure est non modifiable |
| Getter `enCours` | Les tâches qui ne sont pas terminées |
| Getter `nombreEnCours` | Leur nombre |

Un ajout refusé ne crée pas de tâche. Un identifiant déjà attribué n'est
pas réutilisé après suppression. La liste est protégée en structure,
mais les objets `Tache` qu'elle contient restent mutables.

## 4. Expérimenter les références

Comparer `alias = source`, `copie = [...source]` et une copie qui reconstruit
chaque tâche avec `Tache.copie`. Faire la même expérience avec une map.
Pour chaque essai, distinguer la mutation du conteneur et celle d'une tâche.

## 5. Comparer final et const

Ecrire une seconde classe `TacheImmuable` avec des champs `final` et un
constructeur `const`. Une méthode `avecStatut(bool)` renvoie une nouvelle
tâche. Comparer `const a = ...`, `final b = const ...` et un appel ordinaire.
Expliquer pourquoi `final b = const ...` ne déclare pas la variable `b` const.

Des expériences exécutables sont dans [demonstrations/](demonstrations/).
Depuis la racine :

```bash
dart run J1/02_classes_todo/demonstrations/var_final_const.dart
dart run J1/02_classes_todo/demonstrations/constructeur_const.dart
dart run J1/02_classes_todo/demonstrations/references_collections.dart
```

## 6. Séparer les fichiers

Déplacer les modèles dans `tache.dart`, la gestion de collection dans
`liste_taches.dart` et garder le scénario dans `main.dart`. Ajouter les
imports locaux nécessaires. Le dossier [corrections/](corrections/) montre
le découpage complet ; il ne contient aucun package externe.

## Scénario à réussir

Ajouter Préparer le cours, Faire les exercices et Tester mon code.
Terminer la tâche 2. Renommer la tâche 3 en Tester les imports.
Supprimer la tâche 1, puis ajouter Relire le cours.

```text
[x] 2 - Faire les exercices
[ ] 3 - Tester les imports
[ ] 4 - Relire le cours
Tâches en cours : 2
Terminer 999 : false
```

Depuis la racine du dépôt :

```bash
dart run J1/02_classes_todo/corrections/main.dart
dart run J1/02_classes_todo/corrections/menu.dart
```

Le menu est un prolongement interactif. Il conserve ses données seulement
pendant l'exécution et propose `0` pour quitter.
