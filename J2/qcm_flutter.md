# QCM — Flutter : fil rouge HelpMe

## Consigne

30 questions, une seule bonne réponse par question. Notez le numéro et la lettre choisie. Les extraits sont pédagogiques : les imports et la structure complète ne sont pas répétés.

Les exemples supposent une interface en français, de gauche à droite, sauf indication contraire.

## Question 1

Quel est le rôle de Dart dans notre projet HelpMe ?

- **A.** C’est le langage dans lequel nous écrivons le code.
- **B.** C’est uniquement le simulateur iPhone.
- **C.** C’est une base de données.
- **D.** C’est le nom de notre écran.

## Question 2

Que fait `runApp(const MonApp())` ?

- **A.** Il lance uniquement le simulateur.
- **B.** Il confie le widget racine à Flutter pour démarrer l’interface.
- **C.** Il crée automatiquement un compte utilisateur.
- **D.** Il affiche un message dans le terminal.

## Question 3

Quelle instruction affiche un texte dans l’interface ?

- **A.** `console('Bonjour')`
- **B.** `String('Bonjour')`
- **C.** `Text('Bonjour')`
- **D.** `print('Bonjour')`

## Question 4

Quelle structure convient pour démarrer notre écran ?

- **A.** `Scaffold → runApp → main`
- **B.** `Text → import → MaterialApp`
- **C.** `MonApp → String → Scaffold`
- **D.** `MonApp → MaterialApp → Scaffold`

## Question 5

Pourquoi éviter de nommer notre propre classe `MaterialApp` ?

- **A.** Une classe Flutter doit obligatoirement être privée.
- **B.** Toute classe personnalisée doit commencer par Flutter.
- **C.** Ce nom est un mot réservé du langage Dart.
- **D.** Elle masque le nom de la classe fournie par Flutter.

## Question 6

Que peut recevoir le paramètre `body` de `Scaffold` ?

- **A.** Une liste brute de chaînes de caractères.
- **B.** Uniquement une classe StatefulWidget.
- **C.** Un widget, par exemple une Column ou un Text.
- **D.** Obligatoirement une fonction main.

## Question 7

Quel est l’intérêt principal de `TitreSection extends StatelessWidget` ?

- **A.** Stocker automatiquement les titres sur disque.
- **B.** Créer un type de widget qui décrit une portion de l’interface.
- **C.** Exécuter build une seule fois pour toujours.
- **D.** Empêcher tout changement de titre pendant l’exécution.

## Question 8

Un `StatelessWidget` peut-il afficher un nouveau titre transmis par son parent ?

- **A.** Oui, il peut se reconstruire avec une nouvelle configuration.
- **B.** Non, car ses champs doivent être des variables globales.
- **C.** Non, son affichage est définitivement figé.
- **D.** Oui, mais seulement après désinstallation.

## Question 9

Dans `TitreSection({required this.titre})`, que signifie `required` ?

- **A.** L’appelant doit fournir le paramètre nommé titre.
- **B.** Le titre doit être identique dans tous les objets.
- **C.** Le titre doit obligatoirement être une constante.
- **D.** Le constructeur ne peut être appelé que dans main.

## Question 10

Comment sait-on que `children` est un paramètre nommé du constructeur de Column ?

- **A.** Il reçoit une liste.
- **B.** Il commence par une lettre minuscule.
- **C.** Il figure entre accolades dans la signature du constructeur.
- **D.** Il apparaît toujours en dernière position.

## Question 11

Quel appel de `Text` est correct ?

- **A.** `Text(style: 'Gérard')`
- **B.** `Text('Gérard', fontSize: 22)`
- **C.** `Text(data: 'Gérard')`
- **D.** `Text('Gérard', style: TextStyle(fontSize: 22))`

## Question 12

Quel ordre peut changer sans modifier le résultat d’une Column ?

- **A.** L’ordre d’un titre et d’un espace dans children.
- **B.** L’ordre des paramètres nommés children et crossAxisAlignment.
- **C.** L’ordre du nom et du métier dans children.
- **D.** L’ordre des widgets dans children.

## Question 13

Dans `Column(children: [TitreSection(titre: "Artisans")])`, quel est le parent direct de TitreSection dans la composition écrite ?

- **A.** Le constructeur de Text.
- **B.** Column.
- **C.** String.
- **D.** StatelessWidget.

## Question 14

Que fait la méthode `build()` d’un widget ?

- **A.** Elle compile directement le projet en application iOS.
- **B.** Elle est appelée uniquement quand nous écrivons print.
- **C.** Elle sauvegarde automatiquement toutes les données.
- **D.** Elle décrit l’interface en retournant un widget.

## Question 15

Quel est l’axe principal d’une Column ?

- **A.** Il n’existe pas d’axe principal.
- **B.** L’axe horizontal.
- **C.** L’axe vertical.
- **D.** L’axe dépend uniquement du texte.

## Question 16

Dans notre interface en français, que fait `crossAxisAlignment: CrossAxisAlignment.start` dans une Column ?

- **A.** Il aligne ses enfants directs à gauche dans sa largeur.
- **B.** Il place tous les enfants en haut du téléphone.
- **C.** Il étire tous les textes à la hauteur de l’écran.
- **D.** Il change l’ordre de la liste children.

## Question 17

Dans une Row, sur quel axe agit crossAxisAlignment ?

- **A.** Sur l’axe du défilement uniquement.
- **B.** Sur l’axe horizontal.
- **C.** Sur la taille de la police.
- **D.** Sur l’axe vertical.

## Question 18

Une Column reçoit toute la hauteur disponible. Sans Expanded autour des cartes, que font ses trois cartes par défaut ?

- **A.** Elles se répartissent automatiquement avec des espaces égaux.
- **B.** Elles prennent leur hauteur nécessaire et se placent en haut.
- **C.** Elles prennent automatiquement un tiers de la hauteur chacune.
- **D.** Elles se superposent.

## Question 19

Que produit cet extrait ?

```dart
Column(children: [
  Text("Gérard"),
  SizedBox(height: 16),
  Text("Plomberie"),
])
```

- **A.** Un espace vertical de 16 pixels logiques entre les deux textes.
- **B.** Une marge horizontale de 16 autour du texte.
- **C.** Une police de taille 16 pour les deux textes.
- **D.** Un espace de 16 après tous les enfants.

## Question 20

Dans la Row de la carte, pourquoi utiliser `SizedBox(width: 12)` après l’avatar ?

- **A.** Pour ajouter 12 lettres au nom.
- **B.** Pour augmenter la hauteur de l’avatar de 12.
- **C.** Pour réserver un espace horizontal entre l’avatar et les textes.
- **D.** Pour espacer automatiquement toutes les cartes.

## Question 21

Dans notre carte, comment ajouter de l’espace intérieur autour de la Row ?

- **A.** `CrossAxisAlignment.start`
- **B.** `TextStyle(fontSize: 16)`
- **C.** `Padding(padding: EdgeInsets.all(16), child: Row(...))`
- **D.** `Expanded(flex: 16, child: Row(...))`

## Question 22

Que fait Expanded autour de la Column de textes dans une Row de largeur limitée ?

- **A.** Il augmente automatiquement la taille des lettres.
- **B.** Il transforme la Column en liste défilante.
- **C.** Il remplit la hauteur restante de tout l’écran.
- **D.** Il attribue à la zone des textes la largeur restante, s’il est le seul enfant flexible.

## Question 23

Que remplit Expanded lorsqu’il est utilisé comme enfant d’une Column de hauteur limitée ?

- **A.** La part de hauteur restante qui lui est attribuée.
- **B.** La taille du texte en pixels.
- **C.** Uniquement la marge extérieure.
- **D.** Toujours toute la largeur de l’écran.

## Question 24

Une Row dispose de 300 pixels logiques après mesure de ses enfants non flexibles. Elle contient deux Expanded de flex 2 et 1. Quelles largeurs reçoivent-ils ?

- **A.** 300 et 300.
- **B.** 200 et 100.
- **C.** 150 et 150.
- **D.** 2 et 1.

## Question 25

On appelle `TitreSection(titre: "Artisans")` puis `TitreSection(titre: "Favoris")`. Que représente ce code ?

- **A.** Une seule instance dont le titre est nécessairement écrasé.
- **B.** Deux variables globales créées automatiquement.
- **C.** Deux classes différentes portant le même nom.
- **D.** Deux instances du même type, avec des configurations différentes.

## Question 26

Quelle différence existe entre une fonction retournant Text et une classe TitreSection extends StatelessWidget ?

- **A.** La classe ajoute un widget TitreSection distinct dans l’arbre ; la fonction retourne directement son résultat.
- **B.** La classe ne peut jamais être réutilisée.
- **C.** Une fonction ne peut recevoir aucun paramètre.
- **D.** Seule la fonction peut afficher du texte.

## Question 27

Dans `_MonEcranState extends State<MonEcran>`, comment lire le champ title déclaré dans MonEcran ?

- **A.** `State.title`
- **B.** `this.title` si aucun champ title n’est déclaré dans le State.
- **C.** `widget.title`
- **D.** `parent.title`

## Question 28

Qu’appelle-t-on prop drilling dans notre exemple HelpMe ?

- **A.** Recharger le simulateur après chaque frappe.
- **B.** Lire automatiquement toutes les variables des widgets ancêtres.
- **C.** Hériter de plusieurs classes à la fois.
- **D.** Transmettre des données par constructeurs à travers plusieurs niveaux de widgets.

## Question 29

Le titre est fourni directement dans main : `runApp(const MonApp(title: "Avant"));`. On remplace Avant par Après, mais le hot reload conserve le titre. Que faire ?

- **A.** Ajouter un SizedBox autour du titre.
- **B.** Effectuer un Hot Restart pour réexécuter main.
- **C.** Modifier la résolution du simulateur.
- **D.** Supprimer systématiquement tous les const.

## Question 30

Prédiction : la Row ci-dessous a une largeur disponible limitée. Où se placent les textes ?

```dart
Row(children: [
  Icon(Icons.person),
  Expanded(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [Text("Gérard"), Text("Plomberie")],
    ),
  ),
  Icon(Icons.chevron_right),
])
```

- **A.** À droite de la zone centrale restante, avant la dernière icône.
- **B.** Tout en bas du téléphone.
- **C.** Au centre de l’avatar.
- **D.** Après la dernière icône, hors de la Row.
