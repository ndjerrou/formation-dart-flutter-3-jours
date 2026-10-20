// Le widget racine décrit le premier écran.
// flutter run -d chrome -t etapes_corrigees/01_bonjour.dart
import 'package:flutter/material.dart';

// Point d'entrée Dart ; runApp confie un premier widget à Flutter.
void main() => runApp(const CorrectionApp());

class CorrectionApp extends StatelessWidget {
  const CorrectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const BonjourApp();
  }
}

class BonjourApp extends StatelessWidget {
  const BonjourApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp fournit le thème, la navigation et les conventions Material.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('HelpMe - Bonjour')),
        body: const Center(child: Text('Bonjour Flutter !')),
      ),
    );
  }
}
