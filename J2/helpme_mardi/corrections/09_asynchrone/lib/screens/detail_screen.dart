import 'package:flutter/material.dart';

import '../models/artisan.dart';
import '../services/service_demande.dart';

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
              Text(
                widget.artisan.metier,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text('${widget.artisan.tarif} €/h - tarif fictif'),
              const SizedBox(height: 12),
              OutlinedButton(
                key: const ValueKey('choisir'),
                onPressed: _envoi
                    ? null
                    : () => Navigator.of(context)
                        .pop('Artisan choisi : ${widget.artisan.nom}'),
                child: const Text('Choisir cet artisan'),
              ),
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
                    child: Text(
                      _erreur ?? '',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
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
                label: Text(
                  _envoi ? 'Envoi en cours…' : 'Envoyer la simulation',
                ),
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
