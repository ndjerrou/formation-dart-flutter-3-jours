import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'configuration.dart';
import 'l10n/app_localizations.dart';
import 'state/demandes_bloc.dart';
import 'state/session_cubit.dart';
import 'state/langue_cubit.dart';
import 'services/notifications.dart';
import 'screens/catalogue_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/demandes_screen.dart';
import 'screens/connexion_screen.dart';
import 'screens/reglages_screen.dart';
import 'ui/commun.dart';

class HelpMeApp extends StatefulWidget {
  const HelpMeApp({
    super.key,
    required this.notifications,
    this.cheminInitial = '/',
  });
  final Notifications notifications;
  final String cheminInitial;
  @override
  State<HelpMeApp> createState() => _HelpMeAppState();
}

class _HelpMeAppState extends State<HelpMeApp> {
  late final GoRouter _router;
  StreamSubscription<String>? _clics;
  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: widget.cheminInitial,
      routes: [
        ShellRoute(
          builder: (context, state, enfant) => CadreApp(enfant: enfant),
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const CatalogueScreen(),
            ),
            GoRoute(
              path: '/demandes',
              builder: (context, state) => const DemandesScreen(),
            ),
            GoRoute(
              path: '/demandes/:id',
              builder: (context, state) =>
                  DemandesScreen(id: state.pathParameters['id']),
            ),
            GoRoute(
              path: '/reglages',
              builder: (context, state) =>
                  ReglagesScreen(notifications: widget.notifications),
            ),
          ],
        ),
        GoRoute(
          path: '/artisans/:id',
          builder: (context, state) => DetailScreen(
            id: int.tryParse(state.pathParameters['id'] ?? '') ?? -1,
          ),
        ),
        GoRoute(
          path: '/connexion',
          builder: (context, state) => const ConnexionScreen(),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: PanneauErreur(
          texte: AppLocalizations.of(context).notFound,
          reessayer: () => context.go('/'),
        ),
      ),
    );
    if (utiliserFirebase &&
        !utiliserEmulateurs &&
        !kIsWeb &&
        defaultTargetPlatform == TargetPlatform.iOS) {
      _clics = widget.notifications.ouvertures.listen(_router.go);
      widget.notifications.ecouter().then((c) {
        if (mounted && c != null) _router.go(c);
      });
    }
  }

  @override
  void dispose() {
    _clics?.cancel();
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocListener<SessionCubit, SessionState>(
    listenWhen: (a, b) => a.session?.uid != b.session?.uid,
    listener: (context, etat) =>
        context.read<DemandesBloc>().add(ObserverDemandes(etat.session)),
    child: BlocBuilder<LangueCubit, String>(
      builder: (context, langue) => MaterialApp.router(
        title: 'HelpMe',
        debugShowCheckedModeBanner: false,
        locale: Locale(langue),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: _router,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xfff7f6f2),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff21624f)),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xfff7f6f2)),
          cardTheme: CardThemeData(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ),
    ),
  );
}

class CadreApp extends StatelessWidget {
  const CadreApp({super.key, required this.enfant});
  final Widget enfant;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final uri = GoRouterState.of(context).uri.path;
    final selection = uri.startsWith('/demandes')
        ? 1
        : uri == '/reglages'
        ? 2
        : 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HelpMe',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: l.login,
            onPressed: () => context.push('/connexion'),
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              color: const Color(0xffe4efeb),
              child: Text(
                utiliserFirebase ? l.cloudMode : l.localMode,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            Expanded(child: enfant),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selection,
        onDestinationSelected: (i) =>
            context.go(['/', '/demandes', '/reglages'][i]),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.handyman_outlined),
            label: l.catalogue,
          ),
          NavigationDestination(
            icon: const Icon(Icons.receipt_long_outlined),
            label: l.requests,
          ),
          NavigationDestination(
            icon: const Icon(Icons.tune),
            label: l.settings,
          ),
        ],
      ),
    );
  }
}
