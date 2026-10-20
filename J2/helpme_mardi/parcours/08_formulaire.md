# Enrichir la même fiche avec un formulaire

Jalon **08_formulaire** - fiches F13, F14.

## Notre point de départ

Notre projet courant contient déjà le jalon 07_navigation. On le complète, on ne le remplace pas.

La commande reste `flutter run -d chrome` et l’entrée reste `lib/main.dart`.

## Modifications à intégrer

1. Transformer DetailScreen en StatefulWidget sans supprimer les informations de l’artisan ni le bouton Choisir.
2. Créer GlobalKey<FormState> et TextEditingController dans le State ; libérer le contrôleur dans dispose.
3. Ajouter Form, TextFormField, label et validator : refuser un motif dont trim().length est inférieur à 5.
4. Ajouter un bouton Préparer la demande distinct de Choisir. Sa méthode _envoyer valide d’abord puis pop avec un message.
5. Utiliser R après le changement de type de widget. Tester vide, espaces, abc et Fuite cuisine.

## Fichiers concernés

- `lib/screens/detail_screen.dart` : faire évoluer ce fichier en conservant le reste.

## Vérifier aussi ce qui fonctionnait déjà

- [ ] Les informations et la sélection simple de la fiche sont conservées.
- [ ] Un motif court ne ferme pas la fiche ; un motif valide prépare la demande.
- [ ] Le catalogue et ses favoris sont encore présents après le retour.
- [ ] Le message personnel et les données sont toujours présents.
- [ ] Sélectionner puis désélectionner un favori fonctionne encore.
- [ ] Ouvrir une fiche et revenir ne perd pas les favoris.

## Code de référence après ce jalon

Essayer avant d’ouvrir la correction. Les fichiers ci-dessous montrent le résultat attendu pour comparer les blocs modifiés. Ils ne se collent pas tous dans main.dart.

<details>
<summary>Voir lib/screens/detail_screen.dart</summary>

```dart
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
```

</details>
