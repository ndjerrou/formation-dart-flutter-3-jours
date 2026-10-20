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
