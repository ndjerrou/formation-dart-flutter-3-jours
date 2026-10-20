import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../etapes_corrigees/01_bonjour.dart' as e0;
import '../etapes_corrigees/01b_parametres.dart' as e1;
import '../etapes_corrigees/02_layout.dart' as e2;
import '../etapes_corrigees/03_liste.dart' as e3;
import '../etapes_corrigees/04_etat.dart' as e4;
import '../etapes_corrigees/05_callbacks.dart' as e5;
import '../etapes_corrigees/06_navigation.dart' as e6;
import '../etapes_corrigees/07_formulaire.dart' as e7;
import '../etapes_corrigees/08_asynchrone.dart' as e8;
import '../etapes_corrigees/09_integration.dart' as e9;
import '../etapes_corrigees/10_responsive.dart' as e10;

void main() {
  testWidgets('01_bonjour : écran sans erreur', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const e0.CorrectionApp());
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsWidgets);
    expect(tester.takeException(), isNull);
  });
  testWidgets('01b_parametres : écran sans erreur', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const e1.CorrectionApp());
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsWidgets);
    expect(tester.takeException(), isNull);
  });
  testWidgets('02_layout : écran sans erreur', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const e2.CorrectionApp());
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsWidgets);
    expect(tester.takeException(), isNull);
  });
  testWidgets('03_liste : écran sans erreur', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const e3.CorrectionApp());
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsWidgets);
    expect(tester.takeException(), isNull);
  });
  testWidgets('04_etat : écran sans erreur', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const e4.CorrectionApp());
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsWidgets);
    expect(tester.takeException(), isNull);
  });
  testWidgets('05_callbacks : écran sans erreur', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const e5.CorrectionApp());
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsWidgets);
    expect(tester.takeException(), isNull);
  });
  testWidgets('06_navigation : écran sans erreur', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const e6.CorrectionApp());
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsWidgets);
    expect(tester.takeException(), isNull);
  });
  testWidgets('07_formulaire : écran sans erreur', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const e7.CorrectionApp());
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsWidgets);
    expect(tester.takeException(), isNull);
  });
  testWidgets('08_asynchrone : écran sans erreur', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const e8.CorrectionApp());
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsWidgets);
    expect(tester.takeException(), isNull);
  });
  testWidgets('09_integration : écran sans erreur', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const e9.CorrectionApp());
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsWidgets);
    expect(tester.takeException(), isNull);
  });
  testWidgets('10_responsive : écran sans erreur', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const e10.CorrectionApp());
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsWidgets);
    expect(tester.takeException(), isNull);
  });
  testWidgets('04_etat : ajout puis retrait du favori', (tester) async {
    await tester.pumpWidget(const e4.CorrectionApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Favori de Gérard'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    await tester.tap(find.byTooltip('Favori de Gérard'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets('05_callbacks : ajout puis retrait du favori', (tester) async {
    await tester.pumpWidget(const e5.CorrectionApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('favori_1')));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('favori_1')));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets('06_navigation : ajout puis retrait du favori', (tester) async {
    await tester.pumpWidget(const e6.CorrectionApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('favori_1')));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('favori_1')));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets('09_integration : ajout puis retrait du favori', (tester) async {
    await tester.pumpWidget(const e9.CorrectionApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('favori_1')));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('favori_1')));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsNothing);
    expect(tester.takeException(), isNull);
  });
  testWidgets('10_responsive : ajout puis retrait du favori', (tester) async {
    await tester.pumpWidget(const e10.CorrectionApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('favori_1')));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('favori_1')));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
