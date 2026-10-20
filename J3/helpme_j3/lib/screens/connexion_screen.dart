import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../configuration.dart';
import '../l10n/app_localizations.dart';
import '../state/session_cubit.dart';

class ConnexionScreen extends StatefulWidget {
  const ConnexionScreen({super.key});
  @override
  State<ConnexionScreen> createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {
  final _email = TextEditingController(), _password = TextEditingController();
  final _cle = GlobalKey<FormState>();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.login)),
      body: BlocConsumer<SessionCubit, SessionState>(
        listener: (context, etat) {
          if (etat.session != null) context.go('/');
        },
        builder: (context, etat) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Form(
                key: _cle,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.handyman_outlined, size: 64),
                    const SizedBox(height: 24),
                    if (!utiliserFirebase) ...[
                      Text(
                        l.localAccounts,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        key: const ValueKey('demo_client'),
                        onPressed: () =>
                            context.read<SessionCubit>().demo(false),
                        child: Text(l.clientDemo),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        key: const ValueKey('demo_prestataire'),
                        onPressed: () =>
                            context.read<SessionCubit>().demo(true),
                        child: Text(l.providerDemo),
                      ),
                    ] else ...[
                      TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: l.email),
                        validator: (v) => v != null && v.contains('@')
                            ? null
                            : l.passwordError,
                      ),
                      TextFormField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(labelText: l.password),
                        validator: (v) =>
                            v != null && v.length >= 6 ? null : l.passwordError,
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: etat.attente
                            ? null
                            : () => _connecter(false),
                        child: Text(l.signIn),
                      ),
                      TextButton(
                        onPressed: etat.attente ? null : () => _connecter(true),
                        child: Text(l.register),
                      ),
                      if (etat.erreur) Text(l.errorGeneric),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _connecter(bool inscription) {
    if (_cle.currentState?.validate() == true) {
      context.read<SessionCubit>().connecter(
        _email.text.trim(),
        _password.text,
        inscription: inscription,
      );
    }
  }
}
