// Deux instances du même widget reçoivent des titres différents.
// flutter run -d chrome -t etapes_corrigees/01b_parametres.dart
import 'package:flutter/material.dart';

void main() => runApp(const CorrectionApp());

class CorrectionApp extends StatelessWidget {
  const CorrectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
            body: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
      TitreSection(titre: 'Les artisans'),
      SizedBox(height: 16),
      TitreSection(titre: 'Mes favoris')
    ]))));
  }
}

class TitreSection extends StatelessWidget {
  const TitreSection({super.key, required this.titre});
  final String titre;

  @override
  Widget build(BuildContext context) {
    return Text(titre, style: const TextStyle(fontSize: 26));
  }
}
