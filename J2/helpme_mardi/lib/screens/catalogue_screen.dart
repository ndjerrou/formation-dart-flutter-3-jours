import 'package:flutter/material.dart';

import '../configuration.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({
    super.key,
    this.responsive = true,
    this.simulerErreur = false,
  });
  final bool responsive;
  final bool simulerErreur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(titreApplication)),
      body: const Center(child: Text(messageAccueil)),
    );
  }
}
