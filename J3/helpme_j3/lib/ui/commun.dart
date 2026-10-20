import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/demande.dart';

IconData iconeMetier(String cle) => switch (cle) {
  'plomberie' => Icons.plumbing,
  'electricite' => Icons.electrical_services,
  'carrelage' => Icons.grid_view,
  'menuiserie' => Icons.carpenter,
  'peinture' => Icons.format_paint,
  'jardinage' => Icons.yard,
  _ => Icons.handyman,
};
String libelleStatut(AppLocalizations l, StatutDemande s) => switch (s) {
  StatutDemande.pending => l.pending,
  StatutDemande.accepted => l.accepted,
  StatutDemande.refused => l.refused,
};

class PanneauErreur extends StatelessWidget {
  const PanneauErreur({super.key, required this.texte, this.reessayer});
  final String texte;
  final VoidCallback? reessayer;
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info_outline, size: 36),
          const SizedBox(height: 12),
          Text(texte, textAlign: TextAlign.center),
          if (reessayer != null)
            FilledButton(
              onPressed: reessayer,
              child: Text(AppLocalizations.of(context).retry),
            ),
        ],
      ),
    ),
  );
}
