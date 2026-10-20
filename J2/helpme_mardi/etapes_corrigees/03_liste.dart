// ListView.builder construit les lignes à partir des données.
// flutter run -d chrome -t etapes_corrigees/03_liste.dart
import 'package:flutter/material.dart';

void main() => runApp(const CorrectionApp());

class CorrectionApp extends StatelessWidget {
  const CorrectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PageListe());
  }
}

class PageListe extends StatelessWidget {
  const PageListe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HelpMe - Catalogue')),
      body: Column(
        children: [
          Text('${artisansDemo.length} artisans disponibles'),
          // Sans cette hauteur bornée, ListView ne sait pas combien occuper.
          Expanded(
            child: ListView.builder(
              itemCount: artisansDemo.length,
              itemBuilder: (context, index) {
                // itemBuilder est une fonction appelée pour un index demandé.
                final artisan = artisansDemo[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.handyman),
                    title: Text(artisan.nom),
                    subtitle: Text('${artisan.metier} - ${artisan.tarif} €/h'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Un objet métier Dart : aucune dépendance à Flutter.
class Artisan {
  // Les paramètres nommés et required prolongent le CLI de lundi.
  const Artisan({
    required this.id,
    required this.nom,
    required this.metier,
    required this.tarif,
  });

  final int id;
  final String nom;
  final String metier;
  final int tarif;
}

// Données fictives et constantes. Aucun appel réseau ni image distante.
const artisansDemo = <Artisan>[
  Artisan(id: 1, nom: 'Gérard', metier: 'Plomberie', tarif: 65),
  Artisan(id: 2, nom: 'Sophie', metier: 'Électricité', tarif: 80),
  Artisan(id: 3, nom: 'Pierre', metier: 'Carrelage', tarif: 95),
];
