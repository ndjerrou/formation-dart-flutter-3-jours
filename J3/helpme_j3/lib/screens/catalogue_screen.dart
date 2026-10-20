import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_localizations.dart';
import '../state/catalogue_bloc.dart';
import '../ui/carte_artisan.dart';
import '../ui/commun.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return BlocBuilder<CatalogueBloc, CatalogueState>(
      builder: (context, etat) {
        if (etat.statut == Chargement.attente ||
            etat.statut == Chargement.initial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (etat.statut == Chargement.erreur) {
          return PanneauErreur(
            texte: l.loadFailed,
            reessayer: () =>
                context.read<CatalogueBloc>().add(ChargerCatalogue()),
          );
        }
        final visibles = etat.visibles;
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xff163d32),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.heroTitle,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l.heroSubtitle,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  if (MediaQuery.sizeOf(context).width > 540) ...[
                    const SizedBox(width: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        'assets/atelier.png',
                        width: 130,
                        height: 110,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              key: const ValueKey('recherche'),
              decoration: InputDecoration(
                labelText: l.search,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: (t) =>
                  context.read<CatalogueBloc>().add(Rechercher(t)),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                FilterChip(
                  label: Text(l.favoritesOnly),
                  selected: etat.seulementFavoris,
                  onSelected: (v) =>
                      context.read<CatalogueBloc>().add(FiltrerFavoris(v)),
                ),
                Text('${etat.favoris.length} ${l.favoriteCount}'),
                Text('${visibles.length} ${l.resultCount}'),
                IconButton(
                  tooltip: l.refresh,
                  onPressed: () =>
                      context.read<CatalogueBloc>().add(ChargerCatalogue()),
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            Text(switch (etat.source) {
              'http' => l.sourceHttp,
              'cache' => l.sourceCache,
              _ => l.sourceAssets,
            }, style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 10),
            if (visibles.isEmpty)
              Padding(padding: const EdgeInsets.all(36), child: Text(l.empty)),
            LayoutBuilder(
              builder: (context, c) {
                Widget carte(int i) {
                  final a = visibles[i];
                  return CarteArtisan(
                    key: ValueKey('carte_${a.id}'),
                    artisan: a,
                    favori: etat.favoris.contains(a.id),
                    onFavori: () =>
                        context.read<CatalogueBloc>().add(BasculerFavori(a.id)),
                    onOuvrir: () => context.push('/artisans/${i + 1}'),
                  );
                }

                if (c.maxWidth < 760 ||
                    MediaQuery.textScalerOf(context).scale(1) >= 1.5) {
                  return Column(
                    children: [
                      for (var i = 0; i < visibles.length; i++) carte(i),
                    ],
                  );
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 258,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: visibles.length,
                  itemBuilder: (context, i) => carte(i),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
