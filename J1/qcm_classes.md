# QCM Dart - Classes et instances avant l’atelier du deck

**30 questions progressives - une seule bonne réponse par question.**

Les questions portent sur les notions du matin, avec un accent sur les classes : instances, champs, constructeurs, méthodes, types, booléens, `var`, `final`, `const`, références, listes, maps et imports.

## Consignes

- Choisir une réponse parmi A, B, C et D pour chaque question.
- Chaque question est indépendante : une classe peut être définie différemment d’une question à l’autre.
- Les extraits sans `main` montrent uniquement une déclaration à examiner.
- Quand la question demande un affichage, prédire le résultat avant d’exécuter le code.
- En cas d’erreur, distinguer le refus à l’analyse/compilation de l’erreur pendant l’exécution.
- Le corrigé expliqué se trouve après les 30 questions.

**Barème :** 1 point par bonne réponse, 0 sinon. Total : 30 points.

## Grille de réponses

| Question | Réponse | Question | Réponse | Question | Réponse |
| -------- | ------- | -------- | ------- | -------- | ------- |
| 1        |         | 11       |         | 21       |         |
| 2        |         | 12       |         | 22       |         |
| 3        |         | 13       |         | 23       |         |
| 4        |         | 14       |         | 24       |         |
| 5        |         | 15       |         | 25       |         |
| 6        |         | 16       |         | 26       |         |
| 7        |         | 17       |         | 27       |         |
| 8        |         | 18       |         | 28       |         |
| 9        |         | 19       |         | 29       |         |
| 10       |         | 20       |         | 30       |         |

## Partie 1 - Reconnaître et comprendre

### Question 1

Dans ce programme, quelle proposition décrit correctement Tache et travail ?

```dart
class Tache {
  String titre;
  Tache(this.titre);
}
void main() {
  final travail = Tache('Réviser Dart');
}
```

- [ ] **A.** Tache et travail sont deux noms de la même classe.
- [ ] **B.** travail est une sous-classe créée automatiquement.
- [ ] **C.** Tache est une classe et un type ; travail référence une instance de Tache.
- [ ] **D.** Tache est une variable ; travail est une classe.

### Question 2

Combien d’instances de Joueur sont créées par ce programme ?

```dart
class Joueur {
  String pseudo;
  Joueur(this.pseudo);
}
void main() {
  final lina = Joueur('Lina');
  final sami = Joueur('Sami');
  final autreNom = lina;
}
```

- [ ] **A.** Deux.
- [ ] **B.** Quatre.
- [ ] **C.** Une.
- [ ] **D.** Trois.

### Question 3

Quelle proposition identifie correctement les éléments de ajouterPoints ?

```dart
class Joueur {
  int score = 0;
  void ajouterPoints(int points) {
    final nouveauScore = score + points;
    score = nouveauScore;
  }
}
```

- [ ] **A.** Les trois sont des champs conservés dans chaque Joueur.
- [ ] **B.** points est le constructeur de Joueur.
- [ ] **C.** nouveauScore est partagé automatiquement par tous les joueurs.
- [ ] **D.** score est un champ ; points un paramètre ; nouveauScore une variable locale.

### Question 4

Quelle affirmation est exacte à propos du constructeur de Tache ?

```dart
class Tache {
  final String titre;
  Tache(this.titre);
}
```

- [ ] **A.** Il est une méthode que l’on rappelle avec tache.Tache(...).
- [ ] **B.** Il initialise l’instance lors de sa création et n’a pas de type de retour.
- [ ] **C.** Il doit être déclaré avec le type de retour void.
- [ ] **D.** Il s’exécute à chaque lecture de titre.

### Question 5

Que signifie this.titre dans ce constructeur ?

```dart
class Tache {
  final String titre;
  Tache({required this.titre});
}
```

- [ ] **A.** Afficher le titre dans la console.
- [ ] **B.** Créer une variable globale titre.
- [ ] **C.** Créer une deuxième instance contenant uniquement le titre.
- [ ] **D.** Initialiser le champ titre du nouvel objet avec l’argument reçu.

### Question 6

Quelle ligne construit une tâche non terminée en respectant le constructeur ?

```dart
class Tache {
  final String titre;
  bool terminee;
  Tache({required this.titre, this.terminee = false});
}
```

- [ ] **A.** Tache();
- [ ] **B.** Tache('Lire');
- [ ] **C.** Tache(titre: 'Lire');
- [ ] **D.** Tache(titre: 'Lire', terminee: true);

### Question 7

Quel appel est valide avec cette déclaration ?

```dart
class Joueur {
  final String? pseudo;
  Joueur({required this.pseudo});
}
```

- [ ] **A.** Joueur();
- [ ] **B.** Joueur(pseudo: null);
- [ ] **C.** Joueur(pseudo: 12);
- [ ] **D.** Joueur('Lina');

### Question 8

Qu’affiche ce programme ?

```dart
class Joueur {
  int score = 0;
  void ajouterPoints(int points) { score += points; }
}
void main() {
  final a = Joueur();
  final b = Joueur();
  a.ajouterPoints(3);
  print('${a.score}/${b.score}');
}
```

- [ ] **A.** 3/0
- [ ] **B.** 0/3
- [ ] **C.** Le programme est refusé parce que a est final.
- [ ] **D.** 3/3

### Question 9

Qu’apparaît dans la console quand ce programme s’exécute ?

```dart
class Tache {
  final String titre;
  Tache(this.titre);
  String decrire() { return 'Tâche : $titre'; }
}
void main() {
  final t = Tache('Lire');
  t.decrire();
}
```

- [ ] **A.** Une erreur : une méthode ne peut pas renvoyer String.
- [ ] **B.** Lire
- [ ] **C.** Rien : la valeur renvoyée n’est pas affichée.
- [ ] **D.** Tâche : Lire

### Question 10

Quelles valeurs sont affichées, dans l’ordre ?

```dart
class Tache {
  bool terminee = false;
  bool aFaire(bool urgent) { return !terminee && urgent; }
}
void main() {
  final t = Tache();
  print(t.aFaire(true));
  t.terminee = true;
  print(t.aFaire(true));
}
```

- [ ] **A.** false puis true
- [ ] **B.** false puis false
- [ ] **C.** true puis true
- [ ] **D.** true puis false

## Partie 2 - Lire le code et expliquer les effets

### Question 11

Que se passe-t-il si l’on tente d’exécuter ce programme tel quel ?

```dart
class Tache {
  final String titre;
  Tache(this.titre);
}
void main() {
  var t = Tache('Lire');
  t = 'Coder';
  print(t);
}
```

- [ ] **A.** Il est refusé : t est de type Tache, pas String.
- [ ] **B.** Il crée automatiquement Tache('Coder').
- [ ] **C.** Il remplace seulement le champ titre de l’objet.
- [ ] **D.** Il affiche Coder : var autorise tous les types.

### Question 12

Quelle proposition est correcte ?

```dart
class Tache {
  bool terminee = false;
  void terminer() { terminee = true; }
}
void main() {
  final t = Tache();
  t.terminer();
  print(t.terminee);
}
```

- [ ] **A.** Il affiche false ; final annule les modifications des champs.
- [ ] **B.** Il affiche true ; final bloque la réaffectation de t, pas cette mutation.
- [ ] **C.** Il est refusé ; une variable final ne peut appeler aucune méthode.
- [ ] **D.** Il transforme automatiquement Tache() en construction const.

### Question 13

Quel résultat obtient-on ?

```dart
class Tache {
  final int id;
  Tache(this.id);
}
void main() {
  final a = Tache(1);
  final b = Tache(2);
  print('${a.id}/${b.id}');
}
```

- [ ] **A.** 1/1 : final partage la première valeur.
- [ ] **B.** 1/2 : chaque instance initialise son propre champ une fois.
- [ ] **C.** Erreur : un champ final ne peut pas être initialisé par un constructeur.
- [ ] **D.** 2/2 : la seconde création remplace la première.

### Question 14

A quel moment l’opération pose-t-elle problème ?

```dart
void main() {
  final titres = const <String>['Lire'];
  titres.add('Coder');
  print(titres.length);
}
```

- [ ] **A.** A l’analyse : les listes n’ont pas de méthode add.
- [ ] **B.** Elle crée une nouvelle liste et affiche 2.
- [ ] **C.** Elle réussit : seule la variable est final.
- [ ] **D.** A l’exécution : add est refusé par la liste constante.

### Question 15

Ce programme est-il valide tel quel ?

```dart
class Etiquette {
  final String texte;
  const Etiquette(this.texte);
}
void main() {
  final x = const Etiquette('Urgent');
  const y = x;
  print(y.texte);
}
```

- [ ] **A.** Oui : const à droite transforme toujours x en variable const.
- [ ] **B.** Oui : toute variable final est une constante de compilation.
- [ ] **C.** Non : x est final ; il ne peut pas servir ici de variable constante.
- [ ] **D.** Non : une classe ne peut pas déclarer de constructeur const.

### Question 16

Pourquoi cette déclaration est-elle refusée ?

```dart
class Tache {
  final String titre;
  bool terminee;
  const Tache(this.titre, {this.terminee = false});
}
```

- [ ] **A.** Le champ terminee est modifiable ; ce constructeur const est incompatible.
- [ ] **B.** Un bool ne peut pas être un champ de classe.
- [ ] **C.** Un constructeur const ne peut pas recevoir de paramètres.
- [ ] **D.** Il faut ajouter final devant le nom du constructeur.

### Question 17

Quelle proposition est correcte ?

```dart
class Etiquette {
  final String texte;
  const Etiquette(this.texte);
}
void main() {
  final saisie = DateTime.now().toString();
  final e = Etiquette(saisie);
  print(e.texte == saisie);
}
```

- [ ] **A.** Il affiche false : le constructeur efface les valeurs non constantes.
- [ ] **B.** Il est refusé : tous les appels de ce constructeur doivent être const.
- [ ] **C.** Il est refusé : saisie doit être connue à la compilation.
- [ ] **D.** Il affiche true : cet appel ordinaire accepte une valeur calculée au runtime.

### Question 18

Quelles valeurs sont affichées, dans l’ordre ? identical compare le même objet.

```dart
class Etiquette {
  final String texte;
  const Etiquette(this.texte);
}
void main() {
  const a = Etiquette('Urgent');
  final b = const Etiquette('Urgent');
  final c = Etiquette('Urgent');
  print(identical(a, b));
  print(identical(a, c));
}
```

- [ ] **A.** true puis true
- [ ] **B.** true puis false
- [ ] **C.** false puis false
- [ ] **D.** false puis true

### Question 19

Qu’affiche ce programme ?

```dart
class Etat {
  final bool terminee;
  const Etat(this.terminee);
  Etat terminer() { return Etat(true); }
}
void main() {
  final depart = Etat(false);
  final arrivee = depart.terminer();
  print('${depart.terminee}/${arrivee.terminee}');
}
```

- [ ] **A.** false/true
- [ ] **B.** Erreur : la méthode ne peut pas créer un autre Etat.
- [ ] **C.** false/false
- [ ] **D.** true/true

### Question 20

Comment nommer correctement les deux syntaxes utilisées dans main ?

```dart
class Tache {
  final String titre;
  Tache({required this.titre});
  Tache.brouillon() : this(titre: 'Sans titre');
}
void main() {
  final a = Tache.brouillon();
  final b = Tache(titre: 'Lire');
}
```

- [ ] **A.** brouillon et titre: sont tous les deux des constructeurs nommés.
- [ ] **B.** brouillon est un champ ; titre: est un appel de méthode.
- [ ] **C.** brouillon est un constructeur nommé ; titre: fournit un argument nommé.
- [ ] **D.** Les deux appels sont interdits : une classe ne peut avoir qu’un constructeur.

## Partie 3 - Manipuler les références et préparer le deck

### Question 21

Pourquoi ce programme est-il refusé ?

```dart
class Tache {
  final String titre;
  Tache(this.titre);
}
void main() {
  final taches = <Tache>[];
  taches.add('Lire');
}
```

- [ ] **A.** Une liste ne peut pas contenir des objets créés avec une classe.
- [ ] **B.** List<Tache> attend une Tache, mais add reçoit un String.
- [ ] **C.** Une liste Dart doit obligatoirement avoir une taille fixe.
- [ ] **D.** Une liste final ne peut recevoir aucun élément.

### Question 22

Qu’affiche ce programme ?

```dart
void main() {
  final titres = <String>['Lire'];
  final alias = titres;
  alias.add('Coder');
  print('${titres.length}/${alias.length}');
}
```

- [ ] **A.** Erreur : deux variables ne peuvent référencer la même liste.
- [ ] **B.** 1/1
- [ ] **C.** 2/2
- [ ] **D.** 1/2

### Question 23

Qu’affiche ce programme ?

```dart
class Tache {
  final String titre;
  bool terminee = false;
  Tache(this.titre);
}
void main() {
  final source = <Tache>[Tache('A'), Tache('B')];
  final copie = [...source];
  copie.first.terminee = true;
  copie.removeLast();
  print('${source.length}/${copie.length}/${source.first.terminee}');
}
```

- [ ] **A.** 2/2/true
- [ ] **B.** 2/1/false
- [ ] **C.** 1/1/true
- [ ] **D.** 2/1/true

### Question 24

Qu’affiche ce programme ?

```dart
class Tache {
  String titre;
  Tache(this.titre);
}
void main() {
  final originale = <int, Tache>{1: Tache('Lire')};
  final copie = {...originale};
  final t = copie[1];
  if (t != null) { t.titre = 'Coder'; }
  copie.clear();
  print('${originale.length}/${originale[1]?.titre}');
}
```

- [ ] **A.** 1/Coder
- [ ] **B.** 1/Lire
- [ ] **C.** Erreur : les valeurs d’une Map sont toujours const.
- [ ] **D.** 0/null

### Question 25

Ces deux fichiers sont dans le même dossier. Quelle modification minimale permet à main.dart d’afficher Lire ?

**Fichier `tache.dart`**

```dart
class Tache {
  final String titre;
  Tache(this.titre);
}
void main() { print('Modèle'); }
```

**Fichier `main.dart`**

```dart
void main() {
  final t = Tache('Lire');
  print(t.titre);
}
```

- [ ] **A.** Renommer le main de main.dart en Tache.
- [ ] **B.** Ajouter import 'dart:io'; en haut de main.dart.
- [ ] **C.** Ajouter import 'tache.dart'; en haut de main.dart.
- [ ] **D.** Lancer tache.dart à la place de main.dart.

### Question 26

Pourquoi main.dart est-il refusé alors que deck.dart est bien importé ?

**Fichier `deck.dart`**

```dart
class Deck {
  final List<String> _cartes = ['As'];
  int get length => _cartes.length;
}
```

**Fichier `main.dart`**

```dart
import 'deck.dart';
void main() {
  final deck = Deck();
  print(deck._cartes.length);
}
```

- [ ] **A.** Parce que la liste est vide.
- [ ] **B.** Parce que final rend le champ invisible dans tous les fichiers.
- [ ] **C.** Parce que les imports interdisent l’accès à tous les membres de Deck.
- [ ] **D.** Parce que _cartes est privé à la bibliothèque deck.dart, distincte de main.dart.

### Question 27

Quelle relation est décrite par ce code ? Card signifie carte et Deck signifie paquet.

```dart
class Card {
  final String rank;
  final String suit;
  Card(this.rank, this.suit);
}
class Deck {
  final List<Card> cards = [];
}
```

- [ ] **A.** Un Deck contient une liste de Card : c’est une composition.
- [ ] **B.** Card contient automatiquement un Deck.
- [ ] **C.** List<Card> signifie que Card est le nom de la liste.
- [ ] **D.** Deck est automatiquement une sous-classe de Card.

### Question 28

Qu’affiche ce programme ?

```dart
class Card {
  final String suit;
  Card(this.suit);
}
void main() {
  final cards = <Card>[
    Card('coeur'), Card('pique'), Card('coeur'),
  ];
  final hearts = cards.where((c) => c.suit == 'coeur').toList();
  print('${cards.length}/${hearts.length}');
}
```

- [ ] **A.** 1/2
- [ ] **B.** 3/2
- [ ] **C.** 2/2
- [ ] **D.** 3/3

### Question 29

Le paquet contient assez de cartes. Quel contrat correspond à List<Card> deal(int count), si deal doit distribuer count cartes ?

- [ ] **A.** Mélanger le paquet et renvoyer uniquement true ou false.
- [ ] **B.** Afficher count puis renvoyer le paquet complet sans le modifier.
- [ ] **C.** Créer count fois la même carte sans consulter le paquet.
- [ ] **D.** Renvoyer count cartes et les retirer du paquet d’origine.

### Question 30

Qu’affiche ce programme ? Chaque constructeur Deck ajoute une carte à sa propre liste.

```dart
class Card {
  final String rank;
  Card(this.rank);
}
class Deck {
  final List<Card> cards = [];
  Deck() { cards.add(Card('As')); }
}
void main() {
  final a = Deck();
  final b = Deck();
  final alias = a;
  alias.cards.clear();
  print('${a.cards.length}/${b.cards.length}');
}
```

- [ ] **A.** 1/1
- [ ] **B.** 0/1
- [ ] **C.** 0/0
- [ ] **D.** Erreur : un champ final List ne peut pas être vidé.

---

## Corrigé expliqué

Comparer les réponses après avoir terminé le questionnaire. Une réponse correcte doit aussi pouvoir être justifiée avec les mots : classe, instance, champ, constructeur, référence ou copie.

### Réponses rapides

| Question | Réponse | Question | Réponse | Question | Réponse |
| -------- | ------- | -------- | ------- | -------- | ------- |
| 1        | C       | 11       | A       | 21       | B       |
| 2        | A       | 12       | B       | 22       | C       |
| 3        | D       | 13       | B       | 23       | D       |
| 4        | B       | 14       | D       | 24       | A       |
| 5        | D       | 15       | C       | 25       | C       |
| 6        | C       | 16       | A       | 26       | D       |
| 7        | B       | 17       | D       | 27       | A       |
| 8        | A       | 18       | B       | 28       | B       |
| 9        | C       | 19       | A       | 29       | D       |
| 10       | D       | 20       | C       | 30       | B       |

### Correction 1 - Classe, type et instance

**Bonne réponse : C.** Tache est une classe et un type ; travail référence une instance de Tache.

**Explication :** La déclaration class définit le modèle et le type Tache. L’appel Tache(...) construit un objet ; la variable travail contient une référence vers cet objet.

**Pourquoi les autres réponses sont fausses :**

- A : une variable qui référence une instance ne renomme pas sa classe.
- B : créer un objet ne déclare aucune nouvelle classe.
- D inverse le modèle et la variable.

### Correction 2 - Nombre d’objets et alias

**Bonne réponse : A.** Deux.

**Explication :** Les deux appels ordinaires à Joueur(...) créent deux instances. autreNom = lina copie une référence : lina et autreNom désignent le même objet.

**Pourquoi les autres réponses sont fausses :**

- B : déclarer la classe ne crée pas une instance supplémentaire.
- C : Lina et Sami résultent de deux constructions distinctes.
- D : la troisième variable ne déclenche pas de constructeur.

### Correction 3 - Champ, paramètre et variable locale

**Bonne réponse : D.** score est un champ ; points un paramètre ; nouveauScore une variable locale.

**Explication :** score appartient à l’instance. points est reçu à chaque appel de la méthode. nouveauScore est déclaré dans le corps de la méthode et reste local à cet appel.

**Pourquoi les autres réponses sont fausses :**

- A : paramètres et variables locales ne deviennent pas des champs.
- B : un paramètre reçoit un argument ; il ne construit pas Joueur.
- C : une variable locale n’est pas un état commun aux instances.

### Correction 4 - Rôle et déclaration du constructeur

**Bonne réponse : B.** Il initialise l’instance lors de sa création et n’a pas de type de retour.

**Explication :** Tache(this.titre) est un constructeur : il prépare l’objet construit et initialise ici son champ titre. Sa déclaration n’a pas de type de retour, même pas void.

**Pourquoi les autres réponses sont fausses :**

- A : on appelle Tache(...) pour construire, pas une méthode sur une instance.
- C : void ne doit pas précéder ce constructeur.
- D : lire un champ ne reconstruit pas l’objet.

### Correction 5 - Paramètre initialisant avec this

**Bonne réponse : D.** Initialiser le champ titre du nouvel objet avec l’argument reçu.

**Explication :** this.titre est un paramètre initialisant. Il reçoit l’argument nommé titre et initialise le champ de cette instance avant le corps du constructeur.

**Pourquoi les autres réponses sont fausses :**

- A : cette syntaxe ne contient aucun appel à print.
- B : le champ appartient à l’instance, pas à un espace global.
- C : l’argument est affecté au champ ; aucun objet Tache supplémentaire n’est créé.

### Correction 6 - Paramètres nommés, required et défaut

**Bonne réponse : C.** Tache(titre: 'Lire');

**Explication :** titre doit être fourni par son nom. terminee est facultatif et vaut false quand on ne le fournit pas. La ligne C respecte ces deux conditions.

**Pourquoi les autres réponses sont fausses :**

- A oublie le paramètre obligatoire titre.
- B fournit un argument positionnel alors que le constructeur attend des paramètres nommés.
- D est valide mais crée une tâche déjà terminée ; elle ne répond pas à la consigne.

### Correction 7 - required et nullabilité

**Bonne réponse : B.** Joueur(pseudo: null);

**Explication :** required impose de fournir l’argument. String? autorise une chaîne OU null. On peut donc fournir explicitement pseudo: null. Avec String sans ?, null serait refusé.

**Pourquoi les autres réponses sont fausses :**

- A ne fournit pas l’argument obligatoire.
- C fournit un int alors que le type accepté est String?.
- D fournit un argument positionnel ; pseudo est un paramètre nommé.

### Correction 8 - Etat propre à chaque instance

**Bonne réponse : A.** 3/0

**Explication :** Chaque instance possède son champ score. L’appel sur a modifie seulement le score de a. final sur la variable a n’interdit pas de modifier cet objet mutable.

**Pourquoi les autres réponses sont fausses :**

- B inverse le joueur qui reçoit l’appel.
- C confond réaffectation d’une variable et mutation de l’objet référencé.
- D suppose à tort que score est partagé entre les instances.

### Correction 9 - return et print

**Bonne réponse : C.** Rien : la valeur renvoyée n’est pas affichée.

**Explication :** return transmet la chaîne à l’appelant. Ici cette valeur n’est ni conservée ni donnée à print. Pour l’afficher, on écrirait print(t.decrire()).

**Pourquoi les autres réponses sont fausses :**

- A : une méthode peut tout à fait avoir un type de retour String.
- B n’est demandé par aucun appel à print non plus.
- D serait le résultat d’un print de la valeur renvoyée.

### Correction 10 - Expression booléenne dans une méthode

**Bonne réponse : D.** true puis false

**Explication :** Au premier appel, !false && true vaut true. Au second, !true && true vaut false. La méthode lit l’état courant de la même instance à chaque appel.

**Pourquoi les autres réponses sont fausses :**

- A inverse l’effet de la négation !.
- B ne tient pas compte de l’état initial non terminé.
- C oublie que le champ terminee a changé avant le second appel.

### Correction 11 - var et type inféré

**Bonne réponse : A.** Il est refusé : t est de type Tache, pas String.

**Explication :** Le type de t est inféré à partir de Tache(...). var permet une autre affectation compatible avec ce type ; il ne rend pas t dynamic.

**Pourquoi les autres réponses sont fausses :**

- B : Dart n’insère pas cet appel au constructeur à notre place.
- C : t = ... réaffecte la variable ; ce n’est pas une modification de t.titre.
- D confond inférence de type et typage dynamic.

### Correction 12 - Variable final et objet mutable

**Bonne réponse : B.** Il affiche true ; final bloque la réaffectation de t, pas cette mutation.

**Explication :** t reçoit sa référence une fois. L’objet Tache possède un champ modifiable et terminer change ce champ. En revanche, réécrire t = Tache() serait interdit.

**Pourquoi les autres réponses sont fausses :**

- A : final n’annule aucune mutation autorisée par l’objet.
- C : appeler une méthode reste permis.
- D : final ne crée pas de contexte constant et ne change pas le constructeur.

### Correction 13 - Champ final par instance

**Bonne réponse : B.** 1/2 : chaque instance initialise son propre champ une fois.

**Explication :** Le champ final id appartient à chaque instance. a.id reçoit 1 et b.id reçoit 2 lors de leurs constructions. final ne signifie ni global ni partagé.

**Pourquoi les autres réponses sont fausses :**

- A attribue à final un effet de partage qu’il n’a pas.
- C : un paramètre initialisant est précisément une façon valide d’initialiser ce champ.
- D confond deux objets distincts avec un seul objet modifié.

### Correction 14 - final et valeur de liste const

**Bonne réponse : D.** A l’exécution : add est refusé par la liste constante.

**Explication :** La variable est final et la valeur créée est une liste const. La méthode add existe pour le type List<String>, mais cette liste rejette la mutation avec UnsupportedError à l’exécution. Le print n’est pas atteint.

**Pourquoi les autres réponses sont fausses :**

- A : List dispose bien de add ; toutes les instances n’autorisent pas cet ajout.
- B : add ne remplace pas la liste par une copie modifiable.
- C oublie le const placé devant la valeur de liste.

### Correction 15 - final x = const ne déclare pas x const

**Bonne réponse : C.** Non : x est final ; il ne peut pas servir ici de variable constante.

**Explication :** x référence une valeur constante, mais sa déclaration reste final. const y = x exige une expression constante et x n’est pas déclaré const. Avec const x = Etiquette('Urgent'), const y = x serait valide.

**Pourquoi les autres réponses sont fausses :**

- A confond le mot-clé sur l’expression et le mot-clé sur la déclaration.
- B : une valeur final peut être calculée pendant l’exécution.
- D : la classe Etiquette a bien un constructeur constant valide.

### Correction 16 - Contraintes du constructeur const

**Bonne réponse : A.** Le champ terminee est modifiable ; ce constructeur const est incompatible.

**Explication :** Cette classe possède un champ d’instance non final. Le constructeur const exige ici des champs d’instance final. Pour garder une tâche mutable, on retire const du constructeur ; pour un modèle immuable, on adapte les champs.

**Pourquoi les autres réponses sont fausses :**

- B : bool est un type de champ valide.
- C : un constructeur const peut parfaitement recevoir des paramètres.
- D : final n’est pas un modificateur de constructeur.

### Correction 17 - Constructeur const appelé sans const

**Bonne réponse : D.** Il affiche true : cet appel ordinaire accepte une valeur calculée au runtime.

**Explication :** Déclarer le constructeur const autorise des appels constants mais n’impose pas ce mode à chaque appel. Ici l’appel n’a ni const explicite ni contexte constant ; il reçoit donc normalement la chaîne calculée à l’exécution.

**Pourquoi les autres réponses sont fausses :**

- A : le paramètre initialise normalement le champ, sans effacer la valeur.
- B : l’appel ordinaire reste permis.
- C : cette contrainte serait requise pour une construction constante.

### Correction 18 - Identité des constructions constantes

**Bonne réponse : B.** true puis false

**Explication :** Les deux constructions constantes identiques de a et b désignent la même instance canonisée. L’appel ordinaire utilisé pour c crée une autre instance. Avoir les mêmes champs ne suffit pas à avoir la même identité.

**Pourquoi les autres réponses sont fausses :**

- A traite à tort l’appel de c comme constant.
- C oublie la canonisation des valeurs construites comme constantes.
- D inverse la différence entre appel constant et appel ordinaire.

### Correction 19 - Immuabilité et nouvel objet

**Bonne réponse : A.** false/true

**Explication :** terminer renvoie un nouvel Etat(true). Elle ne modifie pas le champ final de depart. arrivee reçoit le nouvel objet et depart conserve son état initial.

**Pourquoi les autres réponses sont fausses :**

- B : une méthode peut appeler un constructeur et renvoyer l’objet créé.
- C ignore l’objet renvoyé par la méthode.
- D confond création d’un nouvel objet et modification de l’ancien.

### Correction 20 - Constructeur nommé et paramètre nommé

**Bonne réponse : C.** brouillon est un constructeur nommé ; titre: fournit un argument nommé.

**Explication :** Tache.brouillon est une entrée de construction identifiée par un nom. Dans Tache(titre: ...), titre désigne un paramètre du constructeur principal. Le constructeur nommé délègue ici au principal avec : this(...).

**Pourquoi les autres réponses sont fausses :**

- A confond nom de constructeur et nom d’argument.
- B : la présence de Tache.brouillon() indique une construction, pas la lecture d’un champ.
- D : Dart autorise plusieurs constructeurs nommés.

### Correction 21 - Collection générique d’instances

**Bonne réponse : B.** List<Tache> attend une Tache, mais add reçoit un String.

**Explication :** Le paramètre générique Tache précise le type des éléments acceptés. Pour cet ajout, on écrirait taches.add(Tache('Lire')). final protège seulement l’affectation de la variable taches.

**Pourquoi les autres réponses sont fausses :**

- A : les listes peuvent contenir des instances de nos propres classes.
- C : une liste littérale ordinaire comme celle-ci peut grandir.
- D confond la référence final et la mutabilité de la liste.

### Correction 22 - Alias d’une liste

**Bonne réponse : C.** 2/2

**Explication :** titres et alias référencent la même liste. L’ajout modifie cette liste unique ; la longueur consultée par les deux variables est donc 2.

**Pourquoi les autres réponses sont fausses :**

- A : partager une référence entre plusieurs variables est autorisé.
- B ignore l’ajout valide sur la liste mutable.
- D suppose une copie de liste qui n’a pas eu lieu.

### Correction 23 - Copie superficielle d’une liste d’objets

**Bonne réponse : D.** 2/1/true

**Explication :** Le spread crée une nouvelle liste, sans cloner les Tache. Retirer un élément de copie ne change pas la longueur de source. En revanche, first désigne la même Tache dans les deux listes : son état devient true.

**Pourquoi les autres réponses sont fausses :**

- A ignore la suppression effectuée dans la liste copie.
- B suppose à tort que le spread a aussi copié chaque Tache.
- C suppose à tort que les deux variables désignent la même liste.

### Correction 24 - Copie de map et valeurs partagées

**Bonne réponse : A.** 1/Coder

**Explication :** Les maps sont différentes, mais leurs valeurs référencent initialement la même Tache. Modifier son titre est visible via originale. clear retire les entrées de copie seulement. L’accès par clé est nullable, d’où le test t != null et la lecture finale avec l’opérateur `?.`.

**Pourquoi les autres réponses sont fausses :**

- B suppose une copie de la Tache qui n’a pas été réalisée.
- C : Map n’impose pas const à ses valeurs.
- D confond les deux conteneurs alors que le spread crée une nouvelle map.

### Correction 25 - Import local et point d’entrée

**Bonne réponse : C.** Ajouter import 'tache.dart'; en haut de main.dart.

**Explication :** L’import relatif rend la classe publique Tache accessible depuis main.dart. On exécute ensuite main.dart. Importer tache.dart ne lance pas son main : le programme corrigé affiche Lire, sans afficher Modèle.

**Pourquoi les autres réponses sont fausses :**

- A ne rend pas la classe définie dans un autre fichier accessible.
- B importe une bibliothèque du SDK, pas notre classe Tache.
- D exécuterait l’autre point d’entrée et afficherait Modèle.

### Correction 26 - Confidentialité à la bibliothèque

**Bonne réponse : D.** Parce que _cartes est privé à la bibliothèque deck.dart, distincte de main.dart.

**Explication :** Le préfixe _ rend le nom privé à la bibliothèque. Ici, deux fichiers reliés par import sont des bibliothèques distinctes. main doit utiliser l’API publique, par exemple deck.length. Dans le fichier unique, la frontière ne séparait pas main et la classe.

**Pourquoi les autres réponses sont fausses :**

- A : la liste contient As et sa taille ne détermine pas la confidentialité.
- B : final concerne l’affectation, pas la visibilité.
- C : la classe publique Deck et son getter public restent accessibles.

### Correction 27 - Composition : un Deck contient des Card

**Bonne réponse : A.** Un Deck contient une liste de Card : c’est une composition.

**Explication :** Le champ cards appartient à chaque Deck et contient des références vers des objets Card. List<Card> est une liste dont le type des éléments est Card. Aucune relation d’héritage n’est déclarée.

**Pourquoi les autres réponses sont fausses :**

- B inverse le sens de la relation décrite.
- C : cards est le nom du champ ; Card est le paramètre de type de List.
- D : la classe Deck ne déclare pas extends Card et représenter un paquet n’en fait pas une carte.

### Correction 28 - Filtrer sans retirer du paquet

**Bonne réponse : B.** 3/2

**Explication :** where sélectionne les cartes qui satisfont la condition et toList matérialise une nouvelle liste. Cette opération ne retire rien de cards. Il reste trois cartes dans la source et deux références dans hearts.

**Pourquoi les autres réponses sont fausses :**

- A confond filtrer et distribuer en retirant les cartes du paquet.
- C suppose une modification de la longueur de la source qui n’a pas eu lieu.
- D ignore le critère suit == coeur.

### Correction 29 - Contrat d’une méthode deal

**Bonne réponse : D.** Renvoyer count cartes et les retirer du paquet d’origine.

**Explication :** Distribuer produit une main contenant count cartes et diminue le paquet de count cartes. Le type List<Card> annonce une liste de cartes en résultat. Le nombre demandé doit être validé avant une modification du paquet.

**Pourquoi les autres réponses sont fausses :**

- A décrit un mélange et renvoie un bool, incompatible avec List<Card>.
- B ne respecte ni la taille du résultat ni le retrait attendu.
- C ne distribue pas les cartes réellement présentes dans le paquet.

### Correction 30 - Synthèse : instances, alias et liste final

**Bonne réponse : B.** 0/1

**Explication :** a et b référencent deux Deck distincts, chacun avec sa propre liste. alias référence le même Deck que a. clear vide donc la liste de a, sans toucher celle de b. final interdit de remplacer la référence du champ, mais n’interdit pas clear sur cette liste mutable.

**Pourquoi les autres réponses sont fausses :**

- A ignore la mutation réalisée via alias.
- C suppose à tort que les deux Deck partagent leur liste d’instance.
- D confond un champ final vers une liste mutable avec une liste const.

## Les idées à savoir expliquer avant le deck

- Une classe définit un type et un modèle ; un constructeur permet de créer une instance.
- Deux instances ordinaires ont des états indépendants ; deux variables peuvent aussi référencer la même instance.
- Un champ appartient à l’objet ; un paramètre reçoit un argument ; une variable locale appartient à l’exécution d’une fonction ou méthode.
- `required` impose de fournir l’argument ; `?` détermine si `null` est accepté.
- `return` transmet une valeur ; `print` l’affiche.
- `var` infère un type ; il ne signifie pas `dynamic`.
- `final` interdit la réaffectation de la variable. Il ne rend pas automatiquement l’objet immuable.
- Dans `final x = const ...`, la variable reste `final` et la valeur construite est constante.
- Un constructeur `const` peut aussi être appelé sans construction constante.
- Copier une liste ou une map avec le spread copie le conteneur, pas les objets contenus.
- `_nom` est privé à la bibliothèque ; les imports relient ici des bibliothèques distinctes.
- Un `Deck` contient des `Card` : c’est une composition. Filtrer sélectionne ; distribuer retire aussi les cartes données.

## Références officielles

Les questions et leurs explications sont originales. Les règles du langage sont vérifiées avec la documentation Dart :

- [Classes, membres et identité](https://dart.dev/language/classes)
- [Constructeurs et constructions constantes](https://dart.dev/language/constructors)
- [Variables, références, final et const](https://dart.dev/language/variables)
- [Types génériques](https://dart.dev/language/generics)
- [Bibliothèques et imports](https://dart.dev/language/libraries)
- [Collections et copies](https://dart.dev/language/collections)
