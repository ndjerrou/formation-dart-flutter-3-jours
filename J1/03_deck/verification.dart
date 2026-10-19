import 'corrections/atelier_1.dart';

void verifier(bool condition, String message) {
  if (!condition) throw StateError(message);
}

void main() {
  final deck = Deck();
  verifier(deck.length == 52, 'Paquet de 52 cartes');
  final cartes = <Card>[];
  for (final enseigne in ['cœur', 'carreau', 'trèfle', 'pique']) {
    final selection = deck.cardsWithSuit(enseigne);
    verifier(selection.length == 13, '13 cartes de $enseigne');
    verifier(selection.every((c) => c.suit == enseigne), 'Filtre par enseigne');
    cartes.addAll(selection);
  }
  verifier(
    cartes.map((c) => '${c.rank}/${c.suit}').toSet().length == 52,
    'Chaque carte est unique',
  );
  verifier(deck.length == 52, 'Filtrer ne retire rien');
  deck.cardsWithSuit('cœur').clear();
  verifier(deck.length == 52, 'La sélection est une autre liste');
  verifier(deck.deal(0).isEmpty && deck.length == 52, 'Distribution de zéro');
  for (final count in [-1, 53]) {
    var refuse = false;
    try {
      deck.deal(count);
    } on ArgumentError {
      refuse = true;
    }
    verifier(refuse && deck.length == 52, 'Demande invalide sans mutation');
  }
  deck.shuffle();
  final main = deck.deal(5);
  verifier(main.length == 5 && deck.length == 47, 'Distribution de cinq');
  final reste = deck.deal(47);
  verifier(deck.length == 0 && reste.length == 47, 'Distribution du reste');
  final ensemble = [...main, ...reste];
  verifier(
    cartes.every((c) => ensemble.any((autre) => identical(c, autre))),
    'Le mélange conserve les mêmes objets',
  );

  final premier = Deck();
  final second = Deck();
  verifier(premier.removeCard('As', 'pique'), 'Retrait présent');
  verifier(!premier.removeCard('As', 'pique'), 'Retrait absent');
  verifier(
    premier.length == 51 && second.length == 52,
    'Instances indépendantes',
  );
  print('Deck : vérifications réussies.');
}
