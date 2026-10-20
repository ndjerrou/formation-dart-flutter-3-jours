import 'package:firebase_core/firebase_core.dart';

// Remplacé par flutterfire configure lors de la préparation Firebase.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => throw StateError(
    'Exécutez flutterfire configure avant de lancer USE_FIREBASE=true.',
  );
}
