class Tache {
  // Un identifiant est initialisé une fois par instance.
  final int id;

  // '_' protège le titre à la frontière de la bibliothèque.
  String _titre;
  bool terminee;

  // Ce constructeur est ordinaire : l'objet garde un état modifiable.
  // La liste d'initialisation prépare le champ avant le corps du constructeur.
  Tache({required this.id, required String titre, this.terminee = false})
    : _titre = titre.trim() {
    if (_titre.isEmpty) {
      throw ArgumentError('Le titre ne doit pas être vide.');
    }
  }

  // Le constructeur nommé crée un AUTRE objet à partir de données existantes.
  Tache.copie(Tache source)
    : this(id: source.id, titre: source.titre, terminee: source.terminee);

  // Un getter se lit tache.titre. Le client ne peut pas faire tache.titre = ...
  String get titre => _titre;

  void terminer() {
    terminee = true;
  }

  void rouvrir() {
    terminee = false;
  }

  void renommer(String nouveauTitre) {
    final titreNettoye = nouveauTitre.trim();
    if (titreNettoye.isEmpty) {
      throw ArgumentError('Le titre ne doit pas être vide.');
    }
    // Valider avant d'affecter conserve l'ancien titre en cas d'erreur.
    _titre = titreNettoye;
  }

  String decrire() {
    final caseACocher = terminee ? '[x]' : '[ ]';
    return '$caseACocher $id - $titre';
  }
}

// Un deuxième modèle pour comparer mutation et remplacement d'objet.
class TacheImmuable {
  final int id;
  final String titre;
  final bool terminee;

  const TacheImmuable({
    required this.id,
    required this.titre,
    this.terminee = false,
  });

  // L'objet courant reste intact. L'appelant doit conserver le nouvel objet.
  TacheImmuable avecStatut(bool nouveauStatut) {
    return TacheImmuable(id: id, titre: titre, terminee: nouveauStatut);
  }
}
