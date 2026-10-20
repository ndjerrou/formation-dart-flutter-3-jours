// Le formulaire valide la saisie ; le contrôleur est libéré dans dispose.
// flutter run -d chrome -t etapes_corrigees/07_formulaire.dart
import 'package:flutter/material.dart';

void main() => runApp(const CorrectionApp());

class CorrectionApp extends StatelessWidget {
  const CorrectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: FormulaireAtelier());
  }
}

class FormulaireAtelier extends StatefulWidget {
  const FormulaireAtelier({super.key});
  @override
  State<FormulaireAtelier> createState() => _FormulaireAtelierState();
}

class _FormulaireAtelierState extends State<FormulaireAtelier> {
  final _cle = GlobalKey<FormState>();
  final _motif = TextEditingController();

  @override
  void dispose() {
    _motif.dispose();
    super.dispose();
  }

  void _valider() {
    if (_cle.currentState?.validate() != true) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Motif valide : ${_motif.text.trim()}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HelpMe - Formulaire')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _cle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _motif,
                decoration: const InputDecoration(labelText: 'Motif'),
                validator: (valeur) {
                  if (valeur == null || valeur.trim().length < 5) {
                    return 'Indique au moins 5 caractères.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FilledButton(onPressed: _valider, child: const Text('Valider')),
            ],
          ),
        ),
      ),
    );
  }
}
