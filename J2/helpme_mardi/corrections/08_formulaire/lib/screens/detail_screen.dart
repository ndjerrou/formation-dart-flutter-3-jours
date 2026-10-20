import 'package:flutter/material.dart';

import '../models/artisan.dart';

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
  final _cleFormulaire = GlobalKey<FormState>();
  final _motif = TextEditingController();

  @override
  void dispose() {
    _motif.dispose();
    super.dispose();
  }

  void _envoyer() {
    if (_cleFormulaire.currentState?.validate() != true) return;
    Navigator.of(context).pop('Demande préparée pour ${widget.artisan.nom}.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.artisan.nom)),
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
                onPressed: () => Navigator.of(context)
                    .pop('Artisan choisi : ${widget.artisan.nom}'),
                child: const Text('Choisir cet artisan'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                key: const ValueKey('motif'),
                controller: _motif,
                minLines: 2,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Motif de la demande',
                  helperText:
                      'Au moins 5 caractères. Données fictives uniquement.',
                  border: OutlineInputBorder(),
                ),
                validator: (valeur) {
                  if (valeur == null || valeur.trim().length < 5) {
                    return 'Indique au moins 5 caractères.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                key: const ValueKey('envoyer'),
                onPressed: _envoyer,
                icon: const Icon(Icons.send),
                label: const Text('Préparer la demande'),
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
