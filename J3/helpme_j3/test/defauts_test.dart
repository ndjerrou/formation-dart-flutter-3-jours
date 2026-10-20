import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:helpme_j3/data/catalogue_repository.dart';
import 'package:helpme_j3/data/demandes_repository.dart';
import 'package:helpme_j3/models/artisan.dart';
import 'package:helpme_j3/models/demande.dart';
import 'package:helpme_j3/state/catalogue_bloc.dart';
import 'package:helpme_j3/screens/detail_screen.dart';
import 'package:helpme_j3/ui/carte_artisan.dart';
import 'package:helpme_j3/l10n/app_localizations.dart';
import 'package:helpme_j3/services/notifications.dart';

import '../recette_finale/support.dart';
import '../recette_finale/parcours_test.dart' as parcours;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const a = Artisan(
    id: 1,
    nom: 'Gérard',
    metier: 'Plomberie',
    tarif: 65,
    icone: 'plomberie',
    description: 'Test',
  );
  const client = Session(uid: 'client-demo', email: 'client@demo.local');
  testWidgets('Départ lançable sur écran large', (t) async {
    await parcours.demarrer(t, taille: const Size(1100, 900));
    expect(find.text('Gérard'), findsOneWidget);
    expect(t.takeException(), isNull);
    await t.pumpWidget(const SizedBox());
  });
  testWidgets('B01 : débordement de largeur attendu', (t) async {
    await t.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 300,
              child: CarteArtisan(
                artisan: a,
                favori: false,
                onFavori: () {},
                onOuvrir: () {},
              ),
            ),
          ),
        ),
      ),
    );
    expect(t.takeException(), isA<FlutterError>());
    await t.pumpWidget(const SizedBox());
  });
  testWidgets('B02 : recherche Sophie ouvre Gérard', (t) async {
    await parcours.demarrer(t, taille: const Size(1100, 900));
    await t.enterText(find.byKey(const ValueKey('recherche')), 'Sophie');
    await parcours.stabiliser(t);
    await t.ensureVisible(find.byKey(const ValueKey('ouvrir_2')));
    await parcours.stabiliser(t);
    await t.tap(find.byKey(const ValueKey('ouvrir_2')));
    await parcours.stabiliser(t);
    expect(find.text('Gérard'), findsOneWidget);
    await t.pumpWidget(const SizedBox());
  });
  test('B03 : ancien état modifié sans émission', () async {
    final s = await creerStore();
    final b = CatalogueBloc(CatalogueRepository(store: s));
    b.add(Rechercher('x'));
    await b.stream.firstWhere((e) => e.recherche == 'x');
    final ancien = b.state;
    var emissions = 0;
    final sub = b.stream.listen((_) => emissions++);
    b.add(BasculerFavori(1));
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(ancien.favoris, {1});
    expect(emissions, 0);
    await sub.cancel();
    await b.close();
    await s.fermer();
  });
  testWidgets('B04 : BLoC distinct dans la fiche', (t) async {
    await parcours.demarrer(t, taille: const Size(1100, 900));
    final initial = t
        .element(find.byKey(const ValueKey('recherche')))
        .read<CatalogueBloc>();
    await t.ensureVisible(find.byKey(const ValueKey('ouvrir_1')));
    await parcours.stabiliser(t);
    await t.tap(find.byKey(const ValueKey('ouvrir_1')));
    await parcours.stabiliser(t);
    final fiche = t.element(find.byType(DetailScreen)).read<CatalogueBloc>();
    expect(identical(initial, fiche), isFalse);
    await t.pumpWidget(const SizedBox());
  });
  test('B05 : JSON HTTP valide mal transformé', () async {
    final s = await creerStore();
    final c = MockClient(
      (_) async => http.Response(
        jsonEncode([a.toJson()]),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );
    final r = CatalogueRepository(
      store: s,
      url: 'https://catalogue.test',
      client: c,
    );
    await expectLater(r.charger(), throwsA(anything));
    await s.fermer();
    c.close();
  });
  test('B06 : chargement maintenu après erreur', () async {
    final s = await creerStore();
    final c = MockClient((_) async => http.Response('erreur', 503));
    final b = CatalogueBloc(
      CatalogueRepository(store: s, url: 'https://catalogue.test', client: c),
    );
    b.add(ChargerCatalogue());
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(b.state.statut, Chargement.attente);
    await b.close();
    await s.fermer();
    c.close();
  });
  test('B07 : favoris non sauvegardés', () async {
    final s = await creerStore();
    final b = CatalogueBloc(CatalogueRepository(store: s));
    b.add(BasculerFavori(1));
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(b.state.favoris, {1});
    expect(s.lireFavoris(), isEmpty);
    await b.close();
    await s.fermer();
  });
  test('B08 : deuxième demande écrase la première', () async {
    final s = await creerStore();
    final r = DemandesRepository(store: s);
    await r.creer(client, a, 'Première fuite', 'r1');
    await r.creer(client, a, 'Deuxième fuite', 'r2');
    expect((await s.lireDemandes()).length, 1);
    expect((await s.lireDemandes()).single.id, 'r2');
    await r.fermer();
    await s.fermer();
  });
  test('B09 : écoute terminée après une valeur', () async {
    final s = await creerStore();
    final r = DemandesRepository(store: s);
    final resultats = await r
        .observer(client)
        .toList()
        .timeout(const Duration(seconds: 2));
    expect(resultats.length, 1);
    await r.fermer();
    await s.fermer();
  });
  test('B10 : notification renvoie l’accueil', () {
    expect(cheminNotification({'demandeId': 'r1'}), '/');
  });
}
