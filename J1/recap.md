# Résumé de J1 - Dart

## Exécuter, afficher, calculer

`main()` est le point d'entrée. `print(2 + 3)` affiche `5` ;
`print('2 + 3')` affiche le texte. Une expression produit une valeur.
`return` transmet une valeur à l'appelant ; il ne l'affiche pas.

## Variables et types

`String` représente du texte, `int` un entier, `double` un nombre à virgule
et `bool` une valeur `true` ou `false`. `var` laisse Dart inférer le type :
`var score = 10` donne un `int`, pas une variable acceptant n'importe quel type.
`int.parse` convertit un texte valide ; `int.tryParse` renvoie `null` si la
conversion échoue. `=` affecte une valeur ; `==` compare deux valeurs.

## Logique

`&&` signifie ET, `||` signifie OU et `!` inverse un booléen.
La condition de `if` est un `bool`. Les comparaisons comme `score >= 20`
produisent des booléens. Une valeur calculée ne se recalcule pas toute
seule quand une autre variable change.

## Fonctions

Une déclaration décrit le travail à faire ; un appel déclenche ce travail.
Les paramètres sont les variables de la déclaration ; les arguments sont
les valeurs fournies à l'appel. `void` indique l'absence de résultat utile.
Une variable déclarée dans une fonction est locale à celle-ci.

## Classes et instances

Une classe définit un type et un modèle. Une instance est un objet créé
à partir de ce modèle. Les champs décrivent son état et les méthodes
ses comportements. Deux instances ordinaires peuvent avoir des états
indépendants. Deux variables peuvent aussi référencer le même objet.

Le constructeur initialise une instance. Il porte le nom de la classe
et ne déclare pas de type de retour. `this.titre` dans un constructeur
initialise directement le champ avec l'argument reçu.

Les accolades introduisent des paramètres nommés. `required` impose de
fournir l'argument ; il n'interdit pas `null` si le type porte `?`.
Un constructeur nommé comme `Tache.copie(...)` est différent d'un
argument nommé comme `titre: 'Lire'`.

## var, final et const

| Ecriture | Ce qu'elle permet ou interdit |
| --- | --- |
| `var x = Tache(...)` | Le type est inféré ; x peut recevoir une autre Tache |
| `final x = Tache(...)` | x ne change plus de référence ; la tâche peut rester mutable |
| `final liste = <String>[]` | La référence est fixe ; add et remove restent possibles |
| `const liste = <String>[]` | Variable constante et liste non modifiable |
| `var liste = const <String>[]` | La première liste est constante ; la variable peut être réaffectée |
| `final x = const Etiquette(...)` | Variable final vers une valeur constante ; x n'est pas déclaré const |

Un constructeur `const` permet une construction constante mais peut aussi
être appelé normalement avec une valeur connue seulement à l'exécution.
Des champs `final` ne garantissent pas une immuabilité profonde si l'un
d'eux référence par exemple une liste mutable.

## Listes, maps et types génériques

`List<Tache>` précise le type des éléments. `Map<int, Tache>` précise le
type des clés et des valeurs. Les paramètres entre `<...>` décrivent des
types, pas un nombre d'éléments. Une liste utilise des index à partir de 0 ;
un identifiant métier n'est pas automatiquement un index.

`map[id]` peut renvoyer `null` si la clé manque. `where` sélectionne les
éléments répondant à une condition ; `toList` crée une liste du résultat.

## Références et copies

- `alias = source` : même objet partagé.
- `copie = [...source]` ou `List.of(source)` : autre liste, mêmes éléments.
- `copie = {...source}` ou `Map.of(source)` : autre map, mêmes valeurs.
- Pour isoler des objets mutables, reconstruire aussi les objets concernés.
- Une fonction reçoit une copie de la référence : modifier l'objet partagé
  est visible par l'appelant ; réaffecter le paramètre ne réaffecte pas sa variable.

Une liste non modifiable protège sa structure. Elle ne rend pas ses éléments
mutables automatiquement immuables.

## Imports et confidentialité

`import 'tache.dart';` importe un fichier voisin ; `import 'dart:io';`
importe une bibliothèque du SDK. Un import ne lance pas le `main` du fichier
importé. Un import simple ne réexporte pas tous les imports du fichier.
Un nom préfixé par `_` est privé à sa bibliothèque, pas seulement à sa classe.

## Erreurs et asynchrone

`throw` signale une erreur. `try/catch` traite une erreur attendue et
`finally` termine une tentative en réussite comme en échec.
Une fonction `async` renvoie un `Future`. `await` suspend cette fonction
jusqu'au résultat ou à l'erreur sans bloquer tout le moteur Dart.

## Liens avec les ateliers

`Deck` contient des `Card` et `Carnet` contient des `Tache` : c'est une
composition. Filtrer ne retire rien de la source. Distribuer retire les
cartes données. Dans le CLI, séparer les règles des objets des fonctions
de saisie permet de vérifier le carnet sans utiliser le clavier.

## Documentation

- [Variables](https://dart.dev/language/variables)
- [Classes](https://dart.dev/language/classes)
- [Constructeurs](https://dart.dev/language/constructors)
- [Collections](https://dart.dev/language/collections)
- [Génériques](https://dart.dev/language/generics)
- [Imports](https://dart.dev/language/libraries)
- [Asynchrone](https://dart.dev/libraries/async/async-await)
