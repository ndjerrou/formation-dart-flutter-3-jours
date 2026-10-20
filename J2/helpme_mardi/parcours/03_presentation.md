# Ajouter une carte à notre page

Jalon **03_presentation** - fiches F05, F06, F07.

## Notre point de départ

Notre projet courant contient déjà le jalon 02_parametres. On le complète, on ne le remplace pas.

La commande reste `flutter run -d chrome` et l’entrée reste `lib/main.dart`.

## Modifications à intégrer

1. Ajouter models/artisan.dart et data/demo_artisans.dart, fournis dans le code de référence de ce jalon.
2. Garder l’en-tête et le message. Sous eux, ajouter une Card décrivant artisansDemo.first.
3. Créer la méthode _carte(BuildContext context, Artisan artisan) pour regrouper la présentation.
4. Composer la carte avec Padding, Row, CircleAvatar, Expanded, Column, nom, métier et tarif.
5. Le thème reste dans app.dart. Tester une autre couleur puis un nom long.

## Fichiers concernés

- `lib/screens/catalogue_screen.dart` : faire évoluer ce fichier en conservant le reste.
- `lib/models/artisan.dart` : ajouter ce fichier.
- `lib/data/demo_artisans.dart` : ajouter ce fichier.

## Vérifier aussi ce qui fonctionnait déjà

- [ ] L’en-tête et le message sont toujours là.
- [ ] La première carte montre Gérard, Plomberie et son tarif fictif.
- [ ] Un nom long reste dans la largeur disponible.

## Code de référence après ce jalon

Essayer avant d’ouvrir la correction. Les fichiers ci-dessous montrent le résultat attendu pour comparer les blocs modifiés. Ils ne se collent pas tous dans main.dart.

<details>
<summary>Voir lib/screens/catalogue_screen.dart</summary>

```dart
import 'package:flutter/material.dart';

import '../configuration.dart';
import '../widgets/titre_section.dart';
import '../data/demo_artisans.dart';
import '../models/artisan.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({
    super.key,
    this.responsive = true,
    this.simulerErreur = false,
  });
  final bool responsive;
  final bool simulerErreur;

  Widget _carte(BuildContext context, Artisan artisan) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const CircleAvatar(child: Icon(Icons.handyman)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        artisan.nom,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(artisan.metier),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('${artisan.tarif} €/h - tarif fictif'),
          ],
        ),
      ),
    );
  }

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
              const Text('Des professionnels près de chez vous'),
              const SizedBox(height: 12),
              _carte(context, artisansDemo.first),
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
<summary>Voir lib/models/artisan.dart</summary>

```dart
// Un objet métier Dart : aucune dépendance à Flutter.
class Artisan {
  // Les paramètres nommés et required prolongent le CLI de lundi.
  const Artisan({
    required this.id,
    required this.nom,
    required this.metier,
    required this.tarif,
  });

  final int id;
  final String nom;
  final String metier;
  final int tarif;
}
```

</details>

<details>
<summary>Voir lib/data/demo_artisans.dart</summary>

```dart
import '../models/artisan.dart';

// Données fictives et constantes. Aucun appel réseau ni image distante.
const artisansDemo = <Artisan>[
  Artisan(id: 1, nom: 'Gérard', metier: 'Plomberie', tarif: 65),
  Artisan(id: 2, nom: 'Sophie', metier: 'Électricité', tarif: 80),
  Artisan(id: 3, nom: 'Pierre', metier: 'Carrelage', tarif: 95),
];
```

</details>
