import 'package:flutter/material.dart';

import '../models/artisan.dart';
import '../l10n/app_localizations.dart';
import 'commun.dart';

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
  final VoidCallback onFavori, onOuvrir;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xffe4efeb),
                  child: Icon(
                    iconeMetier(artisan.icone),
                    color: const Color(0xff21624f),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 220,
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
                  tooltip: l.favorite,
                  onPressed: onFavori,
                  icon: Icon(favori ? Icons.favorite : Icons.favorite_border),
                  color: favori ? Colors.red.shade700 : null,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '${artisan.tarif} € ${l.hour}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              artisan.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                key: ValueKey('ouvrir_${artisan.id}'),
                onPressed: onOuvrir,
                icon: const Icon(Icons.arrow_forward),
                label: Text(l.open),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
