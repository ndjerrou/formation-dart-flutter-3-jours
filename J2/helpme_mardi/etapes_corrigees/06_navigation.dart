// Navigator ouvre une fiche et récupère le résultat lorsqu’elle se ferme.
// flutter run -d chrome -t etapes_corrigees/06_navigation.dart
import 'package:flutter/material.dart';

void main() => runApp(const CorrectionApp());

class CorrectionApp extends StatelessWidget {
  const CorrectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CatalogueAtelier());
  }
}

class CatalogueAtelier extends StatefulWidget {
  const CatalogueAtelier({super.key});
  @override
  State<CatalogueAtelier> createState() => _CatalogueAtelierState();
}

class _CatalogueAtelierState extends State<CatalogueAtelier> {
  final List<int> _favoris = [];

  void _basculer(int id) {
    setState(() {
      _favoris.contains(id) ? _favoris.remove(id) : _favoris.add(id);
    });
  }

  Future<void> _ouvrir(Artisan artisan) async {
    final resultat = await Navigator.of(context).push<String>(
      MaterialPageRoute(
          builder: (context) => FicheDecouverte(artisan: artisan)),
    );
    if (!mounted || resultat == null) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(resultat)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HelpMe - ${_favoris.length} favori(s)')),
      body: ListView.builder(
        itemCount: artisansDemo.length,
        itemBuilder: (context, index) {
          final artisan = artisansDemo[index];
          return CarteArtisan(
            key: ValueKey(artisan.id),
            artisan: artisan,
            favori: _favoris.contains(artisan.id),
            // Le parent décide, l'enfant signale une intention avec un callback.
            onFavori: () => _basculer(artisan.id),
            onOuvrir: () => _ouvrir(artisan),
          );
        },
      ),
    );
  }
}

class FicheDecouverte extends StatelessWidget {
  const FicheDecouverte({super.key, required this.artisan});
  final Artisan artisan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(artisan.nom)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(artisan.metier),
            Text('${artisan.tarif} €/h - tarif fictif'),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pop('Artisan choisi : ${artisan.nom}'),
              child: const Text('Choisir cet artisan'),
            ),
          ],
        ),
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

// Ce composant reçoit son affichage et ses actions. Il ne possède pas les favoris.
class CarteArtisan extends StatelessWidget {
  const CarteArtisan({
    super.key,
    required this.artisan,
    required this.favori,
    required this.onFavori,
    required this.onOuvrir,
  });

  final Artisan artisan;
  final bool favori;
  // VoidCallback est un alias de void Function() : une action à appeler plus tard.
  final VoidCallback onFavori;
  final VoidCallback onOuvrir;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const CircleAvatar(child: Icon(Icons.handyman)),
                const SizedBox(width: 12),
                // Expanded donne au texte la largeur restante dans cette Row.
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(artisan.nom,
                          style: Theme.of(context).textTheme.titleLarge),
                      Text(artisan.metier),
                    ],
                  ),
                ),
                IconButton(
                  key: ValueKey('favori_${artisan.id}'),
                  tooltip: favori
                      ? 'Retirer ${artisan.nom} des favoris'
                      : 'Ajouter ${artisan.nom} aux favoris',
                  onPressed: onFavori,
                  icon: Icon(favori ? Icons.favorite : Icons.favorite_border),
                  color: favori ? Colors.red.shade700 : null,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('${artisan.tarif} €/h - tarif fictif'),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              key: ValueKey('ouvrir_${artisan.id}'),
              onPressed: onOuvrir,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Voir la fiche'),
            ),
          ],
        ),
      ),
    );
  }
}
