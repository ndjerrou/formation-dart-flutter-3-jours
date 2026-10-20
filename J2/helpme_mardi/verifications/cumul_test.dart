import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../corrections/01_accueil/lib/app.dart' as j1;
import '../corrections/02_parametres/lib/app.dart' as j2;
import '../corrections/03_presentation/lib/app.dart' as j3;
import '../corrections/04_catalogue/lib/app.dart' as j4;
import '../corrections/05_favoris/lib/app.dart' as j5;
import '../corrections/06_composants/lib/app.dart' as j6;
import '../corrections/07_navigation/lib/app.dart' as j7;
import '../corrections/08_formulaire/lib/app.dart' as j8;
import '../corrections/09_asynchrone/lib/app.dart' as j9;
import '../corrections/10_responsive/lib/app.dart' as j10;
import '../corrections/11_recherche/lib/app.dart' as j11;

void main() {
  final applications = <int, Widget Function(bool, bool)>{
    1: (r, e) => j1.HelpMeApp(responsive: r, simulerErreur: e),
    2: (r, e) => j2.HelpMeApp(responsive: r, simulerErreur: e),
    3: (r, e) => j3.HelpMeApp(responsive: r, simulerErreur: e),
    4: (r, e) => j4.HelpMeApp(responsive: r, simulerErreur: e),
    5: (r, e) => j5.HelpMeApp(responsive: r, simulerErreur: e),
    6: (r, e) => j6.HelpMeApp(responsive: r, simulerErreur: e),
    7: (r, e) => j7.HelpMeApp(responsive: r, simulerErreur: e),
    8: (r, e) => j8.HelpMeApp(responsive: r, simulerErreur: e),
    9: (r, e) => j9.HelpMeApp(responsive: r, simulerErreur: e),
    10: (r, e) => j10.HelpMeApp(responsive: r, simulerErreur: e),
    11: (r, e) => j11.HelpMeApp(responsive: r, simulerErreur: e),
  };
  for (final entree in applications.entries) {
    final numero = entree.key;
    testWidgets('jalon $numero conserve les comportements acquis',
        (tester) async {
      await tester.pumpWidget(entree.value(false, false));
      await tester.pumpAndSettle();
      expect(find.text('Bonjour Flutter !'), findsOneWidget);
      if (numero >= 2) {
        expect(find.text('Trouver un artisan'), findsOneWidget);
        expect(
            find.text('Des professionnels près de chez vous'), findsOneWidget);
      }
      if (numero >= 3) expect(find.text('Gérard'), findsOneWidget);
      if (numero >= 4) expect(find.text('Sophie'), findsOneWidget);
      if (numero >= 5) {
        await tester.tap(find.byKey(const ValueKey('favori_1')));
        await tester.pump();
        expect(find.text('1 favori(s)'), findsOneWidget);
      }
      if (numero == 6) {
        await tester.tap(find.byKey(const ValueKey('ouvrir_1')));
        await tester.pump();
        expect(find.text('Sélection : Gérard'), findsOneWidget);
      }
      if (numero >= 7) {
        await tester.tap(find.byKey(const ValueKey('ouvrir_1')));
        await tester.pumpAndSettle();
        expect(find.byKey(const ValueKey('choisir')), findsOneWidget);
        await tester.tap(find.byKey(const ValueKey('choisir')));
        await tester.pumpAndSettle();
        expect(find.text('Artisan choisi : Gérard'), findsOneWidget);
        expect(find.text('1 favori(s)'), findsOneWidget);
      }
      if (numero >= 8) {
        await tester.tap(find.byKey(const ValueKey('ouvrir_1')));
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(const ValueKey('motif')), 'abc');
        await tester.tap(find.byKey(const ValueKey('envoyer')));
        await tester.pump();
        expect(find.text('Indique au moins 5 caractères.'), findsOneWidget);
        await tester.enterText(
            find.byKey(const ValueKey('motif')), 'Fuite cuisine');
        await tester.tap(find.byKey(const ValueKey('envoyer')));
        if (numero >= 9) {
          await tester.pump();
          expect(find.byKey(const ValueKey('envoi_progress')), findsOneWidget);
          await tester.pump(const Duration(milliseconds: 850));
        }
        await tester.pumpAndSettle();
        expect(
            find.text(numero == 8
                ? 'Demande préparée pour Gérard.'
                : 'Demande simulée envoyée à Gérard.'),
            findsOneWidget);
        expect(find.text('1 favori(s)'), findsOneWidget);
      }
      if (numero >= 10) {
        tester.view.physicalSize = const Size(1100, 1000);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pump();
        expect(find.text('1 favori(s)'), findsOneWidget);
      }
      if (numero >= 11) {
        await tester.enterText(
            find.byKey(const ValueKey('recherche')), 'gerard');
        await tester.pump();
        // La recherche conserve les accents : Gérard s'écrit avec é.
        await tester.enterText(
            find.byKey(const ValueKey('recherche')), 'plomberie');
        await tester.pump();
        expect(find.text('Gérard'), findsOneWidget);
        expect(find.text('Sophie'), findsNothing);
      }
      expect(tester.takeException(), isNull);
    });
  }
}
