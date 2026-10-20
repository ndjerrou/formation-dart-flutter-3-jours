import 'package:firebase_auth/firebase_auth.dart';

import '../models/demande.dart';

class SessionRepository {
  SessionRepository({this.auth});
  final FirebaseAuth? auth;
  Future<Session?> restaurer() async {
    if (auth == null) return null;
    final utilisateur = await auth!.authStateChanges().first;
    if (utilisateur == null) return null;
    return _session(utilisateur);
  }

  Future<Session> _session(User user) async {
    final token = await user.getIdTokenResult(true);
    final claims = token.claims ?? {};
    return Session(
      uid: user.uid,
      email: user.email ?? '',
      artisanId: claims['role'] == 'prestataire'
          ? (claims['artisanId'] as num?)?.toInt()
          : null,
    );
  }

  Future<Session> connecter(
    String email,
    String password, {
    bool inscription = false,
  }) async {
    final credential = inscription
        ? await auth!.createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
        : await auth!.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
    return _session(credential.user!);
  }

  Session demonstration(bool prestataire) => Session(
    uid: prestataire ? 'prestataire-demo' : 'client-demo',
    email: prestataire ? 'gerard@demo.local' : 'client@demo.local',
    artisanId: prestataire ? 1 : null,
  );
  Future<void> deconnecter() async {
    await auth?.signOut();
  }
}
