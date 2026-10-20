import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'app.dart';
import 'configuration.dart';
import 'firebase_options.dart';
import 'data/local_store.dart';
import 'data/catalogue_repository.dart';
import 'data/session_repository.dart';
import 'data/demandes_repository.dart';
import 'state/catalogue_bloc.dart';
import 'state/demandes_bloc.dart';
import 'state/session_cubit.dart';
import 'state/langue_cubit.dart';
import 'services/notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (utiliserFirebase) {
      await Firebase.initializeApp(
        options: utiliserEmulateurs
            ? const FirebaseOptions(
                apiKey: 'demo-api-key',
                appId: '1:123:web:demo',
                messagingSenderId: '123',
                projectId: 'demo-helpme-j3',
              )
            : DefaultFirebaseOptions.currentPlatform,
      );
      if (utiliserEmulateurs) {
        await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
        FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8086);
      }
      if (!kIsWeb && !utiliserEmulateurs) {
        FlutterError.onError =
            FirebaseCrashlytics.instance.recordFlutterFatalError;
        PlatformDispatcher.instance.onError = (e, s) {
          FirebaseCrashlytics.instance.recordError(e, s, fatal: true);
          return true;
        };
      }
    }
    final store = await LocalStore.ouvrir();
    final catalogue = CatalogueRepository(store: store, url: urlCatalogue);
    final demandes = DemandesRepository(
      store: store,
      firestore: utiliserFirebase ? FirebaseFirestore.instance : null,
    );
    final session = SessionCubit(
      SessionRepository(auth: utiliserFirebase ? FirebaseAuth.instance : null),
    );
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CatalogueBloc(catalogue)..add(ChargerCatalogue()),
          ),
          BlocProvider(create: (_) => DemandesBloc(demandes)),
          BlocProvider(create: (_) => session),
          BlocProvider(create: (_) => LangueCubit(store)),
        ],
        child: HelpMeApp(notifications: Notifications()),
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      session.restaurer();
    });
  } catch (e) {
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SelectableText(
                'Démarrage impossible. Vérifier la préparation Firebase et relancer.\n$e',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
