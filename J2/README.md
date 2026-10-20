# J2 - Construire HelpMe progressivement avec Flutter

Une seule application, un seul point d’entrée : **`lib/main.dart`**.
Chaque jalon conserve les fonctionnalités déjà construites.

## Les supports à utiliser

- [PDF du cours](mardi-flutter-eleve.pdf) : notions, exercices et quiz.
- [Le même cours en Markdown](cours.md).
- [Télécharger le kit élève](https://raw.githubusercontent.com/ndjerrou/formation-dart-flutter-3-jours/main/J2/ressources/mardi-flutter-code-eleve.zip).
- [Parcours pas à pas](helpme_mardi/parcours/PAS_A_PAS.md) : changements à intégrer et vérifications à conserver.

## Démarrer depuis le dépôt

Depuis la racine :

```bash
git pull --ff-only
cd J2/helpme_mardi
flutter pub get
flutter run -d chrome
```

Le projet s’ouvre aussi depuis le ZIP : décompresser, ouvrir `helpme_mardi`
dans VS Code, puis exécuter ces deux dernières commandes dans son terminal.
Pour travailler sans modifier les supports suivis par Git, dupliquer le dossier
complet `helpme_mardi` dans `travaux/` et ouvrir cette copie dans l’éditeur.

## Fonctionnement du fil rouge

1. Le projet démarre au premier écran. Personnaliser le titre et le message
   dans `lib/configuration.dart`.
2. Suivre les fiches F01 à F21 du PDF et les jalons du dossier `parcours/`.
3. Modifier ou ajouter les fichiers indiqués dans notre `lib/` courant.
4. Enregistrer puis utiliser `r`. Après passage de StatelessWidget à
   StatefulWidget, utiliser `R`. Le redémarrage remet l’état en mémoire à zéro.
5. A chaque jalon, vérifier aussi les fonctions des jalons précédents.

On garde **la même commande de lancement** pendant la progression.
Les favoris ne sont pas réécrits quand la recherche arrive ; la fiche et
son formulaire ne sont pas remplacés quand on adapte la largeur.

## Les onze jalons

| Jalon | Ce qui s’ajoute |
| --- | --- |
| 01 | Premier écran et personnalisation |
| 02 | Widget réutilisable à paramètres |
| 03 | Carte d’un artisan |
| 04 | Liste défilante d’artisans |
| 05 | Favoris et compteur |
| 06 | Extraction de la carte et callbacks |
| 07 | Fiche, navigation et résultat de retour |
| 08 | Formulaire et validation |
| 09 | Attente, succès et erreur simulée |
| 10 | Mise en page adaptative et vérifications |
| 11 | Recherche combinée au filtre des favoris |

## Corrections et vérifications

`helpme_mardi/corrections/` contient le dossier `lib` complet après chaque jalon.
Ce sont des repères pour comparer ou dépanner. En progression normale, intégrer
les ajouts dans son travail sans remplacer tout `lib`.
Pour essayer une correction complète, dupliquer d’abord le projet puis remplacer
uniquement le `lib` de cette copie par le `lib` du jalon choisi.

Depuis `J2/helpme_mardi` :

```bash
flutter analyze
flutter test
flutter test verifications
```

Les tests vérifient le départ, la continuité entre les jalons et le parcours final.
Les personnes et tarifs sont fictifs ; les demandes sont simulées et les données
restent en mémoire. Le kit fournit Chrome. La préparation d’une cible native est
expliquée dans [le README du projet](helpme_mardi/README.md).

Si vous aviez commencé avec l’ancien kit, conserver ce travail dans un autre
dossier puis utiliser ce kit et ce PDF mis à jour ensemble.

[Retour au parcours des trois jours](../README.md)
