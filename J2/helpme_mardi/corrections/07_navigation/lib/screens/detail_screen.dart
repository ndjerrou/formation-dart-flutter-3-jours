import 'package:flutter/material.dart';

import '../models/artisan.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.artisan,
    this.simulerErreur = false,
  });
  final Artisan artisan;
  final bool simulerErreur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(artisan.nom)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              artisan.metier,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text('${artisan.tarif} €/h - tarif fictif'),
            const SizedBox(height: 12),
            OutlinedButton(
              key: const ValueKey('choisir'),
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
