import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../state/demandes_bloc.dart';
import '../state/session_cubit.dart';
import '../models/demande.dart';
import '../ui/commun.dart';

class DemandesScreen extends StatelessWidget {
  const DemandesScreen({super.key, this.id});
  final String? id;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final session = context.watch<SessionCubit>().state.session;
    if (session == null) {
      return Center(
        child: FilledButton(
          onPressed: () => context.push('/connexion'),
          child: Text(l.signInNeeded),
        ),
      );
    }
    return BlocBuilder<DemandesBloc, DemandesState>(
      builder: (context, etat) {
        if (etat.erreur) {
          return PanneauErreur(
            texte: l.requestFailed,
            reessayer: () =>
                context.read<DemandesBloc>().add(ObserverDemandes(session)),
          );
        }
        final demandes =
            etat.demandes.where((d) => id == null || d.id == id).toList()
              ..sort((a, b) => b.date.compareTo(a.date));
        if (demandes.isEmpty) {
          return PanneauErreur(
            texte: id == null ? l.noRequests : l.accessDenied,
          );
        }
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              session.prestataire ? l.providerInbox : l.requests,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            for (final d in demandes)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        d.artisanNom,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        DateFormat.yMd(
                          Localizations.localeOf(context).languageCode,
                        ).add_Hm().format(d.date.toLocal()),
                      ),
                      const SizedBox(height: 8),
                      Text(d.motif),
                      const SizedBox(height: 12),
                      Chip(
                        avatar: Icon(
                          d.statut == StatutDemande.accepted
                              ? Icons.check_circle
                              : Icons.schedule,
                          size: 18,
                        ),
                        label: Text(
                          d.synchronisee
                              ? libelleStatut(l, d.statut)
                              : l.syncPending,
                        ),
                      ),
                      if (session.prestataire &&
                          d.statut == StatutDemande.pending)
                        Wrap(
                          spacing: 12,
                          children: [
                            FilledButton(
                              key: ValueKey('accepter_${d.id}'),
                              onPressed: etat.attente
                                  ? null
                                  : () => context.read<DemandesBloc>().add(
                                      TraiterDemande(
                                        session,
                                        d,
                                        StatutDemande.accepted,
                                      ),
                                    ),
                              child: Text(l.accept),
                            ),
                            OutlinedButton(
                              onPressed: etat.attente
                                  ? null
                                  : () => context.read<DemandesBloc>().add(
                                      TraiterDemande(
                                        session,
                                        d,
                                        StatutDemande.refused,
                                      ),
                                    ),
                              child: Text(l.refuse),
                            ),
                          ],
                        )
                      else if (id == null)
                        TextButton(
                          onPressed: () => context.push('/demandes/${d.id}'),
                          child: Text(l.requestDetail),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
