// Row range horizontalement ; Column range verticalement. Expanded prend la largeur restante.
// flutter run -d chrome -t etapes_corrigees/02_layout.dart
import 'package:flutter/material.dart';

void main() => runApp(const CorrectionApp());

class CorrectionApp extends StatelessWidget {
  const CorrectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PagePresentation());
  }
}

// Les paramètres d'un widget sont des données de configuration.
class PagePresentation extends StatelessWidget {
  const PagePresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HelpMe - Présentation')),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trouver un artisan', style: TextStyle(fontSize: 26)),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(child: Icon(Icons.handyman)),
                    SizedBox(width: 12),
                    // La Row réserve la largeur restante à cette Column.
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Gérard', style: TextStyle(fontSize: 22)),
                          Text('Plomberie'),
                          Text('65 €/h - tarif fictif'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
