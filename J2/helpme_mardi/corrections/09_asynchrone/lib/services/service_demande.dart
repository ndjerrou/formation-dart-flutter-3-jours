import '../models/artisan.dart';

// Simulation uniquement : aucune demande réelle et aucun enregistrement.
// delai peut être Duration.zero dans un test qui vérifie seulement le service.
Future<String> simulerEnvoi({
  required Artisan artisan,
  required String motif,
  bool simulerErreur = false,
  Duration delai = const Duration(milliseconds: 800),
}) async {
  if (motif.trim().length < 5) {
    throw ArgumentError('Le motif doit contenir au moins 5 caractères.');
  }
  await Future<void>.delayed(delai);
  if (simulerErreur) {
    throw StateError('Service indisponible. Réessaie.');
  }
  return 'Demande simulée envoyée à ${artisan.nom}.';
}
