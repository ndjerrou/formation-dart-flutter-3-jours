import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:go_router/go_router.dart';

import '../configuration.dart';
import '../l10n/app_localizations.dart';
import '../state/langue_cubit.dart';
import '../state/session_cubit.dart';
import '../services/notifications.dart';

class ReglagesScreen extends StatefulWidget {
  const ReglagesScreen({super.key, required this.notifications});
  final Notifications notifications;
  @override
  State<ReglagesScreen> createState() => _ReglagesScreenState();
}

class _ReglagesScreenState extends State<ReglagesScreen> {
  String? _jeton;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final session = context.watch<SessionCubit>().state.session;
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(l.settings, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 20),
        Text(l.language),
        const SizedBox(height: 8),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'fr', label: Text('Français')),
            ButtonSegment(value: 'en', label: Text('English')),
          ],
          selected: {context.watch<LangueCubit>().state},
          onSelectionChanged: (s) =>
              context.read<LangueCubit>().changer(s.single),
        ),
        const SizedBox(height: 24),
        Text(l.connectedAs, style: Theme.of(context).textTheme.titleMedium),
        if (session != null) ...[
          Text(session.email),
          Text(session.prestataire ? l.roleProvider : l.roleClient),
          TextButton(
            key: const ValueKey('deconnexion'),
            onPressed: () => context.read<SessionCubit>().deconnecter(),
            child: Text(l.logout),
          ),
        ] else
          FilledButton(
            onPressed: () => context.push('/connexion'),
            child: Text(l.login),
          ),
        const Divider(height: 40),
        FilledButton.icon(
          onPressed: () async {
            if (!utiliserFirebase ||
                utiliserEmulateurs ||
                kIsWeb ||
                defaultTargetPlatform != TargetPlatform.iOS) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l.notificationUnavailable)),
              );
              return;
            }
            try {
              final jeton = await widget.notifications.activer();
              if (!context.mounted) return;
              setState(() => _jeton = jeton);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    jeton == null
                        ? l.notificationsDenied
                        : l.notificationsReady,
                  ),
                ),
              );
            } catch (_) {
              if (context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(l.errorGeneric)));
              }
            }
          },
          icon: const Icon(Icons.notifications_outlined),
          label: Text(l.permissions),
        ),
        if (_jeton != null && outilsProfesseur) ...[
          SelectableText(_jeton!),
          TextButton(
            onPressed: () => Clipboard.setData(ClipboardData(text: _jeton!)),
            child: const Text('Copier le jeton FCM'),
          ),
        ],
        if (outilsProfesseur && utiliserFirebase && !kIsWeb)
          TextButton(
            onPressed: () => FirebaseCrashlytics.instance.recordError(
              StateError('Démonstration J3 non fatale'),
              StackTrace.current,
              fatal: false,
            ),
            child: const Text('Démo professeur : erreur non fatale'),
          ),
        const SizedBox(height: 24),
        Text(l.about),
      ],
    );
  }
}
