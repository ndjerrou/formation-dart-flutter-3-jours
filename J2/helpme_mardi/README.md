# HelpMe - Parcours Flutter cumulatif

On construit UNE application et on conserve les fonctionnalités précédentes.
Le point d'entrée reste toujours `lib/main.dart`.

## Démarrer

Ouvrir ce dossier dans VS Code : `pubspec.yaml` doit être visible.

```bash
flutter --version
flutter pub get
flutter devices
flutter run -d chrome
```

Au départ, l'application affiche Bonjour Flutter. Modifier le message dans
`lib/configuration.dart`, enregistrer puis utiliser `r` dans le terminal.
`R` redémarre l'application ; `q` quitte. Le passage de StatelessWidget à
StatefulWidget demande un redémarrage avec `R`. L'état en mémoire est alors perdu.

## Si tu as commencé avec un ancien kit

Garder une copie de ton ancien dossier avant d’ouvrir ce nouveau kit dans un
nouveau dossier. Reporter ton titre et ton message personnels dans
`lib/configuration.dart`. Pour continuer, suivre uniquement ce kit et son PDF
mis à jour : la commande reste la même pendant toute la progression.

## Avancer sans repartir de zéro

Suivre [le parcours](parcours/PAS_A_PAS.md) et les fiches F01 à F21 du PDF.
A chaque jalon, modifier ou ajouter les fichiers indiqués DANS `lib/`.
Garder les fonctions déjà réalisées et refaire leurs vérifications.
On ne change pas la commande de lancement entre les jalons.

Les fichiers présentés dans un bloc « code de référence » sont un corrigé
pour comparer et dépanner. En progression normale, intégrer les modifications
ciblées dans son travail, sans remplacer tout le dossier `lib`.

## Dossiers

- `lib/` : notre travail courant, qui commence au premier écran.
- `parcours/` : les consignes, modifications et preuves à vérifier.
- `test/` : un test de démarrage compatible avec la progression.
- `web/` : le lancement dans Chrome.
- `corrections/` et `verifications/` : présents dans le kit de correction.
  Les corrections contiennent les versions complètes et cumulatives de `lib`.

```bash
flutter analyze
flutter test
```

Dans le kit de correction, `flutter test verifications` vérifie les jalons
et le parcours final. Pour essayer une correction, dupliquer d'abord le
projet entier dans un autre dossier, puis y remplacer `lib` par le `lib`
du jalon choisi. Lancer la même commande `flutter run -d chrome`.
Ne jamais effectuer ce remplacement sur son unique copie de travail.

Pour tester la panne après le jalon 09, passer `simulerErreur: true` à
`HelpMeApp` dans `lib/main.dart`, puis utiliser `R`. Remettre false pour
retrouver le succès. Le bouton de sélection reste distinct de l'envoi du formulaire.

Les artisans et tarifs sont fictifs. Les demandes sont simulées ; aucune
demande n'est réellement transmise et aucune donnée n'est persistée.

## Appareil natif déjà préparé

Le kit fournit la cible web. Pour une vérification native, créer les dossiers
Android/iOS dans une copie du projet avant la séance :

```bash
flutter create --platforms=android,ios .
flutter devices
flutter run -d IDENTIFIANT_APPAREIL
```

La cible iOS demande un Mac et Xcode. Préparer aussi l’appareil et son accès
au SDK natif ; une fenêtre Chrome étroite ne valide pas cette exécution.
