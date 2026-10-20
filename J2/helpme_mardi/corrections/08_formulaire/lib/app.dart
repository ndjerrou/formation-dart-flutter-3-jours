import 'package:flutter/material.dart';

import 'configuration.dart';
import 'screens/catalogue_screen.dart';

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
      title: titreApplication,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: CatalogueScreen(
        responsive: responsive,
        simulerErreur: simulerErreur,
      ),
    );
  }
}
