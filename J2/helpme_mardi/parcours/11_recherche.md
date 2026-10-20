# Ajouter la recherche, garder tout le parcours

Jalon **11_recherche** - fiches F20, F21.

## Notre point de départ

Notre projet courant contient déjà le jalon 10_responsive. On le complète, on ne le remplace pas.

La commande reste `flutter run -d chrome` et l’entrée reste `lib/main.dart`.

## Modifications à intégrer

1. Dans le catalogue existant, ajouter _recherche et _seulementFavoris au State.
2. Ajouter un TextField et un FilterChip reliés à setState.
3. Ecrire le getter _visibles : combiner nom ou métier avec le filtre de favoris, puis toList.
4. Dans build, remplacer la référence directe à artisansDemo par _visibles. Ajouter le message de résultat vide.
5. Ne pas réécrire _basculerFavori, _ouvrir, la carte ou le formulaire : ils fonctionnent déjà.
6. Effacer les filtres pour retrouver toutes les données. Réaliser le parcours complet en binôme.

## Fichiers concernés

- `lib/screens/catalogue_screen.dart` : faire évoluer ce fichier en conservant le reste.

## Vérifier aussi ce qui fonctionnait déjà

- [ ] Recherche seule, favoris seuls et combinaison donnent la bonne personne.
- [ ] Effacer la recherche retrouve toutes les données sans perte.
- [ ] Le compteur, la navigation, la validation, l’attente, l’erreur et le responsive fonctionnent encore.
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

  String _recherche = '';
  bool _seulementFavoris = false;

  List<Artisan> get _visibles {
    final texte = _recherche.trim().toLowerCase();
    return artisansDemo.where((artisan) {
      final correspond = artisan.nom.toLowerCase().contains(texte) ||
          artisan.metier.toLowerCase().contains(texte);
      final favoriAccepte = !_seulementFavoris || _favoris.contains(artisan.id);
      return correspond && favoriAccepte;
    }).toList();
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
    final visibles = _visibles;
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
              TextField(
                key: const ValueKey('recherche'),
                decoration: const InputDecoration(
                  labelText: 'Rechercher un nom ou un métier',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (texte) => setState(() => _recherche = texte),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  FilterChip(
                    label: const Text('Favoris uniquement'),
                    selected: _seulementFavoris,
                    onSelected: (valeur) =>
                        setState(() => _seulementFavoris = valeur),
                  ),
                  Text('${_favoris.length} favori(s)'),
                  Text('${visibles.length} artisan(s)'),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: visibles.isEmpty
                    ? const Center(child: Text('Aucun artisan ne correspond.'))
                    : _liste(context, visibles),
              ),
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
