import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/session_repository.dart';
import '../models/demande.dart';

class SessionState {
  const SessionState({this.session, this.attente = false, this.erreur = false});
  final Session? session;
  final bool attente, erreur;
}

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this.repository) : super(const SessionState());
  final SessionRepository repository;
  Future<void> restaurer() async {
    try {
      emit(SessionState(session: await repository.restaurer()));
    } catch (_) {
      emit(const SessionState(erreur: true));
    }
  }

  void demo(bool prestataire) =>
      emit(SessionState(session: repository.demonstration(prestataire)));
  Future<void> connecter(
    String email,
    String password, {
    bool inscription = false,
  }) async {
    emit(const SessionState(attente: true));
    try {
      emit(
        SessionState(
          session: await repository.connecter(
            email,
            password,
            inscription: inscription,
          ),
        ),
      );
    } catch (_) {
      emit(const SessionState(erreur: true));
    }
  }

  Future<void> deconnecter() async {
    await repository.deconnecter();
    emit(const SessionState());
  }
}
