# Corrections des étapes suivies en cours

Chaque fichier `.dart` contient une correction complète de l’étape correspondante,
avec ses modèles et composants. Il peut se lire et se lancer indépendamment des
autres corrections. Les personnes, tarifs et demandes sont fictifs.

## Lancer une étape

Depuis `J2/helpme_mardi` :

```bash
flutter pub get
flutter run -d chrome -t etapes_corrigees/02_layout.dart
```

Remplacer le nom du fichier pour choisir une autre étape. Sur un projet déjà
préparé pour iOS, remplacer `chrome` par l’identifiant du simulateur retourné par
`flutter devices`.

Dans VS Code, ouvrir le fichier voulu, puis utiliser **Run / Debug** au-dessus de
son `main()`. Si une configuration de débogage existe, vérifier son champ `program` :
il doit désigner ce fichier. Arrêter la session précédente avant de changer d’étape.

L’interface est construite dans `build()` pour permettre le hot reload des textes
et de la disposition. Un Hot Restart réinitialise les favoris et les formulaires.

## Les fichiers

| Étape | Contenu |
| --- | --- |
| [01_bonjour.dart](01_bonjour.dart) | Premier écran |
| [01b_parametres.dart](01b_parametres.dart) | Paramètres et composant réutilisable |
| [02_layout.dart](02_layout.dart) | Disposition de la carte |
| [03_liste.dart](03_liste.dart) | Liste des artisans |
| [04_etat.dart](04_etat.dart) | État et favoris |
| [05_callbacks.dart](05_callbacks.dart) | Composants et callbacks |
| [06_navigation.dart](06_navigation.dart) | Navigation et retour |
| [07_formulaire.dart](07_formulaire.dart) | Formulaire et validation |
| [08_asynchrone.dart](08_asynchrone.dart) | Traitement asynchrone |
| [09_integration.dart](09_integration.dart) | Intégration du parcours |
| [10_responsive.dart](10_responsive.dart) | Disposition adaptative |

## Se repérer dans les deux parcours

Ces fichiers reprennent les noms du premier kit utilisé en cours, notamment
`01b_parametres` et `02_layout`. Ils permettent de comparer son exercice avec une
version terminée. Les étapes sont indépendantes : elles ne conservent pas toutes
les fonctionnalités de la précédente. Par exemple, l’étape formulaire isole la
saisie avant son intégration au catalogue.

Le [parcours cumulatif](../parcours/PAS_A_PAS.md) conserve au contraire les acquis
dans un seul `lib/`, lancé avec `flutter run -d chrome`. Ses versions complètes par
jalon se trouvent dans [corrections/](../corrections/). Ne pas mélanger les deux
modes de lancement dans une même session.

Dans ces corrections de lecture, modèles et composants sont regroupés par étape.
Dans son application, on peut les répartir en fichiers puis les importer, comme
le montre le parcours cumulatif.
