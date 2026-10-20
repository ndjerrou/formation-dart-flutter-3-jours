# Notre premier écran

Jalon **01_accueil** - fiches F01, F02, F03.

## Notre point de départ

Le kit contient déjà ce premier écran dans lib. Il est exécutable avant les modifications.

La commande reste `flutter run -d chrome` et l’entrée reste `lib/main.dart`.

## Modifications à intégrer

1. Lancer flutter run -d chrome depuis le dossier de pubspec.yaml.
2. Dans lib/configuration.dart, personnaliser messageAccueil et titreApplication.
3. Dans lib/main.dart, ajouter un debugPrint avant runApp, observer le terminal puis retirer le log.
4. Dans CatalogueScreen.build, entourer le Text avec un Padding et dessiner le nouvel arbre.

## Fichiers concernés

- `lib/main.dart` : ajouter ce fichier.
- `lib/app.dart` : ajouter ce fichier.
- `lib/configuration.dart` : ajouter ce fichier.
- `lib/screens/catalogue_screen.dart` : ajouter ce fichier.

## Vérifier aussi ce qui fonctionnait déjà

- [ ] Le titre et le message personnalisés apparaissent.
- [ ] Un Text affiché et un log exécuté ont deux destinations différentes.

## Code de référence après ce jalon

Essayer avant d’ouvrir la correction. Les fichiers ci-dessous montrent le résultat attendu pour comparer les blocs modifiés. Ils ne se collent pas tous dans main.dart.

<details>
<summary>Voir lib/main.dart</summary>

```dart
import 'package:flutter/material.dart';

import 'app.dart';

// Ce point d'entrée reste le même pendant tout le parcours.
void main() => runApp(const HelpMeApp());
```

</details>

<details>
<summary>Voir lib/app.dart</summary>

```dart
import 'package:flutter/material.dart';

import 'configuration.dart';
import 'screens/catalogue_screen.dart';

class HelpMeApp extends StatelessWidget {
  const HelpMeApp({
    super.key,
    this.responsive = true,
    this.simulerErreur = false,
  });
  final bool responsive;
  final bool simulerErreur;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: titreApplication,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: CatalogueScreen(
        responsive: responsive,
        simulerErreur: simulerErreur,
      ),
    );
  }
}
```

</details>

<details>
<summary>Voir lib/configuration.dart</summary>

```dart
// Personnaliser ici : ces réglages sont conservés pendant tout le parcours.
const titreApplication = 'HelpMe';
const messageAccueil = 'Bonjour Flutter !';
```

</details>

<details>
<summary>Voir lib/screens/catalogue_screen.dart</summary>

```dart
import 'package:flutter/material.dart';

import '../configuration.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({
    super.key,
    this.responsive = true,
    this.simulerErreur = false,
  });
  final bool responsive;
  final bool simulerErreur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(titreApplication)),
      body: const Center(child: Text(messageAccueil)),
    );
  }
}
```

</details>
