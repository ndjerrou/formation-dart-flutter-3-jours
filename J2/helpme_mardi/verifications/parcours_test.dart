import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../corrections/11_recherche/lib/app.dart';

// Vérifications de comportements utilisateur.
void main() {
  testWidgets('favori et filtre conservent la bonne personne', (tester) async {
    await tester.pumpWidget(const HelpMeApp(responsive: false));
    await tester.tap(find.byKey(const ValueKey('favori_1')));
    await tester.pump();
    expect(find.text('1 favori(s)'), findsOneWidget);
    await tester.tap(find.text('Favoris uniquement'));
    await tester.pump();
    expect(find.text('Gérard'), findsOneWidget);
    expect(find.text('Sophie'), findsNothing);
    await tester.tap(find.byKey(const ValueKey('favori_1')));
    await tester.pump();
    expect(find.text('Aucun artisan ne correspond.'), findsOneWidget);
  });

  testWidgets('rechercher puis effacer ne supprime pas les données', (
    tester,
  ) async {
    await tester.pumpWidget(const HelpMeApp());
    await tester.enterText(find.byKey(const ValueKey('recherche')), 'sophie');
    await tester.pump();
    expect(find.text('Sophie'), findsOneWidget);
    expect(find.text('Gérard'), findsNothing);
    await tester.enterText(find.byKey(const ValueKey('recherche')), '');
    await tester.pump();
    expect(find.text('3 artisan(s)'), findsOneWidget);
  });

  testWidgets('valider, attendre et recevoir le résultat de la fiche', (
    tester,
  ) async {
    await tester.pumpWidget(const HelpMeApp(responsive: false));
    await tester.tap(find.byKey(const ValueKey('ouvrir_1')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('motif')), 'abc');
    await tester.tap(find.byKey(const ValueKey('envoyer')));
    await tester.pump();
    expect(find.text('Indique au moins 5 caractères.'), findsOneWidget);
    expect(find.byKey(const ValueKey('envoi_progress')), findsNothing);

    await tester.enterText(
      find.byKey(const ValueKey('motif')),
      'Fuite dans la cuisine',
    );
    await tester.tap(find.byKey(const ValueKey('envoyer')));
    await tester.pump();
    expect(find.byKey(const ValueKey('envoi_progress')), findsOneWidget);
    final button = tester.widget<FilledButton>(
      find.byKey(const ValueKey('envoyer')),
    );
    expect(button.onPressed, isNull);
    await tester.pump(const Duration(milliseconds: 850));
    await tester.pumpAndSettle();
    expect(find.text('Demande simulée envoyée à Gérard.'), findsOneWidget);
    expect(find.byKey(const ValueKey('recherche')), findsOneWidget);
  });

  testWidgets('une panne garde la saisie et réactive le bouton', (
    tester,
  ) async {
    await tester.pumpWidget(const HelpMeApp(simulerErreur: true));
    await tester.tap(find.byKey(const ValueKey('ouvrir_1')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('motif')),
      'Fuite dans la cuisine',
    );
    await tester.tap(find.byKey(const ValueKey('envoyer')));
    await tester.pump(const Duration(milliseconds: 850));
    await tester.pumpAndSettle();
    expect(find.text('Service indisponible. Réessaie.'), findsOneWidget);
    expect(find.text('Fuite dans la cuisine'), findsOneWidget);
    final button = tester.widget<FilledButton>(
      find.byKey(const ValueKey('envoyer')),
    );
    expect(button.onPressed, isNotNull);
  });

  testWidgets('quitter pendant une attente ne modifie pas un State détruit', (
    tester,
  ) async {
    await tester.pumpWidget(const HelpMeApp());
    await tester.tap(find.byKey(const ValueKey('ouvrir_1')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('motif')),
      'Fuite cuisine',
    );
    await tester.tap(find.byKey(const ValueKey('envoyer')));
    await tester.pump();
    await tester.pageBack();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.byKey(const ValueKey('recherche')), findsOneWidget);
  });

  for (final largeur in [320.0, 1100.0]) {
    testWidgets('mise en page à $largeur pixels et texte agrandi', (
      tester,
    ) async {
      tester.view.physicalSize = Size(largeur, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(2)),
            child: child ?? const SizedBox.shrink(),
          ),
          home: const HelpMeApp(),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      final titre = tester.element(find.text('Trouver un artisan'));
      expect(MediaQuery.textScalerOf(titre).scale(16), 32);
      expect(find.byTooltip('Ajouter Gérard aux favoris'), findsOneWidget);
    });
  }
}
