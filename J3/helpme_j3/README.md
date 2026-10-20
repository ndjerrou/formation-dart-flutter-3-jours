# HelpMe - J3

Ouvrir ce dossier dans VS Code (celui qui contient `pubspec.yaml`).

```bash
flutter pub get
flutter run -d chrome --web-port 8310
```

Pour comparer deux versions, utiliser un port différent pour chacune : 8310 pour
le départ et 8320 pour la version complète. Le port stable conserve les données
du navigateur entre deux lancements. Dans VS Code, F5 utilise `lib/main.dart`.

Les favoris et la langue sont conservés sur cet appareil. Les demandes du mode
local sont stockées dans une base locale ; aucune n'est envoyée à un artisan réel.
Les comptes locaux « client » et « prestataire » se choisissent dans Connexion.
Le prestataire de démonstration correspond à Gérard (artisan 1).

Pour utiliser le simulateur iPhone :

```bash
open -a Simulator
flutter devices
flutter run -d IDENTIFIANT_SIMULATEUR
```

Enregistrer recharge l'interface dans le débogueur. Après changement de `main`,
initialisation ou `initState`, faire un Hot Restart.

## Vérifier

```bash
flutter analyze
flutter test
```

Le dossier `recette_finale/`, présent dans la version de départ, contient les
attentes de la version terminée : ses tests peuvent échouer tant que les défauts
étudiés ne sont pas corrigés. Les tests de `test/` vérifient le rôle de la version
ouverte. Ne pas interpréter un défaut pédagogique comme un comportement final.

## Réseau et génération

Dans un terminal : `dart run tools/catalogue_server.dart`.
Dans un autre :

```bash
flutter run -d chrome --web-port 8320 --dart-define=CATALOGUE_URL=http://127.0.0.1:8787/artisans
dart run build_runner build
flutter gen-l10n
```

Le serveur local propose aussi les modes `erreur` (HTTP 503) et `json` (contenu
invalide) en premier argument. Le cache peut maintenir le catalogue visible après
une panne ; le libellé indique alors explicitement que les données sont locales.

## Firebase

La configuration cloud se prépare avec le professeur avant la démonstration.
Le fichier `lib/firebase_options.dart` fourni est un point d'attente pour
`flutterfire configure`, pas une configuration de projet existant.

Après configuration seulement :

```bash
flutter run -d chrome --web-port 8320 --dart-define=USE_FIREBASE=true
```

Le serveur filtre les demandes selon le compte connecté. Les rôles prestataires
sont attribués par l'administration Firebase, jamais par une case à cocher dans
l'interface. Les push réels sont montrés sur l'iPhone du professeur.
