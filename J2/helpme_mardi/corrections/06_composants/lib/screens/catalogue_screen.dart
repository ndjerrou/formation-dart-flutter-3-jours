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
