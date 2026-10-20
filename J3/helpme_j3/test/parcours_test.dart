import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helpme_j3/app.dart';
import 'package:helpme_j3/data/catalogue_repository.dart';
import 'package:helpme_j3/data/demandes_repository.dart';
import 'package:helpme_j3/data/session_repository.dart';
import 'package:helpme_j3/state/catalogue_bloc.dart';
import 'package:helpme_j3/state/demandes_bloc.dart';
import 'package:helpme_j3/state/session_cubit.dart';
import 'package:helpme_j3/state/langue_cubit.dart';
import 'package:helpme_j3/services/notifications.dart';

import 'support.dart';
import 'package:helpme_j3/screens/catalogue_screen.dart';

class CatalogueUi extends CatalogueRepository {
  CatalogueUi({required super.store});
  @override Future<CatalogueResultat> charger()async=>CatalogueResultat(
    decoder(File('assets/catalogue.json').readAsStringSync()),'assets');
}
Future<void> stabiliser(WidgetTester t) async {
  await t.runAsync(() async {
    await Future<void>.delayed(const Duration(milliseconds: 30));
  });
  await t.pumpAndSettle();
}

Future<SessionCubit> demarrer(
  WidgetTester t, {
  String chemin = '/',
  Size taille = const Size(390, 844),
  double echelle = 1,
}) async {
  t.platformDispatcher.textScaleFactorTestValue=echelle;
  addTearDown(t.platformDispatcher.clearTextScaleFactorTestValue);
  await t.binding.setSurfaceSize(taille);
  addTearDown(() => t.binding.setSurfaceSize(null));
  final setup = (await t.runAsync(() async {
    final store = await creerStore();
    final repo = CatalogueUi(store:store);
    final cat = CatalogueBloc(repo)..add(ChargerCatalogue());
    await cat.stream.firstWhere((e) => e.statut == Chargement.pret);
    return (store, repo, cat);
  }))!;
  final (store, repo, cat) = setup;
  final session = SessionCubit(SessionRepository());
  final demandes = DemandesRepository(store: store);
  final db = DemandesBloc(demandes);
  final langue = LangueCubit(store);
  final notifications = Notifications();
  addTearDown(() async {
    await cat.close();
    await db.close();
    await session.close();
    await langue.close();
    await demandes.fermer();
    await notifications.fermer();
    repo.client.close();
    await store.fermer();
  });
  await t.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: cat),
        BlocProvider.value(value: db),
        BlocProvider.value(value: session),
        BlocProvider.value(value: langue),
      ],
      child: MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(echelle)),
        child: HelpMeApp(notifications: notifications, cheminInitial: chemin),
      ),
    ),
  );
  await stabiliser(t);
  return session;
}

void main() {
  testWidgets('Catalogue mobile : aucun débordement', (t) async {
    await demarrer(t);
    expect(find.text('Gérard'), findsOneWidget);
    expect(t.takeException(), isNull);
    await t.pumpWidget(const SizedBox());
  });
  testWidgets('Catalogue 320 : texte agrandi x2', (t)async{
    await demarrer(t,taille:const Size(320,900),echelle:2);
    final e=t.element(find.byType(CatalogueScreen));
    expect(MediaQuery.textScalerOf(e).scale(10),20);
    expect(t.takeException(),isNull);await t.pumpWidget(const SizedBox());
  });
  testWidgets('Catalogue tablette : grille', (t) async {
    await demarrer(t, taille: const Size(1100, 900));
    expect(find.byType(GridView), findsOneWidget);
    expect(t.takeException(), isNull);
    await t.pumpWidget(const SizedBox());
  });
  testWidgets('Recherche puis ouverture : bon identifiant', (t) async {
    await demarrer(t);
    await t.enterText(find.byKey(const ValueKey('recherche')), 'Sophie');
    await stabiliser(t);
    await t.ensureVisible(find.byKey(const ValueKey('ouvrir_2')));
    await stabiliser(t);
    await t.tap(find.byKey(const ValueKey('ouvrir_2')));
    await stabiliser(t);
    expect(find.text('Sophie'), findsOneWidget);
    expect(find.text('Électricité'), findsOneWidget);
    await t.pumpWidget(const SizedBox());
  });
  testWidgets('Favoris partagés entre fiche et catalogue', (t) async {
    await demarrer(t);
    await t.ensureVisible(find.byKey(const ValueKey('ouvrir_1')));
    await stabiliser(t);
    await t.tap(find.byKey(const ValueKey('ouvrir_1')));
    await stabiliser(t);
    await t.tap(find.byKey(const ValueKey('favori_detail')));
    await stabiliser(t);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    await t.tap(find.byKey(const ValueKey('retour')));
    await stabiliser(t);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    await t.ensureVisible(find.byKey(const ValueKey('favori_1')));
    await stabiliser(t);
    await t.tap(find.byKey(const ValueKey('favori_1')));
    await stabiliser(t);
    expect(find.byIcon(Icons.favorite), findsNothing);
    await t.pumpWidget(const SizedBox());
  });
  testWidgets('Route artisan inconnu', (t) async {
    await demarrer(t, chemin: '/artisans/999');
    expect(find.text('Artisan introuvable'), findsOneWidget);
    await t.pumpWidget(const SizedBox());
  });
  testWidgets('Route inexistante', (t) async {
    await demarrer(t, chemin: '/inconnu');
    expect(find.text('Cette page est introuvable.'), findsOneWidget);
    await t.pumpWidget(const SizedBox());
  });
  testWidgets('Connexion locale depuis interface', (t) async {
    await demarrer(t, chemin: '/connexion');
    await t.tap(find.byKey(const ValueKey('demo_client')));
    await stabiliser(t);
    expect(find.text('Gérard'), findsOneWidget);
    await t.pumpWidget(const SizedBox());
  });
  testWidgets('Demande : validation, création, acceptation et retour client', (
    t,
  ) async {
    final session = await demarrer(t);
    session.demo(false);
    await stabiliser(t);
    await t.ensureVisible(find.byKey(const ValueKey('ouvrir_1')));
    await stabiliser(t);
    await t.tap(find.byKey(const ValueKey('ouvrir_1')));
    await stabiliser(t);
    await t.ensureVisible(find.byKey(const ValueKey('envoyer')));
    await stabiliser(t);
    await t.tap(find.byKey(const ValueKey('envoyer')));
    await stabiliser(t);
    expect(find.text('Indiquez au moins 5 caractères.'), findsOneWidget);
    await t.enterText(find.byKey(const ValueKey('motif')), 'Fuite de cuisine');
    await t.ensureVisible(find.byKey(const ValueKey('envoyer')));
    await stabiliser(t);
    await t.tap(find.byKey(const ValueKey('envoyer')));
    await stabiliser(t);
    expect(find.text('Fuite de cuisine'), findsOneWidget);
    session.demo(true);
    await stabiliser(t);
    await t.tap(find.text('Accepter'));
    await stabiliser(t);
    expect(find.text('Acceptée'), findsOneWidget);
    expect(find.text('Accepter'), findsNothing);
    session.demo(false);
    await stabiliser(t);
    expect(find.text('Acceptée'), findsOneWidget);
    expect(t.takeException(), isNull);
    await t.pumpWidget(const SizedBox());
  });
  testWidgets('Traduction : interface passe en anglais', (t) async {
    await demarrer(t, chemin: '/reglages');
    await t.tap(find.text('English'));
    await stabiliser(t);
    expect(find.text('Settings'), findsWidgets);
    expect(find.text('Language'), findsOneWidget);
    await t.pumpWidget(const SizedBox());
  });
}
