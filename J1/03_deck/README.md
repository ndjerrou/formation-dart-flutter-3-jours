# Atelier 1 - Un paquet de cartes

Représenter un paquet de 52 cartes et manipuler des instances de classe.
Cet atelier construit le paquet et ses opérations ; il ne définit pas
les règles du poker ou d'un autre jeu.

| Terme du code | Signification |
| --- | --- |
| `Card` | Une carte |
| `Deck` | Un paquet de cartes |
| `rank` | La valeur : As, 2, 3, ... Valet, Dame, Roi |
| `suit` | L'enseigne : cœur, carreau, trèfle ou pique |
| `shuffle` | Mélanger |
| `deal` | Distribuer |

## Travail à faire

Partir de [atelier_1_depart.dart](exercices/atelier_1_depart.dart).

1. Dans le constructeur de `Deck`, créer les 13 valeurs pour chacune des
   quatre enseignes : le paquet doit contenir 52 objets `Card`.
2. Afficher les cartes. Expliquer le rôle de `toString()` et `@override`.
3. Ecrire `shuffle()` : mélanger la liste existante sans changer sa taille.
4. Ecrire `cardsWithSuit(String suit)` : renvoyer les cartes d'une enseigne
   sans les retirer du paquet. Un paquet neuf a 13 cartes par enseigne.
5. Ecrire `deal(int count)` : renvoyer les premières cartes puis les retirer
   du paquet. Refuser une quantité négative ou supérieure au stock avant
   toute modification.
6. Ecrire `removeCard(String rank, String suit)` : retirer une carte précise,
   renvoyer `true` si elle existait, sinon `false`.

## Essais à faire

- Créer deux paquets : retirer une carte du premier ne change pas le second.
- Filtrer les cœurs : 13 cartes renvoyées, 52 encore dans le paquet neuf.
- Distribuer 5 cartes : main de 5, paquet de 47.
- Retirer deux fois l'As de pique d'un paquet neuf : `true` puis `false`.
- Demander une distribution impossible : erreur et paquet inchangé.

Depuis la racine :

```bash
dart run J1/03_deck/exercices/atelier_1_depart.dart
dart run J1/03_deck/corrections/atelier_1.dart
dart run J1/03_deck/verification.dart
```

La correction mélange le paquet : les cartes distribuées peuvent changer
à chaque exécution, mais les quantités doivent rester correctes.
