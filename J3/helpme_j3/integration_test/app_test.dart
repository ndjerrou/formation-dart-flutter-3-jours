import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:helpme_j3/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('iPhone : catalogue, recherche et fiche', (tester) async {
    await app.main();
    await tester.pumpAndSettle();
    expect(find.text('Gérard'), findsOneWidget);
    await tester.enterText(find.byKey(const ValueKey('recherche')), 'Sophie');
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('ouvrir_2')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('ouvrir_2')));
    await tester.pumpAndSettle();
    expect(find.text('Sophie'), findsOneWidget);
    expect(find.text('Électricité'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('retour')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('recherche')), findsOneWidget);
  });
}
