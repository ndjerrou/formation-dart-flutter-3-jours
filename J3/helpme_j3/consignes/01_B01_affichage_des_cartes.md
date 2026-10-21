# B01 - Les cartes restent lisibles sur un petit écran

## Objectif

Le catalogue doit rester utilisable lorsque la place disponible diminue. Une carte doit montrer le nom, le métier, le tarif et ses actions sans dépasser la zone affichée.

## Avant de commencer

- Application lancée en mode debug, interface en français et catalogue visible.
- Sur Chrome, utiliser la vue mobile des outils du navigateur : essayer une largeur de 390, puis de 320, avec un zoom de page à 100 %. Il s’agit de la largeur de la vue, pas de la résolution physique de l’écran.
- Sur un simulateur, commencer en portrait. Si le défaut est peu visible, utiliser Chrome avec la largeur de 320 pour le reproduire de manière constante.

## Processus pour reproduire le problème

1. Afficher le catalogue sans recherche ni filtre.
2. Observer la première carte et repérer ses informations et ses actions.
3. Passer d’une vue large à une largeur de 390, puis de 320.
4. Faire défiler pour observer plusieurs cartes, pas uniquement la première.
5. Noter les zones qui dépassent, disparaissent ou deviennent difficiles à toucher. Conserver une capture.

## Ce que l’on observe dans la version de départ

Des bandes jaunes et noires peuvent apparaître sur le bord de certaines cartes en vue étroite. L’affichage ne tient plus correctement dans la place disponible. Une vue large peut masquer le problème.

## Résultat attendu

- Les informations et les actions des cartes tiennent dans la largeur de la vue.
- Le nom et le métier peuvent passer sur plusieurs lignes si nécessaire, tout en restant lisibles.
- Le catalogue défile verticalement et les actions restent accessibles.
- Le résultat reste correct quand on revient à une vue large.

## Vérification : si je fais ceci, alors…

| Si je fais ceci… | Alors je dois observer… | Résultat |
| --- | --- | --- |
| J’affiche le catalogue en largeur 320. | Je ne vois plus de bandes jaunes et noires sur les cartes. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je passe de 320 à 390 puis à une vue large. | Les cartes s’adaptent et les textes ne passent pas sur les boutons. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je fais défiler jusqu’à la dernière carte. | Toutes les cartes restent lisibles ; aucune action n’est coupée au bord de la vue. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je touche le cœur ou le bouton de fiche. | La zone de l’action est accessible. Les défauts de favoris ou de navigation sont traités dans leurs propres fiches. | ☐ OK / ☐ KO / ☐ Bloqué |
| J’agrandis le texte puis je parcours le catalogue. | Les informations essentielles restent accessibles, même si une carte prend davantage de hauteur. | ☐ OK / ☐ KO / ☐ Bloqué |

## Quand considérer la fiche comme terminée ?

- [ ] Les contrôles de largeur ont été réalisés sur plusieurs cartes.
- [ ] Le contenu et les actions utiles sont toujours présents.
- [ ] Les bandes de débordement ont disparu dans les conditions testées.
- [ ] J’ai conservé une preuve avant/après du scénario et indiqué le support utilisé.
- [ ] J’ai refait le scénario de reproduction complet après ma modification.


---

[Revenir au parcours](README.md) · [Fiche suivante](02_B02_ouvrir_la_bonne_fiche.md)
