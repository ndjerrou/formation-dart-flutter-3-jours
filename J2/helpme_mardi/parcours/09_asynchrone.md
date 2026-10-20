# Ajouter attente et erreur au même formulaire

Jalon **09_asynchrone** - fiches F15, F16.

## Notre point de départ

Notre projet courant contient déjà le jalon 08_formulaire. On le complète, on ne le remplace pas.

La commande reste `flutter run -d chrome` et l’entrée reste `lib/main.dart`.

## Modifications à intégrer

1. Ajouter services/service_demande.dart depuis le code de référence : c’est une simulation sans réseau.
2. Garder le contrôleur, la clé, le validator et dispose. Ajouter _envoi et _erreur au State de la fiche.
3. Faire évoluer _envoyer en Future<void> : valider, activer _envoi, await le service, afficher ou renvoyer le résultat.
4. Dans catch, conserver le motif et afficher l’erreur. Dans finally, désactiver _envoi si mounted.
5. Désactiver les actions d’envoi pendant l’attente et afficher un indicateur.
6. Après await, garder les protections mounted ET route courante avant pop ; elles sont fournies dans la correction.
7. Pour la panne, passer simulerErreur: true à HelpMeApp dans main, puis utiliser R. Remettre false et redémarrer pour le succès.

## Fichiers concernés

- `lib/screens/detail_screen.dart` : faire évoluer ce fichier en conservant le reste.
- `lib/services/service_demande.dart` : ajouter ce fichier.

## Vérifier aussi ce qui fonctionnait déjà

- [ ] La validation et le contenu de la fiche sont conservés.
- [ ] Le chargement est visible et un double clic ne lance pas un second envoi.
- [ ] La panne garde le motif et réactive le bouton.
- [ ] Revenir pendant l’attente laisse le catalogue visible à la fin du délai.
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
```

</details>

<details>
<summary>Voir lib/services/service_demande.dart</summary>

```dart
import '../models/artisan.dart';

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
```

</details>
