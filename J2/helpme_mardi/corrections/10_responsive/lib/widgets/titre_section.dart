import 'package:flutter/material.dart';

// Même composant, textes différents : une configuration, pas un état mutable.
class TitreSection extends StatelessWidget {
  const TitreSection({super.key, required this.titre});
  final String titre;

  @override
  Widget build(BuildContext context) {
    return Text(titre, style: Theme.of(context).textTheme.titleLarge);
  }
}
