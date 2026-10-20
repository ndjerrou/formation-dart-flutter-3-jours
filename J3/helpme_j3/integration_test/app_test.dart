import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:helpme_j3/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('iPhone départ : lancement et mauvaise fiche reproductible', (
    tester,
  ) async {
    final ancien = FlutterError.onError;
    // Seul le débordement B01 est attendu sur cette version de départ.
    FlutterError.onError = (details) {
      if (!details.exceptionAsString().contains('overflowed'))
        ancien?.call(details);
    };
    addTearDown(() => FlutterError.onError = ancien);
    await app.main();
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('recherche')), findsOneWidget);
    await tester.enterText(find.byKey(const ValueKey('recherche')), 'Sophie');
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('ouvrir_2')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('ouvrir_2')));
    await tester.pumpAndSettle();
    expect(find.text('Gérard'), findsOneWidget);
  });
}
