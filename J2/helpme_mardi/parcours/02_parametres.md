# Ajouter un composant sans effacer notre écran

Jalon **02_parametres** - fiches F04.

## Notre point de départ

Notre projet courant contient déjà le jalon 01_accueil. On le complète, on ne le remplace pas.

La commande reste `flutter run -d chrome` et l’entrée reste `lib/main.dart`.

## Modifications à intégrer

1. Créer lib/widgets/titre_section.dart : StatelessWidget, champ final titre, constructeur nommé required, build qui renvoie Text.
2. Importer ce widget dans catalogue_screen.dart.
3. Remplacer le Center du body par une Column espacée avec TitreSection, notre Text(messageAccueil) et un second TitreSection.
4. Transmettre Trouver un artisan puis Des professionnels près de chez vous aux deux instances. Garder le message personnalisé.

## Fichiers concernés

- `lib/screens/catalogue_screen.dart` : faire évoluer ce fichier en conservant le reste.
- `lib/widgets/titre_section.dart` : ajouter ce fichier.

## Vérifier aussi ce qui fonctionnait déjà

- [ ] Deux titres différents utilisent la même classe.
- [ ] Le titre de l’application et le message personnel sont conservés.

## Code de référence après ce jalon

Essayer avant d’ouvrir la correction. Les fichiers ci-dessous montrent le résultat attendu pour comparer les blocs modifiés. Ils ne se collent pas tous dans main.dart.

<details>
<summary>Voir lib/screens/catalogue_screen.dart</summary>

```dart
import 'package:flutter/material.dart';

import '../configuration.dart';
import '../widgets/titre_section.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitreSection(titre: 'Trouver un artisan'),
              const SizedBox(height: 8),
              const Text(messageAccueil),
              const SizedBox(height: 12),
              const TitreSection(titre: 'Des professionnels près de chez vous'),
            ],
          ),
        ),
      ),
    );
  }
}
```

</details>

<details>
<summary>Voir lib/widgets/titre_section.dart</summary>

```dart
import 'package:flutter/material.dart';

// Même composant, textes différents : une configuration, pas un état mutable.
class TitreSection extends StatelessWidget {
  const TitreSection({super.key, required this.titre});
  final String titre;

  @override
  Widget build(BuildContext context) {
    return Text(titre, style: Theme.of(context).textTheme.titleLarge);
  }
}
```

</details>
