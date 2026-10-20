import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    routes: {
      '/': (context) => Scaffold(
        appBar: AppBar(title: const Text('Navigation classique')),
        body: Center(
          child: FilledButton(
            onPressed: () async {
              final resultat = await Navigator.of(context)
                  .pushNamed('/fiche', arguments: 2);
              if (context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('$resultat')));
              }
            },
            child: const Text('Ouvrir Sophie'),
          ),
        ),
      ),
      '/fiche': (context) {
        final id = ModalRoute.of(context)!.settings.arguments as int;
        return Scaffold(
          appBar: AppBar(title: Text('Artisan $id')),
          body: Center(
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop('Artisan $id choisi'),
              child: const Text('Choisir et revenir'),
            ),
          ),
        );
      },
    },
  ),
);
