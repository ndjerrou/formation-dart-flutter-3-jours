import 'package:flutter_test/flutter_test.dart';

import '../corrections/11_recherche/lib/data/demo_artisans.dart';
import '../corrections/11_recherche/lib/services/service_demande.dart';

void main() {
  test(
    'le service refuse le motif vide indépendamment du formulaire',
    () async {
      await expectLater(
        simulerEnvoi(
          artisan: artisansDemo.first,
          motif: '   ',
          delai: Duration.zero,
        ),
        throwsArgumentError,
      );
    },
  );

  test('la simulation produit le destinataire demandé', () async {
    final result = await simulerEnvoi(
      artisan: artisansDemo[1],
      motif: 'Problème de prise',
      delai: Duration.zero,
    );
    expect(result, 'Demande simulée envoyée à Sophie.');
  });

  test('une panne est distincte d’un résultat de succès', () async {
    await expectLater(
      simulerEnvoi(
        artisan: artisansDemo.first,
        motif: 'Fuite de robinet',
        simulerErreur: true,
        delai: Duration.zero,
      ),
      throwsStateError,
    );
  });
}
