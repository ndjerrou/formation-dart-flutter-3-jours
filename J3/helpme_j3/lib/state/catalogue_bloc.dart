import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/catalogue_repository.dart';
import '../models/artisan.dart';

sealed class CatalogueEvent {}

class ChargerCatalogue extends CatalogueEvent {}

class BasculerFavori extends CatalogueEvent {
  BasculerFavori(this.id);
  final int id;
}

class Rechercher extends CatalogueEvent {
  Rechercher(this.texte);
  final String texte;
}

class FiltrerFavoris extends CatalogueEvent {
  FiltrerFavoris(this.actif);
  final bool actif;
}

enum Chargement { initial, attente, pret, erreur }

class CatalogueState {
  CatalogueState({
    this.statut = Chargement.initial,
    List<Artisan> artisans = const [],
    Set<int> favoris = const {},
    this.recherche = '',
    this.seulementFavoris = false,
    this.source = 'assets',
  }) : artisans = List.unmodifiable(artisans),
       favoris = Set.unmodifiable(favoris);
  final Chargement statut;
  final List<Artisan> artisans;
  final Set<int> favoris;
  final String recherche, source;
  final bool seulementFavoris;
  List<Artisan> get visibles => artisans
      .where(
        (a) =>
            '${a.nom} ${a.metier}'.toLowerCase().contains(
              recherche.trim().toLowerCase(),
            ) &&
            (!seulementFavoris || favoris.contains(a.id)),
      )
      .toList();
  CatalogueState copyWith({
    Chargement? statut,
    List<Artisan>? artisans,
    Set<int>? favoris,
    String? recherche,
    bool? seulementFavoris,
    String? source,
  }) => CatalogueState(
    statut: statut ?? this.statut,
    artisans: artisans ?? this.artisans,
    favoris: favoris ?? this.favoris,
    recherche: recherche ?? this.recherche,
    seulementFavoris: seulementFavoris ?? this.seulementFavoris,
    source: source ?? this.source,
  );
}

class CatalogueBloc extends Bloc<CatalogueEvent, CatalogueState> {
  final CatalogueRepository repository;
  CatalogueBloc(this.repository)
    : super(CatalogueState(favoris: repository.store.lireFavoris())) {
    on<ChargerCatalogue>((event, emit) async {
      emit(state.copyWith(statut: Chargement.attente));
      try {
        final resultat = await repository.charger();
        emit(
          state.copyWith(
            statut: Chargement.pret,
            artisans: resultat.artisans,
            source: resultat.source,
          ),
        );
      } catch (_) {
        // Le chargement sera retenté plus tard.
      }
    });
    on<BasculerFavori>((event, emit) async {
      // Copier avant de modifier : le précédent état reste intact.
      final ids = Set<int>.of(state.favoris);
      ids.contains(event.id) ? ids.remove(event.id) : ids.add(event.id);
      try {
        // Favoris conservés dans l’état courant.
        emit(state.copyWith(favoris: ids));
      } catch (_) {
        emit(state.copyWith(statut: Chargement.erreur));
      }
    }, transformer: (events, mapper) => events.asyncExpand(mapper));
    on<Rechercher>(
      (event, emit) => emit(state.copyWith(recherche: event.texte)),
    );
    on<FiltrerFavoris>(
      (event, emit) => emit(state.copyWith(seulementFavoris: event.actif)),
    );
  }
}
