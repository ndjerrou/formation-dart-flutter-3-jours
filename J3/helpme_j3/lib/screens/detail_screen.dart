import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_localizations.dart';
import '../state/catalogue_bloc.dart';
import '../state/session_cubit.dart';
import '../state/demandes_bloc.dart';
import '../ui/commun.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id});
  final int id;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _form = GlobalKey<FormState>();
  final _motif = TextEditingController();
  String? _idDemande;
  @override
  void dispose() {
    _motif.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: const ValueKey('retour'),
          tooltip: l.backCatalogue,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        title: Text(l.open),
      ),
      body: BlocBuilder<CatalogueBloc, CatalogueState>(
        builder: (context, cat) {
          if (cat.statut == Chargement.initial ||
              cat.statut == Chargement.attente) {
            return const Center(child: CircularProgressIndicator());
          }
          if (cat.statut == Chargement.erreur) {
            return PanneauErreur(
              texte: l.loadFailed,
              reessayer: () =>
                  context.read<CatalogueBloc>().add(ChargerCatalogue()),
            );
          }
          final artisans = cat.artisans.where((a) => a.id == widget.id);
          if (artisans.isEmpty) return PanneauErreur(texte: l.notAvailable);
          final artisan = artisans.first;
          return BlocConsumer<DemandesBloc, DemandesState>(
            listenWhen: (a, b) => a.envoyee != b.envoyee,
            listener: (context, etat) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(l.requestSent)));
              context.go('/demandes');
            },
            builder: (context, etat) {
              final session = context.watch<SessionCubit>().state.session;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 680),
                    child: Form(
                      key: _form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(28),
                                decoration: BoxDecoration(
                                  color: const Color(0xffe4efeb),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(iconeMetier(artisan.icone), size: 48),
                                    const SizedBox(height: 12),
                                    Text(
                                      artisan.nom,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(artisan.metier),
                                  ],
                                ),
                              ),
                              IconButton(
                                key: const ValueKey('favori_detail'),
                                tooltip: l.favorite,
                                onPressed: () => context
                                    .read<CatalogueBloc>()
                                    .add(BasculerFavori(artisan.id)),
                                icon: Icon(
                                  cat.favoris.contains(artisan.id)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(artisan.description),
                          Text('${artisan.tarif} € ${l.hour}'),
                          const SizedBox(height: 24),
                          if (session == null)
                            FilledButton(
                              onPressed: () => context.push('/connexion'),
                              child: Text(l.signInNeeded),
                            )
                          else if (!session.prestataire) ...[
                            TextFormField(
                              key: const ValueKey('motif'),
                              controller: _motif,
                              enabled: !etat.attente,
                              minLines: 3,
                              maxLines: 5,
                              maxLength: 1000,
                              decoration: InputDecoration(
                                labelText: l.motif,
                                border: const OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.trim().length < 5
                                  ? l.motifError
                                  : null,
                            ),
                            if (etat.erreur)
                              Text(
                                l.requestFailed,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            const SizedBox(height: 12),
                            FilledButton.icon(
                              key: const ValueKey('envoyer'),
                              onPressed: etat.attente
                                  ? null
                                  : () {
                                      if (_form.currentState?.validate() !=
                                          true) {
                                        return;
                                      }
                                      _idDemande ??= context
                                          .read<DemandesBloc>()
                                          .repository
                                          .nouvelId();
                                      context.read<DemandesBloc>().add(
                                        EnvoyerDemande(
                                          session,
                                          artisan,
                                          _motif.text,
                                          _idDemande!,
                                        ),
                                      );
                                    },
                              icon: etat.attente
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Icons.send),
                              label: Text(etat.attente ? l.sending : l.send),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
