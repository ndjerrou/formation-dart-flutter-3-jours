import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helpme_mardi/app.dart';
import 'package:helpme_mardi/configuration.dart';

void main() {
  testWidgets('notre application affiche toujours son accueil', (tester) async {
    await tester.pumpWidget(const HelpMeApp());
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text(messageAccueil), findsOneWidget);
  });
}
