# HelpMe - Un seul projet, onze jalons cumulatifs

Lancer **`flutter run -d chrome`** et garder **`lib/main.dart`** comme point d’entrée.

Modifier le dossier `lib/` courant au fur et à mesure. Une étape ajoute ou fait évoluer une partie du code ; elle ne remplace pas toute l’application. Garder les personnalisations de `configuration.dart`.

Enregistrer puis utiliser `r`. Après un changement de type de widget, utiliser `R`. Un redémarrage conserve les fichiers, mais réinitialise les données en mémoire.

Les blocs de référence sont des corrections pour comparer. Intégrer les modifications ciblées dans son travail. Avant de restaurer une correction complète, sauvegarder son projet dans un autre dossier.

| Jalon | Fiches du PDF | Ce que nous ajoutons |
| --- | --- | --- |
| [01_accueil](01_accueil.md) | F01, F02, F03 | Notre premier écran |
| [02_parametres](02_parametres.md) | F04 | Ajouter un composant sans effacer notre écran |
| [03_presentation](03_presentation.md) | F05, F06, F07 | Ajouter une carte à notre page |
| [04_catalogue](04_catalogue.md) | F08 | Passer d’une carte à une liste |
| [05_favoris](05_favoris.md) | F09, F10 | Rendre notre catalogue interactif |
| [06_composants](06_composants.md) | F11 | Extraire la carte, garder les favoris |
| [07_navigation](07_navigation.md) | F12 | Ajouter une fiche au catalogue existant |
| [08_formulaire](08_formulaire.md) | F13, F14 | Enrichir la même fiche avec un formulaire |
| [09_asynchrone](09_asynchrone.md) | F15, F16 | Ajouter attente et erreur au même formulaire |
| [10_responsive](10_responsive.md) | F17, F18, F19 | Adapter notre application déjà fonctionnelle |
| [11_recherche](11_recherche.md) | F20, F21 | Ajouter la recherche, garder tout le parcours |

## Après le dernier jalon

La même application possède le catalogue, les favoris, la sélection d’un artisan, une fiche avec formulaire, l’attente et l’erreur simulées, une présentation adaptative, la recherche et le filtre des favoris. Les données restent en mémoire.
