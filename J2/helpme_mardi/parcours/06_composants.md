# Extraire la carte, garder les favoris

Jalon **06_composants** - fiches F11.

## Notre point de départ

Notre projet courant contient déjà le jalon 05_favoris. On le complète, on ne le remplace pas.

La commande reste `flutter run -d chrome` et l’entrée reste `lib/main.dart`.

## Modifications à intégrer

1. Créer widgets/carte_artisan.dart en y déplaçant le code de présentation de _carte.
2. La classe CarteArtisan reçoit artisan, favori, onFavori et onOuvrir. Elle ne possède pas sa propre liste de favoris.
3. Dans le catalogue, garder _favoris et _basculerFavori EXACTEMENT comme ils fonctionnent déjà.
4. Remplacer le corps de _carte par CarteArtisan et transmettre les callbacks.
5. Ajouter un bouton Voir la fiche à la carte. Pour ce jalon, _ouvrir affiche simplement une SnackBar de sélection.

## Fichiers concernés

- `lib/screens/catalogue_screen.dart` : faire évoluer ce fichier en conservant le reste.
- `lib/widgets/carte_artisan.dart` : ajouter ce fichier.

## Vérifier aussi ce qui fonctionnait déjà

- [ ] Les favoris fonctionnent toujours, sans réécrire leur logique.
- [ ] Deux cartes partagent un composant mais reçoivent des artisans différents.
- [ ] Voir la fiche affiche le nom du bon artisan dans une SnackBar.
- [ ] Le message personnel et les données sont toujours présents.
- [ ] Sélectionner puis désélectionner un favori fonctionne encore.

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
import '../widgets/carte_artisan.dart';

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

  void _ouvrir(Artisan artisan) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Sélection : ${artisan.nom}')));
  }

  Widget _carte(BuildContext context, Artisan artisan) {
    return CarteArtisan(
      key: ValueKey(artisan.id),
      artisan: artisan,
      favori: _favoris.contains(artisan.id),
      onFavori: () => _basculerFavori(artisan.id),
      onOuvrir: () => _ouvrir(artisan),
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

<details>
<summary>Voir lib/widgets/carte_artisan.dart</summary>

```dart
import 'package:flutter/material.dart';

import '../models/artisan.dart';

// Ce composant reçoit son affichage et ses actions. Il ne possède pas les favoris.
class CarteArtisan extends StatelessWidget {
  const CarteArtisan({
    super.key,
    required this.artisan,
    required this.favori,
    required this.onFavori,
    required this.onOuvrir,
  });

  final Artisan artisan;
  final bool favori;
  // VoidCallback est un alias de void Function() : une action à appeler plus tard.
  final VoidCallback onFavori;
  final VoidCallback onOuvrir;

  @override
  Widget build(BuildContext context) {
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
                // Expanded donne au texte la largeur restante dans cette Row.
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
                  tooltip: favori
                      ? 'Retirer ${artisan.nom} des favoris'
                      : 'Ajouter ${artisan.nom} aux favoris',
                  onPressed: onFavori,
                  icon: Icon(favori ? Icons.favorite : Icons.favorite_border),
                  color: favori ? Colors.red.shade700 : null,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('${artisan.tarif} €/h - tarif fictif'),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              key: ValueKey('ouvrir_${artisan.id}'),
              onPressed: onOuvrir,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Voir la fiche'),
            ),
          ],
        ),
      ),
    );
  }
}
```

</details>
