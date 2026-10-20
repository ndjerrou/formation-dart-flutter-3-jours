// Le catalogue conserve les identifiants favoris ; setState actualise leur affichage.
// flutter run -d chrome -t etapes_corrigees/04_etat.dart
import 'package:flutter/material.dart';

void main() => runApp(const CorrectionApp());

class CorrectionApp extends StatelessWidget {
  const CorrectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PageFavoris());
  }
}

class PageFavoris extends StatefulWidget {
  const PageFavoris({super.key});
  @override
  State<PageFavoris> createState() => _PageFavorisState();
}

class _PageFavorisState extends State<PageFavoris> {
  // Ce champ reste disponible entre deux appels à build.
  final List<int> _favoris = [];

  void _basculer(int id) {
    setState(() {
      if (_favoris.contains(id)) {
        _favoris.remove(id);
      } else {
        _favoris.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favoris : ${_favoris.length}')),
      body: ListView.builder(
        itemCount: artisansDemo.length,
        itemBuilder: (context, index) {
          final artisan = artisansDemo[index];
          final selectionne = _favoris.contains(artisan.id);
          return ListTile(
            title: Text(artisan.nom),
            subtitle: Text(artisan.metier),
            trailing: IconButton(
              tooltip: 'Favori de ${artisan.nom}',
              icon: Icon(selectionne ? Icons.favorite : Icons.favorite_border),
              onPressed: () => _basculer(artisan.id),
            ),
          );
        },
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
