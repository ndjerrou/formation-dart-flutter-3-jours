# Rendre notre catalogue interactif

Jalon **05_favoris** - fiches F09, F10.

## Notre point de départ

Notre projet courant contient déjà le jalon 04_catalogue. On le complète, on ne le remplace pas.

La commande reste `flutter run -d chrome` et l’entrée reste `lib/main.dart`.

## Modifications à intégrer

1. Transformer CatalogueScreen en StatefulWidget, créer _CatalogueScreenState et y déplacer build, _carte et _liste sans les réécrire.
2. Dans le State, créer final List<int> _favoris = [].
3. Ecrire _basculerFavori : dans setState, retirer un ID déjà présent ou ajouter un ID absent.
4. Ajouter dans la Row de la carte un IconButton dont l’icône dépend de contains(artisan.id).
5. Ajouter le compteur de favoris dans l’en-tête. La liste d’artisans continue à fonctionner.
6. Après la transformation Stateless vers Stateful, utiliser R. Tester ensuite r et comparer la conservation de l’état.

## Fichiers concernés

- `lib/screens/catalogue_screen.dart` : faire évoluer ce fichier en conservant le reste.

## Vérifier aussi ce qui fonctionnait déjà

- [ ] Deux clics sur le même cœur donnent un favori puis zéro.
- [ ] Le compteur, les données, la carte et le message restent cohérents.
- [ ] Le champ _favoris reste final malgré add/remove.
- [ ] Le message personnel et les données sont toujours présents.

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

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({
    super.key,
    this.responsive = true,
    this.simulerErreur = false,
  });
  final bool responsive;
  final bool simulerErreur;

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  // Les mêmes IDs et la même méthode sont conservés dans les étapes suivantes.
  final List<int> _favoris = [];

  void _basculerFavori(int id) {
    setState(() {
      if (_favoris.contains(id)) {
        _favoris.remove(id);
      } else {
        _favoris.add(id);
      }
    });
  }

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
                IconButton(
                  key: ValueKey('favori_${artisan.id}'),
                  tooltip: _favoris.contains(artisan.id)
                      ? 'Retirer ${artisan.nom} des favoris'
                      : 'Ajouter ${artisan.nom} aux favoris',
                  onPressed: () => _basculerFavori(artisan.id),
                  icon: Icon(
                    _favoris.contains(artisan.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
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
    final visibles = artisansDemo;
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
              Wrap(
                spacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('${_favoris.length} favori(s)'),
                  Text('${visibles.length} artisan(s)'),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(child: _liste(context, visibles)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _liste(BuildContext context, List<Artisan> visibles) {
    return ListView.builder(
      itemCount: visibles.length,
      itemBuilder: (context, index) => _carte(context, visibles[index]),
    );
  }
}
```

</details>
