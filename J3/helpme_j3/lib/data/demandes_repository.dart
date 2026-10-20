import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/artisan.dart';
import '../models/demande.dart';
import 'local_store.dart';

class DemandesRepository {
  DemandesRepository({required this.store, this.firestore});
  final LocalStore store;
  final FirebaseFirestore? firestore;
  final _changements = StreamController<void>.broadcast();
  String nouvelId() =>
      '${DateTime.now().microsecondsSinceEpoch}_${Random.secure().nextInt(1 << 30)}';
  Future<void> creer(
    Session session,
    Artisan artisan,
    String motif,
    String id,
  ) async {
    if (session.prestataire || motif.trim().length < 5) {
      throw StateError('Demande invalide');
    }
    final d = Demande(
      id: id,
      clientUid: session.uid,
      artisanId: artisan.id,
      artisanNom: artisan.nom,
      motif: motif.trim(),
      date: DateTime.now(),
    );
    if (firestore != null) {
      await firestore!.collection('demandes').doc(d.id).set(d.toJson());
    } else {
      await store.sauverDemande(d);
      _changements.add(null);
    }
  }

  Stream<List<Demande>> observer(Session session) {
    if (firestore != null) {
      Query<Map<String, dynamic>> query = firestore!.collection('demandes');
      query = session.prestataire
          ? query.where('artisanId', isEqualTo: session.artisanId)
          : query.where('clientUid', isEqualTo: session.uid);
      return query
          .snapshots(includeMetadataChanges: true)
          .take(1)
          .map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Demande.fromJson(
                    doc.data(),
                    synchronisee: !doc.metadata.hasPendingWrites,
                  ),
                )
                .toList(),
          );
    }
    // asyncExpand évite un trou entre la lecture initiale et l'abonnement.
    return _localStream(session).take(1);
  }

  Stream<List<Demande>> _localStream(Session session) {
    late StreamController<List<Demande>> controller;
    StreamSubscription<void>? abonnement;
    Future<void> lire() async {
      try {
        final demandes = (await store.lireDemandes())
            .where(
              (d) => session.prestataire
                  ? d.artisanId == session.artisanId
                  : d.clientUid == session.uid,
            )
            .toList();
        if (!controller.isClosed) controller.add(demandes);
      } catch (e, s) {
        if (!controller.isClosed) controller.addError(e, s);
      }
    }

    controller = StreamController<List<Demande>>(
      onListen: () {
        abonnement = _changements.stream.listen((_) => lire());
        lire();
      },
      onCancel: () async {
        await abonnement?.cancel();
      },
    );
    return controller.stream;
  }

  Future<void> changerStatut(
    Session session,
    Demande demande,
    StatutDemande statut,
  ) async {
    if (!session.prestataire ||
        session.artisanId != demande.artisanId ||
        demande.statut != StatutDemande.pending ||
        statut == StatutDemande.pending) {
      throw StateError('Transition interdite');
    }
    if (firestore != null) {
      final ref = firestore!.collection('demandes').doc(demande.id);
      await firestore!.runTransaction((tx) async {
        final snapshot = await tx.get(ref);
        if (snapshot.data()?['statut'] != 'pending') {
          throw StateError('Déjà traitée');
        }
        tx.update(ref, {'statut': statut.name});
      });
    } else {
      await store.transitionDemande(demande.id, statut);
      _changements.add(null);
    }
  }

  Future<void> fermer() => _changements.close();
}
