# Ajouter une fiche au catalogue existant

Jalon **07_navigation** - fiches F12.

## Notre point de départ

Notre projet courant contient déjà le jalon 06_composants. On le complète, on ne le remplace pas.

La commande reste `flutter run -d chrome` et l’entrée reste `lib/main.dart`.

## Modifications à intégrer

1. Créer screens/detail_screen.dart. Recevoir l’Artisan dans son constructeur et afficher son nom, son métier et son tarif.
2. Ajouter Choisir cet artisan : pop renvoie un message. Le retour de l’AppBar ferme sans message.
3. Dans le catalogue, modifier seulement _ouvrir : push<String>, await, garde mounted et message nullable, puis SnackBar.
4. Garder la carte, ses callbacks, les favoris, la liste et l’en-tête.

## Fichiers concernés

- `lib/screens/catalogue_screen.dart` : faire évoluer ce fichier en conservant le reste.
- `lib/screens/detail_screen.dart` : ajouter ce fichier.

## Vérifier aussi ce qui fonctionnait déjà

- [ ] Chaque bouton ouvre la fiche du bon artisan.
- [ ] Choisir renvoie le message ; revenir en arrière peut renvoyer null.
- [ ] Un favori choisi avant l’ouverture est encore sélectionné au retour.
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
    return ListView.builder(
      itemCount: visibles.length,
      itemBuilder: (context, index) => _carte(context, visibles[index]),
    );
  }
}
```

</details>

<details>
<summary>Voir lib/screens/detail_screen.dart</summary>

```dart
import 'package:flutter/material.dart';

import '../models/artisan.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.artisan,
    this.simulerErreur = false,
  });
  final Artisan artisan;
  final bool simulerErreur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(artisan.nom)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              artisan.metier,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text('${artisan.tarif} €/h - tarif fictif'),
            const SizedBox(height: 12),
            OutlinedButton(
              key: const ValueKey('choisir'),
              onPressed: () =>
                  Navigator.of(context).pop('Artisan choisi : ${artisan.nom}'),
              child: const Text('Choisir cet artisan'),
            ),
          ],
        ),
      ),
    );
  }
}
```

</details>
