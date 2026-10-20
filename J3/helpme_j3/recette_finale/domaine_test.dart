import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:helpme_j3/data/catalogue_repository.dart';
import 'package:helpme_j3/data/demandes_repository.dart';
import 'package:helpme_j3/models/artisan.dart';
import 'package:helpme_j3/models/demande.dart';
import 'package:helpme_j3/state/catalogue_bloc.dart';
import 'package:helpme_j3/services/notifications.dart';

import 'support.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const artisan = Artisan(
    id: 1,
    nom: 'Gérard',
    metier: 'Plomberie',
    tarif: 65,
    icone: 'plomberie',
    description: 'Test',
  );
  const client = Session(uid: 'client-demo', email: 'client@demo.local');
  const provider = Session(
    uid: 'prestataire-demo',
    email: 'gerard@demo.local',
    artisanId: 1,
  );
  test('JSON : aller-retour et type invalide', () {
    expect(Artisan.fromJson(artisan.toJson()).nom, 'Gérard');
    expect(
      () => Artisan.fromJson({...artisan.toJson(), 'tarif': '65'}),
      throwsA(anything),
    );
  });
  test(
    'Notifications : URL correcte, données absentes et injection refusée',
    () {
      expect(cheminNotification({'demandeId': 'abc_123'}), '/demandes/abc_123');
      expect(cheminNotification({}), isNull);
      expect(cheminNotification({'demandeId': '../../reglages'}), isNull);
    },
  );
  test('Favoris : ajout, retrait et ancien état intact', () async {
    final s = await creerStore();
    final repo = CatalogueRepository(store: s);
    final bloc = CatalogueBloc(repo);
    addTearDown(() async {
      await bloc.close();
      await s.fermer();
      repo.client.close();
    });
    final avant = bloc.state;
    bloc.add(BasculerFavori(1));
    await bloc.stream.firstWhere((e) => e.favoris.contains(1));
    expect(avant.favoris, isEmpty);
    expect(s.lireFavoris(), {1});
    bloc.add(BasculerFavori(1));
    await bloc.stream.firstWhere((e) => e.favoris.isEmpty);
    expect(s.lireFavoris(), isEmpty);
  });
  test('Favoris : restauration des préférences', () async {
    final s = await creerStore(
      preferences: {
        'favoris': <String>['1', '3'],
      },
    );
    final b = CatalogueBloc(CatalogueRepository(store: s));
    expect(b.state.favoris, {1, 3});
    await b.close();
    await s.fermer();
  });
  test('HTTP : succès UTF-8, cache, reprise hors ligne', () async {
    final s = await creerStore();
    var panne = false;
    final c = MockClient((_) async {
      if (panne) throw Exception('hors ligne');
      return http.Response.bytes(
        utf8.encode(jsonEncode([artisan.toJson()])),
        200,
      );
    });
    final repo = CatalogueRepository(
      store: s,
      url: 'https://catalogue.test',
      client: c,
    );
    expect((await repo.charger()).artisans.first.nom, 'Gérard');
    panne = true;
    expect((await repo.charger()).source, 'cache');
    await s.fermer();
    c.close();
  });
  test('HTTP : erreur sans cache puis nouvelle tentative', () async {
    final s = await creerStore();
    var erreur = true;
    final c = MockClient(
      (_) async => http.Response(
        erreur ? 'indisponible' : jsonEncode([artisan.toJson()]),
        erreur ? 503 : 200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );
    final b = CatalogueBloc(
      CatalogueRepository(store: s, url: 'https://catalogue.test', client: c),
    );
    b.add(ChargerCatalogue());
    await b.stream.firstWhere((e) => e.statut == Chargement.erreur);
    erreur = false;
    b.add(ChargerCatalogue());
    await b.stream.firstWhere((e) => e.statut == Chargement.pret);
    expect(b.state.artisans.length, 1);
    await b.close();
    await s.fermer();
    c.close();
  });
  test('HTTP : JSON invalide sans cache est une erreur', () async {
    final s = await creerStore();
    final c = MockClient((_) async => http.Response('{"wrong":true}', 200));
    final r = CatalogueRepository(
      store: s,
      url: 'https://catalogue.test',
      client: c,
    );
    await expectLater(r.charger(), throwsFormatException);
    await s.fermer();
    c.close();
  });
  test(
    'Demandes : deux créations distinctes et visibilité par compte',
    () async {
      final s = await creerStore();
      final r = DemandesRepository(store: s);
      await r.creer(client, artisan, 'Fuite cuisine', 'req1');
      await r.creer(client, artisan, 'Fuite salle de bain', 'req2');
      expect((await s.lireDemandes()).length, 2);
      expect((await r.observer(client).first).length, 2);
      expect(
        (await r.observer(const Session(uid: 'autre', email: 'autre')).first),
        isEmpty,
      );
      await r.fermer();
      await s.fermer();
    },
  );
  test(
    'Demandes : acceptation, refus final et droits du prestataire',
    () async {
      final s = await creerStore();
      final r = DemandesRepository(store: s);
      await r.creer(client, artisan, 'Fuite cuisine', 'req1');
      final d = (await s.lireDemandes()).single;
      await expectLater(
        r.changerStatut(client, d, StatutDemande.accepted),
        throwsStateError,
      );
      await expectLater(
        r.changerStatut(
          const Session(uid: 'autre', email: 'x', artisanId: 2),
          d,
          StatutDemande.accepted,
        ),
        throwsStateError,
      );
      await r.changerStatut(provider, d, StatutDemande.accepted);
      await expectLater(
        r.changerStatut(provider, d, StatutDemande.refused),
        throwsStateError,
      );
      expect((await s.lireDemandes()).single.statut, StatutDemande.accepted);
      await r.fermer();
      await s.fermer();
    },
  );
  test(
    'Demandes : deux traitements concurrents ne peuvent réussir ensemble',
    () async {
      final s = await creerStore();
      final r = DemandesRepository(store: s);
      await r.creer(client, artisan, 'Fuite cuisine', 'req1');
      final d = (await s.lireDemandes()).single;
      final resultats = await Future.wait([
        r
            .changerStatut(provider, d, StatutDemande.accepted)
            .then((_) => true)
            .catchError((Object _) => false),
        r
            .changerStatut(provider, d, StatutDemande.refused)
            .then((_) => true)
            .catchError((Object _) => false),
      ]);
      expect(resultats.where((r) => r).length, 1);
      await r.fermer();
      await s.fermer();
    },
  );
  test(
    'Demandes : motif invalide et prestataire refusés à la création',
    () async {
      final s = await creerStore();
      final r = DemandesRepository(store: s);
      await expectLater(r.creer(client, artisan, 'ab', 'x'), throwsStateError);
      await expectLater(
        r.creer(provider, artisan, 'Fuite cuisine', 'x'),
        throwsStateError,
      );
      await r.fermer();
      await s.fermer();
    },
  );
  test('Langue : préférence sauvegardée', () async {
    final s = await creerStore();
    await s.sauverLangue('en');
    expect(s.langue, 'en');
    await s.fermer();
  });
}
