# B02 - Ouvrir la fiche correspondant au résultat choisi

## Objectif

Cliquer sur un artisan doit toujours ouvrir sa propre fiche, quelle que soit la recherche ou le filtre utilisé.

## Avant de commencer

- B01 validé, ou utilisation d’une vue suffisamment large pour accéder aux actions.
- Catalogue avec les personnes de démonstration : Gérard, Sophie, Pierre, Lina, Sami et Aya.
- Revenir au catalogue avant chaque essai.

## Processus pour reproduire le problème

1. Effacer la recherche et désactiver « Favoris uniquement ».
2. Saisir « Sophie » dans la recherche.
3. Vérifier que le résultat présenté est bien Sophie, en électricité, au tarif de 80 € par heure.
4. Cliquer sur « Voir la fiche » de ce résultat.
5. Lire le nom, le métier et le tarif affichés sur la fiche.
6. Revenir au catalogue et recommencer avec « Pierre », puis avec « Électricité ».

## Ce que l’on observe dans la version de départ

Après une recherche, la fiche ouverte peut être celle d’un autre artisan. Par exemple, choisir Sophie peut ouvrir Gérard. Le catalogue semble correct, mais l’écran suivant ne correspond pas au choix.

## Résultat attendu

- La fiche présente toujours le nom, le métier et le tarif de la carte sélectionnée.
- La recherche par nom et la recherche par métier conduisent au même professionnel quand elles désignent la même personne.
- Le retour au catalogue fonctionne et permet de choisir une autre fiche.

## Vérification : si je fais ceci, alors…

| Si je fais ceci… | Alors je dois observer… | Résultat |
| --- | --- | --- |
| Je recherche Sophie puis j’ouvre son résultat. | Je vois Sophie, Électricité, 80 € par heure. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je recherche Pierre puis j’ouvre son résultat. | Je vois Pierre, Carrelage, 95 € par heure. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je recherche Électricité puis j’ouvre Sophie. | Je vois la même fiche Sophie que lors de la recherche par son nom. | ☐ OK / ☐ KO / ☐ Bloqué |
| J’efface la recherche puis j’ouvre Gérard. | Je vois Gérard, Plomberie, 65 € par heure. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je reviens au catalogue puis j’ouvre une autre personne. | La nouvelle fiche correspond à ce second choix, sans conserver les informations de la précédente. | ☐ OK / ☐ KO / ☐ Bloqué |
| Plus tard, avec les favoris fonctionnels, je filtre sur un seul artisan puis j’ouvre sa fiche. | Je vois la personne affichée dans ce résultat filtré, même si elle n’était pas la première dans le catalogue complet. | ☐ OK / ☐ KO / ☐ Bloqué |

## Quand considérer la fiche comme terminée ?

- [ ] Les essais Sophie et Pierre réussissent après recherche.
- [ ] Le nom, le métier et le tarif concordent à chaque passage carte → fiche.
- [ ] Le contrôle avec « Favoris uniquement » sera également refait après B04.
- [ ] J’ai conservé une preuve avant/après du scénario et indiqué le support utilisé.
- [ ] J’ai refait le scénario de reproduction complet après ma modification.


---

[Revenir au parcours](README.md) · [Fiche précédente](01_B01_affichage_des_cartes.md) · [Fiche suivante](03_B03_reaction_des_favoris.md)
