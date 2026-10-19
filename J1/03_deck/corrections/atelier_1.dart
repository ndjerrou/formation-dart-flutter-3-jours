// Atelier 1 — Jeu de cartes : découvrir les classes en Dart.
// Depuis ce dossier : dart run atelier_1.dart
// Ou copier tout ce fichier dans DartPad : aucune dépendance nécessaire.
// ignore_for_file: avoid_print

// Une classe décrit un modèle ; chaque objet Card représente UNE carte.
class Card {
  // Les attributs décrivent l'état de la carte.
  // final interdit de leur attribuer une autre valeur après la construction.
  final String rank;
  final String suit;

  // Le constructeur initialise les attributs avec les valeurs reçues.
  // this.rank est un raccourci pour affecter le paramètre à l'attribut rank.
  Card(this.rank, this.suit);

  // toString existe déjà sur Object, dont toutes les classes Dart héritent.
  // @override indique que nous personnalisons cette méthode.
  // Ainsi, print(carte) affiche une description lisible.
  @override
  String toString() {
    return '$rank de $suit';
  }
}

// Un Deck contient plusieurs objets Card : c'est la composition.
class Deck {
  // Le préfixe _ rend la liste privée à la bibliothèque Dart (ici, ce fichier).
  // final empêche de remplacer la liste, mais son contenu peut changer.
  final List<Card> _cards = [];

  // Le constructeur crée automatiquement les 52 cartes du nouveau paquet.
  Deck() {
    final ranks = [
      'As',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      'Valet',
      'Dame',
      'Roi',
    ];
    // suit désigne l'enseigne : cœur, carreau, trèfle ou pique.
    // On n'utilise pas seulement rouge/noir : il faut quatre enseignes.
    final suits = ['cœur', 'carreau', 'trèfle', 'pique'];

    // Pour chaque enseigne, on crée les 13 valeurs : 4 × 13 = 52 objets.
    for (final suit in suits) {
      for (final rank in ranks) {
        _cards.add(Card(rank, suit));
      }
    }
  }

  // Un getter se lit comme un attribut : deck.length, sans parenthèses.
  // Il permet de consulter la taille sans exposer la liste interne.
  int get length => _cards.length;

  // void signifie que cette méthode ne renvoie pas de résultat.
  void printCards() {
    for (final card in _cards) {
      // print utilise automatiquement la méthode toString de Card.
      print(card);
    }
  }

  // shuffle mélange la liste existante ; le nombre de cartes ne change pas.
  void shuffle() {
    _cards.shuffle();
  }

  // Cette méthode renvoie les cartes d'une enseigne sans les retirer.
  List<Card> cardsWithSuit(String suit) {
    // where conserve les cartes pour lesquelles la condition vaut true.
    // (card) => ... est une fonction anonyme écrite sous forme courte.
    // toList transforme le résultat du filtre en une nouvelle liste.
    return _cards.where((card) => card.suit == suit).toList();
  }

  // Distribuer retire les premières cartes du paquet et les renvoie.
  List<Card> deal(int count) {
    // On vérifie AVANT de modifier le paquet pour éviter un état incomplet.
    if (count < 0 || count > _cards.length) {
      throw ArgumentError.value(
        count,
        'count',
        'Le nombre doit être compris entre 0 et ${_cards.length}.',
      );
    }

    // sublist crée une nouvelle liste ; la borne de fin est exclue.
    final hand = _cards.sublist(0, count);
    // removeRange enlève ces mêmes cartes du paquet d'origine.
    _cards.removeRange(0, count);
    return hand;
  }

  // Retirer une carte précise : true si elle existait, false sinon.
  bool removeCard(String rank, String suit) {
    // On compare les attributs, car deux objets Card distincts ne sont pas
    // automatiquement égaux même s'ils ont les mêmes valeurs.
    final index = _cards.indexWhere(
      (card) => card.rank == rank && card.suit == suit,
    );

    // indexWhere renvoie -1 lorsqu'aucune carte ne correspond.
    if (index == -1) {
      return false;
    }

    _cards.removeAt(index);
    return true;
  }
}

// main est le point d'entrée : Dart commence l'exécution ici.
void main() {
  print('=== Atelier 1 — Jeu de cartes ===');

  // 1. Construire un objet Deck appelle son constructeur.
  final deck = Deck();
  print('\n1. Nouveau paquet : ${deck.length} cartes');
  deck.printCards();

  // 2. Filtrer sans modifier : on obtient les 13 cartes de cœur.
  final hearts = deck.cardsWithSuit('cœur');
  print('\n2. Cartes de cœur (${hearts.length}) :');
  print(hearts);
  print('Le paquet contient toujours ${deck.length} cartes.');

  // 3. Retirer une carte connue AVANT le mélange et la distribution.
  // Cet ordre garantit qu'elle est encore présente pour la démonstration.
  final removed = deck.removeCard('As', 'pique');
  print('\n3. As de pique retiré : $removed');
  print('Cartes restantes : ${deck.length}'); // 51
  print('Deuxième retrait : ${deck.removeCard('As', 'pique')}'); // false

  // 4. Mélanger modifie l'ordre des cartes du même objet deck.
  deck.shuffle();
  print('\n4. Paquet mélangé : ${deck.length} cartes');

  // 5. Distribuer 5 cartes : la main les reçoit, le paquet les perd.
  final hand = deck.deal(5);
  print('\n5. Main du joueur (${hand.length} cartes) :');
  print(hand);
  print('Cartes restantes : ${deck.length}'); // 46

  // 6. Une exception signale une demande impossible.
  // try/catch permet de l'expliquer sans interrompre brutalement le programme.
  try {
    deck.deal(100);
  } on ArgumentError catch (error) {
    print('\n6. Distribution refusée : ${error.message}');
  }
  print('Après le refus : ${deck.length} cartes'); // Toujours 46
}
