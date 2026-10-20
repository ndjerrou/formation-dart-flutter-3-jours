# Adapter notre application déjà fonctionnelle

Jalon **10_responsive** - fiches F17, F18, F19.

## Notre point de départ

Notre projet courant contient déjà le jalon 09_asynchrone. On le complète, on ne le remplace pas.

La commande reste `flutter run -d chrome` et l’entrée reste `lib/main.dart`.

## Modifications à intégrer

1. Conserver _carte, _basculerFavori, _ouvrir et toute la fiche.
2. Faire évoluer seulement _liste : LayoutBuilder choisit une ou deux colonnes à partir de la largeur disponible.
3. Utiliser la même liste visible et la même source de favoris pour les deux présentations.
4. Tester un texte agrandi, les tooltips et le défilement de la fiche. Eviter une hauteur fixe pour les cartes.
5. Lire le test du PDF, reproduire son geste et annoncer une preuve précise.

## Fichiers concernés

- `lib/screens/catalogue_screen.dart` : faire évoluer ce fichier en conservant le reste.

## Vérifier aussi ce qui fonctionnait déjà

- [ ] Les favoris et la fiche fonctionnent à petite et grande largeur.
- [ ] Changer la largeur ne réinitialise pas les favoris.
- [ ] Les textes agrandis et les erreurs restent accessibles.
- [ ] Le message personnel et les données sont toujours présents.
- [ ] Sélectionner puis désélectionner un favori fonctionne encore.
- [ ] Ouvrir une fiche et revenir ne perd pas les favoris.
- [ ] Le formulaire refuse un motif court ; la panne garde la saisie.

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
import 'detail_screen.dart';

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

  Future<void> _ouvrir(Artisan artisan) async {
    final message = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) =>
            DetailScreen(artisan: artisan, simulerErreur: widget.simulerErreur),
      ),
    );
    if (!mounted || message == null) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
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
    return LayoutBuilder(
      builder: (context, contraintes) {
        final deuxColonnes = widget.responsive && contraintes.maxWidth >= 700;
        if (!deuxColonnes) {
          return ListView.builder(
            itemCount: visibles.length,
            itemBuilder: (context, index) => _carte(context, visibles[index]),
          );
        }
        return ListView.builder(
          itemCount: (visibles.length / 2).ceil(),
          itemBuilder: (context, ligne) {
            final index = ligne * 2;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _carte(context, visibles[index])),
                const SizedBox(width: 12),
                Expanded(
                  child: index + 1 < visibles.length
                      ? _carte(context, visibles[index + 1])
                      : const SizedBox.shrink(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
```

</details>
