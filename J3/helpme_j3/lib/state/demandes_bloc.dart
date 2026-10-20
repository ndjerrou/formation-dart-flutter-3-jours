import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/demandes_repository.dart';
import '../models/demande.dart';
import '../models/artisan.dart';

sealed class DemandesEvent {}

class ObserverDemandes extends DemandesEvent {
  ObserverDemandes(this.session);
  final Session? session;
}

class DemandesRecues extends DemandesEvent {
  DemandesRecues(this.demandes);
  final List<Demande> demandes;
}

class DemandesErreur extends DemandesEvent {}

class EnvoyerDemande extends DemandesEvent {
  EnvoyerDemande(this.session, this.artisan, this.motif, this.id);
  final Session session;
  final Artisan artisan;
  final String motif, id;
}

class TraiterDemande extends DemandesEvent {
  TraiterDemande(this.session, this.demande, this.statut);
  final Session session;
  final Demande demande;
  final StatutDemande statut;
}

class DemandesState {
  DemandesState({
    List<Demande> demandes = const [],
    this.attente = false,
    this.erreur = false,
    this.envoyee = 0,
  }) : demandes = List.unmodifiable(demandes);
  final List<Demande> demandes;
  final bool attente, erreur;
  final int envoyee;
}

class DemandesBloc extends Bloc<DemandesEvent, DemandesState> {
  DemandesBloc(this.repository) : super(DemandesState()) {
    on<ObserverDemandes>((event, emit) async {
      await _abonnement?.cancel();
      emit(DemandesState());
      if (event.session != null) {
        _abonnement = repository
            .observer(event.session!)
            .listen(
              (d) => add(DemandesRecues(d)),
              onError: (Object e) => add(DemandesErreur()),
            );
      }
    });
    on<DemandesRecues>(
      (event, emit) => emit(
        DemandesState(
          demandes: event.demandes,
          envoyee: state.envoyee,
          attente: state.attente,
        ),
      ),
    );
    on<DemandesErreur>(
      (event, emit) => emit(
        DemandesState(
          demandes: state.demandes,
          erreur: true,
          envoyee: state.envoyee,
        ),
      ),
    );
    on<EnvoyerDemande>((event, emit) async {
      if (state.attente) return;
      emit(
        DemandesState(
          demandes: state.demandes,
          attente: true,
          envoyee: state.envoyee,
        ),
      );
      try {
        await repository.creer(
          event.session,
          event.artisan,
          event.motif,
          event.id,
        );
        emit(
          DemandesState(demandes: state.demandes, envoyee: state.envoyee + 1),
        );
      } catch (_) {
        add(DemandesErreur());
      }
    });
    on<TraiterDemande>((event, emit) async {
      if (state.attente) return;
      emit(
        DemandesState(
          demandes: state.demandes,
          attente: true,
          envoyee: state.envoyee,
        ),
      );
      try {
        await repository.changerStatut(
          event.session,
          event.demande,
          event.statut,
        );
        emit(DemandesState(demandes: state.demandes, envoyee: state.envoyee));
      } catch (_) {
        add(DemandesErreur());
      }
    });
  }
  final DemandesRepository repository;
  StreamSubscription<List<Demande>>? _abonnement;
  @override
  Future<void> close() async {
    await _abonnement?.cancel();
    return super.close();
  }
}
