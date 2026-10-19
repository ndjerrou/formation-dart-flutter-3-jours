// ATELIER 1 — DÉPART ÉLÈVE : un paquet de cartes, pas encore une règle de jeu.
// dart run atelier_1_depart.dart — le fichier fonctionne avant les TODO.
// ignore_for_file: avoid_print

class Card {
  final String rank;
  final String suit;
  Card(this.rank, this.suit);

  @override
  String toString() => '$rank de $suit';
}

class Deck {
  final List<Card> _cards = [];

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
    final suits = ['cœur', 'carreau', 'trèfle', 'pique'];
    // TODO 1 : deux boucles imbriquées, puis _cards.add(Card(rank, suit)).
    // Ce print provisoire garde les listes visibles avant la construction.
    print('${ranks.length} valeurs × ${suits.length} enseignes à construire.');
  }

  int get length => _cards.length;

  void printCards() {
    for (final card in _cards) {
      print(card);
    }
  }

  void shuffle() {
    // TODO 2 : mélanger la liste existante.
  }

  List<Card> cardsWithSuit(String suit) {
    // TODO 3 : filtrer par suit, sans retirer les cartes du paquet.
    return [];
  }

  List<Card> deal(int count) {
    // TODO 4 : vérifier count, créer une main avec sublist, retirer avec removeRange.
    // En cas de count invalide, lancer ArgumentError avant toute modification.
    return [];
  }

  bool removeCard(String rank, String suit) {
    // TODO 5 : trouver l'index, retourner false si absent, sinon retirer et true.
    return false;
  }
}

void main() {
  final deck = Deck();
  print('Taille actuelle : ${deck.length}'); // Cible après TODO 1 : 52.
  deck.printCards();
  // Ajouter les essais au fur et à mesure, selon la fiche élève.
}
