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
