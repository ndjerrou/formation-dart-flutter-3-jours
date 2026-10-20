enum StatutDemande { pending, accepted, refused }

class Demande {
  const Demande({
    required this.id,
    required this.clientUid,
    required this.artisanId,
    required this.artisanNom,
    required this.motif,
    required this.date,
    this.statut = StatutDemande.pending,
    this.synchronisee = true,
  });
  final String id, clientUid, artisanNom, motif;
  final int artisanId;
  final DateTime date;
  final StatutDemande statut;
  final bool synchronisee;
  Demande avecStatut(StatutDemande valeur) => Demande(
    id: id,
    clientUid: clientUid,
    artisanId: artisanId,
    artisanNom: artisanNom,
    motif: motif,
    date: date,
    statut: valeur,
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'clientUid': clientUid,
    'artisanId': artisanId,
    'artisanNom': artisanNom,
    'motif': motif,
    'date': date.toUtc().toIso8601String(),
    'statut': statut.name,
  };
  factory Demande.fromJson(
    Map<String, dynamic> j, {
    bool synchronisee = true,
  }) => Demande(
    id: j['id'] as String,
    clientUid: j['clientUid'] as String,
    artisanId: j['artisanId'] as int,
    artisanNom: j['artisanNom'] as String,
    motif: j['motif'] as String,
    date: DateTime.parse(j['date'] as String),
    statut: StatutDemande.values.byName(j['statut'] as String),
    synchronisee: synchronisee,
  );
}

class Session {
  const Session({required this.uid, required this.email, this.artisanId});
  final String uid, email;
  final int? artisanId;
  bool get prestataire => artisanId != null;
}
