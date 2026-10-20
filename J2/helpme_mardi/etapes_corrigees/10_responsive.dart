// LayoutBuilder adapte la liste à la largeur disponible.
// flutter run -d chrome -t etapes_corrigees/10_responsive.dart
import 'package:flutter/material.dart';

// La largeur disponible décide entre une et deux colonnes.
void main() => runApp(const CorrectionApp());

class CorrectionApp extends StatelessWidget {
  const CorrectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HelpMeApp();
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

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.artisan,
    this.simulerErreur = false,
  });

  final Artisan artisan;
  final bool simulerErreur;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // La clé permet de demander aux champs du formulaire de se valider.
  final _cleFormulaire = GlobalKey<FormState>();
  // Ce contrôleur vit avec le State, pas dans build.
  final _motif = TextEditingController();
  bool _envoi = false;
  String? _erreur;

  @override
  void dispose() {
    // Libérer les ressources quand cet écran est retiré définitivement.
    _motif.dispose();
    super.dispose();
  }

  Future<void> _envoyer() async {
    // Deux gardes : éviter un double envoi et refuser un formulaire invalide.
    if (_envoi || _cleFormulaire.currentState?.validate() != true) return;
    setState(() {
      _envoi = true;
      _erreur = null;
    });
    try {
      final resultat = await simulerEnvoi(
        artisan: widget.artisan,
        motif: _motif.text,
        simulerErreur: widget.simulerErreur,
      );
      // L'utilisateur a pu revenir en arrière pendant le délai.
      if (!mounted) return;
      // Pendant l'animation de retour, mounted peut encore être vrai.
      // Ne pas faire un deuxième pop sur une fiche déjà quittée.
      if (ModalRoute.of(context)?.isCurrent != true) return;
      // pop renvoie une valeur à l'écran qui a fait push<String>.
      Navigator.of(context).pop(resultat);
    } on StateError catch (erreur) {
      if (!mounted) return;
      setState(() => _erreur = erreur.message);
    } finally {
      if (mounted) setState(() => _envoi = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.artisan.nom)),
      // Le contenu peut défiler si le clavier ou le texte agrandi prend de la place.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _cleFormulaire,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.artisan.metier,
                  style: Theme.of(context).textTheme.headlineSmall),
              Text('${widget.artisan.tarif} €/h - tarif fictif'),
              const SizedBox(height: 20),
              TextFormField(
                key: const ValueKey('motif'),
                controller: _motif,
                enabled: !_envoi,
                minLines: 2,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Motif de la demande',
                  helperText:
                      'Au moins 5 caractères. Données fictives uniquement.',
                  border: OutlineInputBorder(),
                ),
                validator: (valeur) {
                  // null signifie « pas d'erreur de validation ».
                  if (valeur == null || valeur.trim().length < 5) {
                    return 'Indique au moins 5 caractères.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (_erreur != null)
                Semantics(
                  liveRegion: true,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(_erreur ?? '',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error)),
                  ),
                ),
              FilledButton.icon(
                key: const ValueKey('envoyer'),
                onPressed: _envoi ? null : _envoyer,
                icon: _envoi
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          key: ValueKey('envoi_progress'),
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.send),
                label:
                    Text(_envoi ? 'Envoi en cours…' : 'Envoyer la simulation'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Atelier : aucun artisan ne reçoit cette demande. '
                'Les données restent en mémoire.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({
    super.key,
    this.responsive = true,
    this.simulerErreur = false,
  });

  final bool responsive;
  final bool simulerErreur;

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  // Une liste d'IDs, pour réutiliser les collections de lundi.
  final List<int> _favoris = [];
  String _recherche = '';
  bool _seulementFavoris = false;

  void _basculerFavori(int id) {
    setState(() {
      if (_favoris.contains(id)) {
        _favoris.remove(id);
      } else {
        _favoris.add(id);
      }
    });
  }

  List<Artisan> get _visibles {
    final texte = _recherche.trim().toLowerCase();
    return artisansDemo.where((artisan) {
      final correspond = artisan.nom.toLowerCase().contains(texte) ||
          artisan.metier.toLowerCase().contains(texte);
      final favoriAccepte = !_seulementFavoris || _favoris.contains(artisan.id);
      return correspond && favoriAccepte;
    }).toList();
  }

  Future<void> _ouvrir(Artisan artisan) async {
    final message = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          artisan: artisan,
          simulerErreur: widget.simulerErreur,
        ),
      ),
    );
    if (!mounted || message == null) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _carte(Artisan artisan) {
    return CarteArtisan(
      key: ValueKey(artisan.id),
      artisan: artisan,
      favori: _favoris.contains(artisan.id),
      // Une fonction est transmise, puis appelée lors du clic.
      onFavori: () => _basculerFavori(artisan.id),
      onOuvrir: () => _ouvrir(artisan),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Le filtre dérive de l'état actuel. Il ne supprime pas les données source.
    final visibles = _visibles;
    return Scaffold(
      appBar: AppBar(title: const Text('HelpMe - Découverte')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Trouver un artisan',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 12),
              TextField(
                key: const ValueKey('recherche'),
                decoration: const InputDecoration(
                  labelText: 'Rechercher un nom ou un métier',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (texte) => setState(() => _recherche = texte),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  FilterChip(
                    label: const Text('Favoris uniquement'),
                    selected: _seulementFavoris,
                    onSelected: (valeur) =>
                        setState(() => _seulementFavoris = valeur),
                  ),
                  Text('${_favoris.length} favori(s)'),
                  Text('${visibles.length} artisan(s)'),
                ],
              ),
              const SizedBox(height: 8),
              // La liste reçoit une hauteur bornée : l'espace restant de la Column.
              Expanded(
                child: visibles.isEmpty
                    ? const Center(child: Text('Aucun artisan ne correspond.'))
                    : LayoutBuilder(
                        builder: (context, contraintes) {
                          // Largeur disponible ici, pas un nom de téléphone.
                          final deuxColonnes =
                              widget.responsive && contraintes.maxWidth >= 700;
                          if (!deuxColonnes) {
                            return ListView.builder(
                              itemCount: visibles.length,
                              itemBuilder: (context, index) =>
                                  _carte(visibles[index]),
                            );
                          }
                          // Chaque ligne garde sa hauteur naturelle, même avec
                          // de grandes polices. Pas de hauteur fixe de carte.
                          return ListView.builder(
                            itemCount: (visibles.length / 2).ceil(),
                            itemBuilder: (context, ligne) {
                              final index = ligne * 2;
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: _carte(visibles[index])),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: index + 1 < visibles.length
                                        ? _carte(visibles[index + 1])
                                        : const SizedBox.shrink(),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HelpMeApp extends StatelessWidget {
  const HelpMeApp({
    super.key,
    this.responsive = true,
    this.simulerErreur = false,
  });

  final bool responsive;
  final bool simulerErreur;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HelpMe - Mardi Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF116B65)),
      ),
      home: CatalogueScreen(
        responsive: responsive,
        simulerErreur: simulerErreur,
      ),
    );
  }
}
