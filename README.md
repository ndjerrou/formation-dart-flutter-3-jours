# Formation Dart et Flutter

Ce dépôt rassemble les exemples, exercices et corrections de la formation.
Les supports sont organisés par journée pour retrouver le travail fait en cours.

| Journée | Contenu | État |
| --- | --- | --- |
| [J1 - Dart](J1/README.md) | Bases, classes, todo list, deck de cartes et programme CLI | Disponible |
| [J2 - Premiers pas avec Flutter](J2/README.md) | HelpMe cumulatif : widgets, catalogue, favoris, fiche et formulaire | Disponible |
| [J3 - Projet Flutter](J3/README.md) | Assemblage du projet et consolidation | À compléter pendant la formation |

## Commencer

Installer le [SDK Dart](https://dart.dev/get-dart) ou le
[SDK Flutter](https://docs.flutter.dev/install), qui inclut Dart, puis Git.
Vérifier que le terminal reconnaît la commande `dart --version`.

```bash
git clone https://github.com/ndjerrou/formation-dart-flutter-3-jours.git
cd formation-dart-flutter-3-jours
dart pub get
dart run J1/01_bases/corrections/etape_01_print.dart
```

Les résultats de `print` apparaissent dans le terminal utilisé pour lancer
le fichier. Enregistrer puis relancer `dart run chemin/du/fichier.dart`
pour exécuter une modification. J1 n'utilise aucun package externe.

## Se repérer

```text
J1/
  01_bases/          # Variables, types, logique, collections, fonctions.
  02_classes_todo/   # Classes, instances, constructeurs et imports.
  03_deck/           # Atelier 1 : paquet de 52 cartes.
  04_cli/            # Atelier 2 : carnet de tâches interactif.
  qcm_classes.md    # 30 questions et corrigé expliqué.
  recap.md          # Résumé des notions de la journée.
  verification.dart
J2/                 # Projet Flutter cumulatif, PDF et onze jalons.
J3/                 # Supports de la troisième journée.
travaux/            # Tes essais locaux, ignorés par Git.
```

Dans chaque atelier, `exercices/` contient les points de départ et
`corrections/` les versions terminées. Les `TODO` signalent les parties
à compléter. Conserver sa tentative avant de consulter une correction.

Dupliquer le **dossier d'un exercice** dans un dossier personnel `travaux/`
avant de le modifier. Garder les fichiers voisins quand le programme
utilise des imports locaux. Le dépôt peut ainsi être actualisé sans
remplacer tes essais.

## Retrouver les nouveautés

Depuis la racine du dépôt :

```bash
git pull --ff-only
```

Ouvrir ensuite le README de la journée suivie. Les commandes présentées
dans le README principal et celui de J1 se lancent depuis la racine.

## Vérifier J1

```bash
dart analyze J1
dart run J1/verification.dart
```

Les vérifications couvrent le modèle todo, le deck et le carnet CLI.
Les programmes interactifs se lancent dans un terminal. Leurs données
restent en mémoire et la sauvegarde proposée par le CLI est une simulation.
